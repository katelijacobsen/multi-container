# Foodhead in containers – gennemgang, begreber og talescript

Præsentation: E26 Development Environments, 09.10.2026
Slides: https://www.figma.com/slides/kE3EiWaNJ6XrHWhtZ6B4fZ

> Gennemgangen bygger på kravene på dit slide **"02 The brief – Content"**. Jeg havde ikke selve opgaveteksten, så tjek lige, om der står krav i den originale opgave, som ikke er med på slidet.

---

## 1. Lever projektet op til kravene?

Jeg har tjekket det mod den kørende stack i dag (8. okt.):

| Krav fra opgaven | Hvordan du løser det | Tjekket i dag |
| --- | --- | --- |
| Containerise an existing app | Foodhead (Flask + MariaDB) fra 1. semester, bygget fra `Dockerfile` | `foodhead_web` svarer HTTP 200 på `127.0.0.1:80` ✅ |
| A database | `mariadb:10.6.20` med sin egen app-bruger fra `.env` | `(healthy)` i `docker compose ps` ✅ |
| Docker volumes | Named volume `foodhead-mariadb-data` + bind mount `.:/app` + `foodhead.sql` som `:ro` | Volume findes ✅ |
| A named network | `foodhead-net` (bridge) | Netværket findes ✅ |
| Efficient image | To stages på `python:3.12-alpine`, 368 MB → 197 MB | `docker images` viser 197 MB ✅ |
| Secure image | `USER appuser` (uid 1000), DB-porten er ikke published, porte kun på 127.0.0.1, passwords i `.env` | `uid=1000(appuser)` ✅ |
| Limit CPU and memory | `deploy.resources.limits` på alle tre services | web 30/256 MiB, mariadb 72/512 MiB, pma 32/256 MiB ✅ |
| README | 10 nummererede sektioner + troubleshooting | ⚠️ Se punkt 1–2 herunder |

**Konklusion:** Alle krav er dækket, og argumentationen i README'en er stærk, især afsnittet "Being honest about it". Der er dog et par ting, du bør rette før i morgen, fordi en underviser kan finde dem.

### Ting jeg ville rette før præsentationen (vigtigste først)

1. **Billederne i README'en virker ikke.** `README.md` linker til `image.png` og `image%201.png` (linje 93 og 132), men filerne findes ikke i repoet. På GitHub, som dit QR-kode-slide peger på, vises de som ødelagte billeder. Læg billederne ind, eller fjern linkene.
2. **Stavefejl og en halv sætning i README'en:** "I mad webe" (l. 15), "while My app" (l. 42), "I t" (l. 48, sætningen stopper midt i), "privat" (l. 183), overskriften "5. configured Docker" (l. 122).
3. **FLASK_DEBUG er ikke "off by default" i Compose.** Dit Security-slide og README'en siger "Debug off in the image, on only via FLASK_DEBUG". Men i `docker-compose.yml` står `FLASK_DEBUG: ${FLASK_DEBUG:-1}`. Uden værdien i `.env` slår Compose altså debug **til**. Det er dermed kun selve image'et, der er "off by default". Ret til `${FLASK_DEBUG:-0}`, så slide og kode siger det samme.
4. **Pin phpMyAdmin.** `phpmyadmin/phpmyadmin` er reelt `:latest`. Den version, der kører hos dig, er **5.2.3**, og det er også den version, der lavede `foodhead.sql`. Skriv `phpmyadmin/phpmyadmin:5.2.3`, så kan du flytte punktet fra "next steps" til "done".
5. **En kommentar i Dockerfilen passer ikke:** ved `CMD` står der noget om et "wrapper script" og `ENTRYPOINT`, men den slags findes ikke i projektet. Der er også småfejl som "Enviroment", "isntructions", "form builder" og "standart". Underviseren læser måske Dockerfilen.
6. **Lav en test med et frisk clone, inden du går op.** Dine `container_name` og dit volume-navn er faste. Kør derfor `docker compose down` på den nuværende stack først, ellers støder navnene sammen. Klon derefter repoet til en ny mappe og følg din egen Quick start.

Mindre ting, som du ikke behøver rette, men som du skal kunne svare på: `icecream` er et debug-bibliotek, der ryger med i image'et; `Flask-Session` er ikke pinned; uploads ligger i Git.

---

## 2. Begreberne forklaret

**Image:** en skrivebeskyttet "skabelon" med OS-filer, Python, pakker og din kode. Den bygges fra en `Dockerfile`.

**Container:** en kørende instans af et image. Den får sit eget skrivbare lag oven på image'et, sin egen proces-tabel og sit eget netværk. Når du sletter containeren, forsvinder data, der ikke ligger i et volume.

**Layer og build cache:** hver instruktion i Dockerfilen (`RUN`, `COPY` …) giver et lag. Hvis et lag og alt før det er uændret, genbruger Docker det fra cachen. Derfor kopierer du `requirements.txt` *før* koden: pakker bliver kun geninstalleret, når requirements ændrer sig.

**Build context og `.dockerignore`:** build context er mappen, der sendes til Docker ved build (`context: .`). `.dockerignore` holder `.git`, `.env`, caches m.m. ude. Det giver et mindre image, et hurtigere build og ingen hemmeligheder i image'et.

**Base image (`python:3.12-alpine` vs `-slim`):** Alpine er en meget lille Linux-distribution, der bruger musl i stedet for glibc. Den er mindre, men nogle pakker skal kompileres eller opfører sig anderledes. Slim er Debian-baseret, større og mere kompatibel.

**Multi-stage build:** flere `FROM` i én Dockerfile. `builder`-stagen installerer pakker i et venv, og `runtime`-stagen kopierer kun resultatet med `COPY --from=builder`. Værktøjer og cache fra builder-stagen kommer ikke med i det færdige image. `target: runtime` i Compose vælger, hvilken stage der bygges til.

**Virtual environment (`/opt/venv`):** en isoleret Python-installation. Den ligger uden for `/app`, fordi bind mountet `.:/app` ellers ville skjule de installerede pakker.

**Non-root user / UID:** `adduser -u 1000 appuser` + `USER appuser`. Processen kører med uid 1000 i stedet for 0 (root). Hvis nogen bryder ind i appen, har de ikke root-rettigheder i containeren.

**Rootless mode:** noget andet end non-root! Rootless betyder, at selve Docker-daemonen kører uden root. Det gør Docker Desktop ikke hos dig, og det siger du ærligt.

**`EXPOSE` vs `ports`:** `EXPOSE 5000` er kun dokumentation ("appen lytter på 5000"). Det er `ports:` i Compose, der faktisk *publicerer* en port til din computer.

**Port mapping `127.0.0.1:80:5000`:** formatet er `host-ip:host-port:container-port`. Browseren rammer port 80 på din computer, og Docker sender trafikken videre til port 5000 i containeren. `127.0.0.1` betyder, at kun din egen maskine kan få adgang, ikke andre på samme Wi-Fi.

**Docker Compose:** et værktøj, der beskriver flere containere (services), netværk og volumes i én YAML-fil og starter det hele med `docker compose up`. Det er "infrastructure as code" for udviklingsmiljøet.

**Service:** en container-definition i Compose (`web`, `mariadb`, `phpmyadmin`). Servicenavnet bliver også containerens DNS-navn på netværket.

**User-defined bridge network (`foodhead-net`):** et privat, virtuelt netværk. Containere på et user-defined netværk kan finde hinanden via navn (indbygget DNS), og derfor er `DB_HOST=mariadb` nok. `name: foodhead-net` giver et fast navn i stedet for `multi-container_foodhead-net`.

**Named volume (`foodhead-mariadb-data`):** lagerplads, som Docker administrerer. Den overlever `docker compose down` og rebuilds og slettes kun med `down -v`. Den bruges til databasen, fordi den skal være vedvarende og ydedygtig.

**Bind mount (`.:/app`):** en mappe fra din computer, der mountes direkte ind i containeren. Ændringer ses med det samme, hvilket er perfekt til udvikling. Ulempen er, at containeren kører koden fra din disk og ikke koden i image'et.

**`docker-entrypoint-initdb.d`:** en mappe i MariaDB-image'et. `.sql`-filer, der ligger der, køres automatisk, men **kun når datamappen er tom**, altså første gang volumet oprettes. `:ro` betyder read-only.

**Healthcheck:** en kommando, som Docker kører med jævne mellemrum for at se, om servicen er *klar* og ikke bare startet. MariaDB-image'et har `healthcheck.sh` med i forvejen. `--connect` tjekker, om man kan forbinde, og `--innodb_initialized` tjekker, om storage-motoren er klar.

**`depends_on` + `condition: service_healthy`:** `web` og `phpmyadmin` starter først, når `mariadb` er *healthy*. Uden betingelsen venter `depends_on` kun på, at containeren er startet.

**Environment variables og `.env`:** Compose læser `.env` automatisk og indsætter værdierne i `${VAR}`. `${FLASK_DEBUG:-1}` betyder "brug FLASK_DEBUG, og ellers 1". Appen læser dem med `os.environ`.

**Resource limits (`deploy.resources.limits`):** et loft over CPU og RAM per container, håndhævet af Linux-kernens cgroups. `cpus: "0.50"` svarer til en halv CPU-kerne. Hvis memory-loftet overskrides, bliver containeren dræbt (OOM-kill).

**`PYTHONUNBUFFERED` / `PYTHONDONTWRITEBYTECODE`:** den første sender print/logs direkte til `docker logs`. Den anden stopper Python i at skrive `__pycache__/*.pyc`, hvilket er relevant med et bind mount, fordi filerne ellers ender i din projektmappe.

---

## 3. Argumentation for valgene

Struktur til hvert valg: **Hvad → Hvorfor → Alternativ → Trade-off.**

| Valg | Hvorfor | Alternativ jeg fravalgte | Trade-off |
| --- | --- | --- | --- |
| Compose med 3 services | Én kommando starter hele miljøet; ens for alle, der kloner | 3 × `docker run` med flags | Mere YAML, men dokumenteret og reproducerbart |
| `python:3.12-alpine` | Mindste base; 368 → 197 MB | `3.12-slim` (testet: 372 MB) | musl kan give problemer med pakker, der skal kompileres |
| Multi-stage | Kun venv'et kommer med i runtime; mønstret er klar, når en pakke skal kompileres | Én stage | Gevinsten er lille *her* (ærligt: Alpine er det, der sparer pladsen) |
| `requirements.txt` kopieres først | Layer cache, så hurtige rebuilds | `COPY . .` først | Ingen |
| venv i `/opt/venv` | Bliver ikke skjult af bind mountet på `/app` | `pip install` globalt i `/app` | Ingen reel |
| `USER appuser` (uid 1000) | Least privilege; et brud giver ikke root | Kør som root (default) | Ejerskab af filer skal passe (jf. din Permission denied-historie) |
| Port 5000 i containeren | Flasks standard; porte under 1024 kræver traditionelt root | Port 80 i containeren | Ingen, mapping klarer resten |
| Porte på `127.0.0.1` | Debug-mode kan køre kode via browseren, så det skal kun være lokalt | `"80:5000"` (alle interfaces) | Andre enheder kan ikke teste; løses med ngrok |
| DB-port ikke published | Kun web og pma skal bruge den, og de går via netværket | `3306:3306` | Du kan ikke bruge en DB-klient på din PC; det klarer phpMyAdmin |
| `mariadb:10.6.20` pinned | Samme version som dumpet blev lavet i; reproducerbart | `mariadb:latest` | Manuelle opdateringer |
| Egen DB-bruger | Appen kan kun røre `foodhead`-databasen | Root-brugeren | En variabel mere i `.env` |
| Named volume til DB | Data overlever `down`/rebuild; Docker styrer det | Bind mount til `/var/lib/mysql` | Sværere at se filerne direkte |
| Bind mount `.:/app` | Live reload under udvikling | Kopiér kun koden ind i image'et | Ikke til produktion; `.env` er synlig i containeren |
| Seed via `initdb.d` | Ingen manuel import; virker fra et frisk clone | Importér manuelt i phpMyAdmin | Kører kun på et tomt volume (ingen migrations) |
| Healthcheck + `service_healthy` | Undgår "Database under maintenance" ved opstart | Retry-loop i Python / `sleep` | Opstarten tager et par sekunder længere |
| Resource limits | Én service kan ikke æde hele maskinen; tvinger mig til at måle forbrug | Ingen limits | Limits sat ud fra idle-målinger, ikke under load |
| Fast netværks-/containernavn | Læsbare kommandoer (`docker top foodhead_web`) | Compose' auto-navne | `container_name` gør, at man ikke kan bruge `--scale web=2` |
| Secrets i `.env` (gitignored) + `.env.example` | Ingen passwords på GitHub | Hardcode i compose | Ét manuelt setup-trin |

### Multi-container-metoden: hvor ses den i projektet?

Docker-guiden og Microsoft-tutorialen (begge på dit Sources-slide) bygger multi-container på fem principper. Du opfylder alle fem:

| Princip | I Foodhead |
| --- | --- |
| **Én opgave per container** ("each container should do one thing") | `web` kører appen, `mariadb` gemmer data, `phpmyadmin` er et admin-værktøj. Hver har sit eget image, sin egen bruger og sine egne limits |
| **Containere snakker via et fælles netværk** | `foodhead-net`. Servicenavnet `mariadb` fungerer som DNS-navn (i tutorialen: `--network-alias mysql`) |
| **Konfiguration via environment variables** | `config.py` læser `DB_HOST`, `DB_USER` osv. med `os.environ`, så intet er hardcoded |
| **Data i et volume, ikke i containeren** | `mariadb_data:/var/lib/mysql` |
| **Compose binder det sammen** | Én fil i stedet for mange `docker run`-kommandoer, plus startrækkefølge med healthcheck |

**Hvorfor ikke Flask og MariaDB i én container?** Man kan opdatere, genstarte og begrænse dem hver for sig. Man kan bruge det officielle MariaDB-image i stedet for selv at installere databasen. Hvis appen crasher, rører det ikke databasen. Og én container med én proces er det, Docker er designet til.

**Det manuelle alternativ, som Compose erstatter** (det er godt at vise, at du forstår, hvad Compose gør for dig):

```bash
docker network create foodhead-net
docker volume create foodhead-mariadb-data
docker run -d --name foodhead_mariadb --network foodhead-net \
  -v foodhead-mariadb-data:/var/lib/mysql \
  -e MARIADB_ROOT_PASSWORD=... -e MARIADB_DATABASE=foodhead \
  -e MARIADB_USER=foodhead -e MARIADB_PASSWORD=... mariadb:10.6.20
docker run -d --name foodhead_web --network foodhead-net \
  -p 127.0.0.1:80:5000 -e DB_HOST=mariadb -e DB_NAME=foodhead \
  -e DB_USER=foodhead -e DB_PASSWORD=... foodhead-web
```

Uden Compose skal man selv huske rækkefølgen, og der er ingen healthcheck-ventetid. `docker compose up` gør det samme i ét trin.

---

## 4. Talescript (ca. 10–12 min)

Tiderne er vejledende. Fed tekst = det, du siger. *Kursiv* = det, du gør.

### Slide 1 – Foodhead in containers (≈ 30 sek.)
**"Hej. Mit projekt hedder Foodhead in containers. Foodhead er en opskrifts-app, jeg byggede på første semester i Flask og MariaDB. I det her projekt har jeg ikke bygget nye features. Jeg har taget den eksisterende app og pakket den i containere med Docker Compose, så alle kan klone repoet og køre det hele med én kommando, uden at installere Python eller MariaDB selv."**

### Slide 2 – Three containers & data that stays (≈ 45 sek.)
**"Kort om appen: man kan oprette sig, logge ind og dele opskrifter med ingredienser, trin og et billede. Alle kan se opskrifterne, men kun forfatteren kan redigere dem.**
**Jeg valgte netop det her projekt, fordi det har en rigtig database og fil-uploads. Det betyder, at der er data, der skal overleve, når containerne bliver slettet. Det er derfor, titlen er 'three containers and data that stays'."**

### Slide 3 – The brief (≈ 45 sek.)
**"Opgaven bad om otte ting: containerisere en eksisterende app, en database, volumes, et named network, et effektivt image, et sikkert image, CPU- og memory-limits og en README.**
*Peg ned langs højre kolonne.*
**Her til højre står, hvordan jeg har løst hver enkelt. Jeg går igennem dem på de næste slides."**

### Slide 4 – How do I reach the database? (≈ 1¼ min.)
**"Sådan hænger det sammen. Jeg følger multi-container-princippet: én opgave per container. Appen, databasen og admin-værktøjet kører hver for sig, så jeg kan genstarte, opdatere og begrænse dem uafhængigt, og jeg kan bruge det officielle MariaDB-image i stedet for at installere databasen selv.**
**De tre services ligger på mit eget netværk, `foodhead-net`.**
**Browseren snakker kun med porte på 127.0.0.1, altså min egen maskine. Port 80 bliver sendt videre til Flask på port 5000 i web-containeren, og port 8080 til phpMyAdmin.**
**Inde på netværket finder containerne hinanden via servicenavnet. Derfor er min `DB_HOST` bare `mariadb`. Det virker, fordi det er et user-defined netværk med indbygget DNS.**
**Læg mærke til, at databasen ikke har nogen port ud til min computer. Det er bevidst: det er kun appen og phpMyAdmin, der skal bruge den, og de kommer ind via netværket.**
**Al databasedata ligger i det named volume nederst."**

### Slide 5 – Dockerfile (≈ 1½ min.)
**"Dockerfilen har to stages, begge på `python:3.12-alpine`.**
**Første stage, 'builder', laver et virtual environment i `/opt/venv` og installerer requirements. Jeg kopierer `requirements.txt` ind før resten af koden. Docker cacher hvert lag, så pakkerne kun bliver installeret igen, når requirements ændrer sig, og ikke hver gang jeg retter i `app.py`.**
**Anden stage, 'runtime', kopierer kun venv'et fra builder og derefter min kode. venv'et ligger i `/opt` og ikke i `/app`, fordi jeg i Compose mounter min projektmappe ind over `/app`, og så ville pakkerne blive skjult.**
**Til sidst laver jeg en almindelig bruger, `appuser` med uid 1000, og skifter til den med `USER`. Så kører Flask ikke som root.**
**Appen lytter på 5000, Flasks standard. Porte under 1024 kræver traditionelt root, og det passer ikke med en non-root-bruger. Og `CMD` starter Flask uden debug. Debug slås kun til via en environment variable."**

### Slide 6 – 368 MB → 197 MB (≈ 45 sek.)
**"Image'et gik fra 368 MB til 197 MB. Den oprindelige version var `python:3.9-slim`, én stage, og kørte som root.**
**Men jeg vil være ærlig: det meste af besparelsen kommer fra Alpine, ikke fra de to stages. Jeg testede de samme to stages på `slim`, og det gav 372 MB. På Alpine installerer MySQL-driveren sig som ren Python uden sin store C-extension.**
**Multi-stage giver først rigtig mening, når en pakke skal kompileres. Så bliver compileren i builder-stagen og kommer ikke med i det færdige image. Men mønstret er på plads."**

### Slide 7 – Compose file (≈ 1½ min.)
**"Tre ting i compose-filen, jeg vil fremhæve.**
**Ét: healthcheck. `depends_on` alene venter kun på, at database-containeren er *startet*, ikke på at MariaDB kan svare. Så får man 'Database under maintenance' de første sekunder. Jeg bruger MariaDB-image'ets eget `healthcheck.sh` og `condition: service_healthy`, så web først starter, når databasen faktisk er klar.**
**To: seed data. `foodhead.sql` bliver mountet read-only ind i `docker-entrypoint-initdb.d`. MariaDB kører den automatisk, men kun første gang, når volumet er tomt. Så alle, der kloner, får de samme ni opskrifter uden at importere noget selv.**
**Tre: limits på alle services. Web og phpMyAdmin har en halv CPU og 256 MB, databasen har én CPU og 512 MB, fordi den er den tungeste. Så kan én container ikke tage hele maskinen."**

### Slide 8 – Security (≈ 1 min.)
**"Sikkerhed. Her ser I beviset: `docker compose exec web id` giver uid 1000, appuser. Og `docker top` viser, at selve Flask-processen kører som 1000, og MariaDB som 999, som er mysql-brugeren fra det officielle image.**
**Derudover: databaseporten er ikke published, appen og phpMyAdmin lytter kun på 127.0.0.1, passwords ligger i `.env`, som er i `.gitignore`, og appen har sin egen databasebruger, der kun har adgang til `foodhead`-databasen.**
**Trade-offs: phpMyAdmins officielle image starter Apache som root, og det bruger jeg som det er. Og non-root er ikke det samme som rootless. Docker Desktop kører ikke selv i rootless mode."**

### Slide 9 – Live demo (≈ 2–3 min.)
*Hav en terminal klar med stacken kørende på forhånd. Hav et billede klar til upload.*
1. *`docker compose ps`*: **"Tre containere oppe, og databasen er healthy."**
2. *Åbn localhost, opret bruger, lav en opskrift med billede*: **"Det her viser, at app og database snakker sammen, og at appuser har lov at skrive filer."**
3. *`docker compose down` → `docker compose up -d` → refresh*: **"Containerne og netværket er slettet og lavet igen, men opskriften er her stadig. Databasen ligger i volumet, og billedet ligger på min disk via bind mountet."**
4. *`docker compose exec web id`*: **"uid 1000, ikke root."**
5. *`docker stats --no-stream`*: **"Og forbruget er langt under limits."**

**Plan B, hvis noget fejler:** **"Det er derfor, jeg har screenshots på næste slide."** Gå videre.

### Slide 10 – Running, healthy and inside the limits (≈ 30 sek.)
**"Her er de samme resultater som screenshots: alt kører, databasen er healthy, og image'et er 197 MB. Hukommelsen ligger på 30, 90 og 16 MB mod lofterne på 256, 512 og 256. Det er vel at mærke målt på en stack, der står i tomgang, ikke under load."**

### Slide 11 – USER appuser wasn't enough (≈ 1 min.)
**"Det, jeg lærte mest af: at skrive `USER appuser` var ikke nok i sig selv.**
**Min første version kørte som root, og den efterlod mapper som `flask_session` og `__pycache__` i projektet, ejet af root. Da appen så kørte som appuser, fik den 'Permission denied', når den ville gemme sessions, fordi mapperne kom ind via bind mountet.**
**Løsningen var at slette mapperne, så Flask lavede `flask_session` igen, nu ejet af appuser. `PYTHONDONTWRITEBYTECODE` i Dockerfilen sørger desuden for, at Python ikke skriver `__pycache__` ind i min projektmappe.**
**Pointen: non-root tæller kun, når man har testet det."**

### Slide 12 – Improvements (≈ 1 min.)
**"Der er begrænsninger. Der er ingen database-migrations: SQL-filen kører kun på et tomt volume, så da jeg forbedrede opskriftsteksterne, så min kørende database stadig de gamle. Den eneste vej er `down -v`, og det sletter alt.**
**Der er et manuelt trin: man skal selv lave `.env` ud fra `.env.example`.**
**Og setuppet er bygget til udvikling, med bind mount, auto-reload og Flasks indbyggede server.**
**Næste skridt: Gunicorn i stedet for `flask run`, en produktions-compose uden bind mount med uploads i et named volume, og en healthcheck på web."**

### Slide 13 – Questions? (≈ 15 sek.)
**"Koden og README'en ligger på GitHub via QR-koden. Tak, har I spørgsmål?"**

---

## 5. Spørgsmål du kan forvente, med korte svar

**Hvad er forskellen på et image og en container?**
Image = skabelonen (read-only lag). Container = en kørende instans med sit eget skrivbare lag.

**Hvad er forskellen på et volume og et bind mount?**
Et volume administreres af Docker og bruges til data, der skal leve videre (databasen). Et bind mount er en mappe fra min computer og bruges til live-udvikling (koden).

**Hvorfor ikke bare `depends_on`?**
Det venter kun på, at containeren starter, ikke på at MariaDB er klar. Healthchecket venter på et rigtigt svar.

**Hvad gør `EXPOSE`?**
Kun dokumentation. Det er `ports:` i Compose, der publicerer.

**Hvorfor kan web finde `mariadb` via navnet?**
User-defined bridge-netværk har indbygget DNS, så servicenavnet bliver resolvet til containerens IP.

**Hvad sker der ved `docker compose down` vs `down -v`?**
`down` sletter containere og netværk og beholder volumet. `-v` sletter også volumet, og så seedes databasen igen ved næste start.

**Hvorfor virker multi-stage, når besparelsen var lille?**
Den adskiller build fra runtime. Når en pakke en dag kræver gcc, bliver build-værktøjerne i builder-stagen. Den reelle besparelse kom her fra Alpine.

**Er 197 MB den rigtige størrelse?**
197 MB er den udpakkede størrelse på disk. Docker viser også "content size" på ca. 65 MB, som er den komprimerede størrelse, der bliver downloadet.

**Hvad er ulempen ved Alpine?**
Den bruger musl i stedet for glibc. Nogle Python-pakker har ingen færdige wheels og skal kompileres, eller opfører sig anderledes.

**Hvad sker der, hvis containeren rammer memory-limit?**
Kernen dræber processen (OOM-kill). Limits håndhæves via cgroups.

**Kører det her i produktion?**
Nej, det er et udviklingsmiljø (se Improvements-slidet).

**Hvorfor kan man se `.env` inde i web-containeren?**
Fordi bind mountet `.:/app` mounter hele projektmappen. `.dockerignore` holder den ude af *image'et*, men ikke ude af mountet.

**Virker det på Linux?**
Ja, men hvis din Linux-bruger ikke har uid 1000, kan appuser ikke skrive i den bind-mountede mappe. På Docker Desktop (Windows/Mac) håndterer fildelingen det. Det er et godt argument for, at uploads skal ligge i et named volume i produktion.

**Kunne du have brugt `include` i Compose?**
Ja, men det giver først værdi, når compose-filen bliver stor, eller når en del skal genbruges af andre projekter. Med tre services i én fil ville `include` kun gøre opsætningen sværere at overskue. Til dev/prod-forskelle passer `docker-compose.override.yml` bedre, fordi den kan *ændre* på en service. Det kan `include` ikke.

**Hvorfor `container_name`?**
Det giver læsbare kommandoer. Ulempen er, at man ikke kan skalere en service til flere containere.
