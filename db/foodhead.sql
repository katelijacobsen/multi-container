-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Vært: mariadb
-- Genereringstid: 28. 09 2026 kl. 20:35:42
-- Serverversion: 10.6.20-MariaDB-ubu2004
-- PHP-version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foodhead`
--

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `countries`
--

CREATE TABLE `countries` (
  `country_id` char(32) NOT NULL,
  `country_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `countries`
--

INSERT INTO `countries` (`country_id`, `country_name`) VALUES
('1', 'Denmark'),
('2', 'Germany');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `ingridients`
--

CREATE TABLE `ingridients` (
  `ingridient_id` char(32) NOT NULL,
  `recipe_fk` char(32) NOT NULL,
  `ingridient_names` varchar(50) NOT NULL,
  `ingridient_amounts` varchar(10) NOT NULL,
  `ingridient_units` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `ingridients`
--

INSERT INTO `ingridients` (`ingridient_id`, `recipe_fk`, `ingridient_names`, `ingridient_amounts`, `ingridient_units`) VALUES
('015157583d014aadaf623991986ddc1a', 'e71d8cfea6074e15a6afd56847fc3f36', 'Cocoa powder (for dusting)', '1', 'tbsp'),
('0459b1d4946442239adff4e15e49c5d3', '12ca42a69c334fae817bae027c3286fb', 'Cornstarch', '15', 'g'),
('0f6077ae975941a7a34a293d2aefc797', '6389e0182fe14449a82ded0bb695f015', 'Powdered sugar', '50', 'g'),
('1088eebd5f9e4874b22236a2682ef8cf', '912d1260b6fa4525820c19e5dfe64ed0', 'Rucola', '1', 'pcs'),
('128c7d00fcf4409198e9160a237aa7ed', '12ca42a69c334fae817bae027c3286fb', 'Eggs', '2', ''),
('1579ad1211194cfb9af0ace5a31f70b9', '912d1260b6fa4525820c19e5dfe64ed0', 'Tomatoe', '1', 'pcs'),
('1595b80ecb7346759488b3c62ac4348d', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Whipping cream (ganache)', '150', 'ml'),
('15ad76aa1b7d4a39aeee43536ef39854', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Baking powder', '1', 'tsp'),
('162af17156d1432bbec604905ffa6d38', '690a0954fed74f5988dffe487d13c8cb', 'Sugar', '300', 'g'),
('17283a4743f6485291e9125625b4715b', 'e71d8cfea6074e15a6afd56847fc3f36', 'Gelatin leaves (mousse)', '2', 'pcs'),
('174a128b84f7491895153d2e40ce3119', '690a0954fed74f5988dffe487d13c8cb', 'Sprinkles', '50', 'g'),
('18f37921c0b24c5fb473b2566c1b4fa3', '12ca42a69c334fae817bae027c3286fb', 'Salt', '1', 'pinch'),
('1aea2c3996654937a38ddf85dbbbc8db', 'e71d8cfea6074e15a6afd56847fc3f36', 'Whipping cream', '400', 'ml'),
('1b6ffd5876df4f2da073b2042c174cda', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Fresh raspberries', '125', 'g'),
('1facc4ab6441442e93c86ceede79eece', '12ca42a69c334fae817bae027c3286fb', 'Ice cold water (if necessary)', '50', 'ml'),
('238373d6be0540889f74333ed5b64cc3', '4c3ae7de4533480eba020e8d3e1dade9', 'Egg', '1', ''),
('2434cbfce57e4f03a77359454fb1fc75', '6389e0182fe14449a82ded0bb695f015', 'Eggs', '2', ''),
('24eb6d104164444ab1a51ed244766b21', 'e71d8cfea6074e15a6afd56847fc3f36', 'Chocolate biscuits', '200', 'g'),
('2e84b4dc499a4a89a66250e3f13a8af8', '6389e0182fe14449a82ded0bb695f015', 'Melted butter', '80', 'g'),
('302e174854e44e61b8bbd4172e7d64ea', '4c3ae7de4533480eba020e8d3e1dade9', 'Egg (for brushing)', '1', ''),
('328ec479b19440728957f5d90edb84a8', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Wheat flour', '60', 'g'),
('32d407d8c51f43b48fb9a290c1618c4d', 'a64cf46c0cb34210a27744e7e2ee7698', 'Baking soda', '0.5', 'tsp'),
('3375db98ae3b4f6cb9c28df50641b2aa', '4c3ae7de4533480eba020e8d3e1dade9', 'Brown sugar (filling)', '75', 'g'),
('3381f96f8af24cfb92a786bab56b3323', 'e71d8cfea6074e15a6afd56847fc3f36', 'Milk', '100', 'ml'),
('34442f2c47204e378e67fcfb9b53a17f', '12ca42a69c334fae817bae027c3286fb', 'Cold butter', '120', 'g'),
('3696913f0c5b422dabf9fc0772fa017a', '690a0954fed74f5988dffe487d13c8cb', 'Softened butter', '225', 'g'),
('38a2e783df574818a6b4f936f3f72787', '096f4354068e4c168d6d2b9bf7ae968c', 'Active sourdough starter', '100', 'g'),
('3946edb4ff9040babe26b0d341591f34', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Eggs', '3', ''),
('3f82318bf6af46418d1899897de41281', 'e71d8cfea6074e15a6afd56847fc3f36', 'Dark chocolate (70%)', '200', 'g'),
('483d48bb52d14286acba1a4982f13da0', '690a0954fed74f5988dffe487d13c8cb', 'Baking powder', '3', 'tsp'),
('48f32a571c7242f4915f469cf8e79ee6', '4c3ae7de4533480eba020e8d3e1dade9', 'Wheat flour', '450', 'g'),
('49308c3002e245c6882b821b02b8b804', 'e71d8cfea6074e15a6afd56847fc3f36', 'Gelatin leaves (raspberry layer)', '3', 'pcs'),
('4b7a00696a854701943c093ab22ed6d4', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Gelatin leaves', '7', 'pcs'),
('4dbf066c58b849f28e6143b9ae79b404', '12ca42a69c334fae817bae027c3286fb', 'Egg', '1', ''),
('503797a2329647d3835703b922916078', '096f4354068e4c168d6d2b9bf7ae968c', 'Honey', '1', 'tbsp'),
('50f60923b11d49cc86cade41fb8fbdaf', 'e71d8cfea6074e15a6afd56847fc3f36', 'Sugar', '50', 'g'),
('51e4b08a9bfa4b39b067d21b7b946ec1', '690a0954fed74f5988dffe487d13c8cb', 'Whipping cream', '3', 'tbsp'),
('55d4aec6b63a4650898e74eee5d5e0cf', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Cocoa powder', '20', 'g'),
('5d7f41295f5b4665aad07795441a81c9', '690a0954fed74f5988dffe487d13c8cb', 'Vanilla extract', '2', 'tsp'),
('638589ac836a4f0db815089ca33334da', 'a64cf46c0cb34210a27744e7e2ee7698', 'White sugar', '50', 'g'),
('63b884d0e09f4fb980d4a75b7f521816', 'a64cf46c0cb34210a27744e7e2ee7698', 'Wheat flour', '250', 'g'),
('6ac3f219b71a44389173285886358025', '6389e0182fe14449a82ded0bb695f015', 'Elderflower cordial', '150', 'ml'),
('6b624678600a457394fcf16f4e972aa6', '6389e0182fe14449a82ded0bb695f015', 'Sugar', '100', 'g'),
('6dc2a2a33e6247a0bce07a8b075bcdca', '690a0954fed74f5988dffe487d13c8cb', 'Softened butter (buttercream)', '250', 'g'),
('6e5dfb171c8d481ab5b18b74ea9e7018', '690a0954fed74f5988dffe487d13c8cb', 'Wheat flour', '375', 'g'),
('700cdfb8a4194ff7a748415d23ff2529', '6389e0182fe14449a82ded0bb695f015', 'Butter', '50', 'g'),
('7ed868af909448a2b0a21a72802173c0', '12ca42a69c334fae817bae027c3286fb', 'Lemon', '1', ''),
('7ef023b5fd004dfd8e3d5282c795b93b', '6389e0182fe14449a82ded0bb695f015', 'Whipping cream', '400', 'ml'),
('7f69b11460184ad9b1e37546dc980819', 'a64cf46c0cb34210a27744e7e2ee7698', 'Brown sugar', '150', 'g'),
('8c2261c6129e4cda8c175670b0107b68', '4c3ae7de4533480eba020e8d3e1dade9', 'Salt', '0.5', 'tsp'),
('8c5866292d0742e89d73071850179911', 'e71d8cfea6074e15a6afd56847fc3f36', 'Fresh raspberries', '125', 'g'),
('8dc94bea209d458086bba3a33357822f', '12ca42a69c334fae817bae027c3286fb', 'White sugar', '125', 'g'),
('9190dd489cb04c0abbf0ef9bb93eb5b1', '4c3ae7de4533480eba020e8d3e1dade9', 'Pearl sugar', '2', 'tbsp'),
('929a74104449436dbdeb77b4319bcb38', '4c3ae7de4533480eba020e8d3e1dade9', 'Fresh yeast', '25', 'g'),
('93d511b0b68d49bfab8a60f1acc1ce53', 'e71d8cfea6074e15a6afd56847fc3f36', 'Melted butter', '60', 'g'),
('94e180d81213424789e1597b06ed62e5', 'a64cf46c0cb34210a27744e7e2ee7698', 'Butter', '170', 'g'),
('96e3d3b8d9074f328f17df770844a0dc', '690a0954fed74f5988dffe487d13c8cb', 'Milk', '250', 'ml'),
('9cefef03630849b3bafb10063a28fdbb', '912d1260b6fa4525820c19e5dfe64ed0', 'Mozarella Cheese', '50', 'g'),
('a291e74d86ec413d9c4fffe947362629', '12ca42a69c334fae817bae027c3286fb', 'Eggyolk', '2', ''),
('a870fc9f0f784a45b4b21c8b27c28ffa', '6389e0182fe14449a82ded0bb695f015', 'Gelatin leaves (mousse)', '6', 'pcs'),
('a9091f1f6a2c42b3bbf815c787fc4503', '4c3ae7de4533480eba020e8d3e1dade9', 'Ground cardamom (filling)', '1', 'tbsp'),
('aa287283b61744aabb79f9dc202e1339', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Sugar (mousse)', '80', 'g'),
('aef378e9354f490297b96c5dd8478656', '096f4354068e4c168d6d2b9bf7ae968c', 'Salt', '10', 'g'),
('afa9d081f4e044beb19894e08a5e1a7f', 'e71d8cfea6074e15a6afd56847fc3f36', 'Powdered sugar', '30', 'g'),
('b1ed1564e4de4d3eb0787cc5e5465caa', '096f4354068e4c168d6d2b9bf7ae968c', 'Rolled oats (for topping)', '2', 'tbsp'),
('b2ffbd69a90246768e744a1d4fc32f16', '4c3ae7de4533480eba020e8d3e1dade9', 'Ground cardamom', '2', 'tsp'),
('b427b48449ab4dde865afc14a1a8338f', '690a0954fed74f5988dffe487d13c8cb', 'Vanilla extract (buttercream)', '1', 'tsp'),
('b718723c68364b708375ff0634d93bdb', 'a64cf46c0cb34210a27744e7e2ee7698', 'Egg yolk', '1', ''),
('ba92b1b8feea47f2a7ff8b2309055aa2', 'a64cf46c0cb34210a27744e7e2ee7698', 'Salt', '0.5', 'tsp'),
('bca68434105e4b12ae74dc1ba16bcaea', '690a0954fed74f5988dffe487d13c8cb', 'Eggs', '4', ''),
('bcfa3dffb5dd4bbaa77ab070df93f882', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Whipping cream', '400', 'ml'),
('bd4680e811b54c5eb4bed3870ddcf1fa', 'a64cf46c0cb34210a27744e7e2ee7698', 'Vanilla extract', '2', 'tsp'),
('bdafba1110364490b87af07aba0bb42d', '12ca42a69c334fae817bae027c3286fb', 'Cold diced butter', '50', 'g'),
('c04af7c88d5e4aabb9bcb2a4390e3d3e', '096f4354068e4c168d6d2b9bf7ae968c', 'Whole wheat flour', '50', 'g'),
('c2b4ec89718146759efb2c5801138a4f', '6389e0182fe14449a82ded0bb695f015', 'Cream cheese', '200', 'g'),
('c6176044f133462f952db2da257ba838', 'e71d8cfea6074e15a6afd56847fc3f36', 'Raw licorice powder', '2', 'tsp'),
('c70c0a67d52d478a9f24f0ead7680f81', '6389e0182fe14449a82ded0bb695f015', 'Digestive biscuits', '200', 'g'),
('c80f977f741042f98eeaca0328ef8e90', 'e71d8cfea6074e15a6afd56847fc3f36', 'Frozen raspberries', '250', 'g'),
('c890af79127e4f36b0c9e12d865c1efa', '12ca42a69c334fae817bae027c3286fb', 'Lemonjuice', '150', 'ml'),
('cde650e88ad54a90be051254cb90e84a', '4c3ae7de4533480eba020e8d3e1dade9', 'Softened butter', '75', 'g'),
('d1bd5f962009413d9b7623b855874661', '6389e0182fe14449a82ded0bb695f015', 'Lemons', '2', ''),
('d2d5c7870d1c416b92f447b3ee269fa2', '690a0954fed74f5988dffe487d13c8cb', 'Salt', '0.5', 'tsp'),
('d7e3569b12c64c67804f91b459029208', '4c3ae7de4533480eba020e8d3e1dade9', 'Sugar', '50', 'g'),
('d8ab2d3dc95d44249f50dd7c290db655', '096f4354068e4c168d6d2b9bf7ae968c', 'Lukewarm water', '350', 'ml'),
('d95cbacc4f9b46dc9c78a47327fcdb61', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Frozen raspberries', '400', 'g'),
('d9c7592ac0584a389fa1435ede7eb644', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Dark chocolate (70%)', '150', 'g'),
('db282907f4b84a779bddb4ca4fcd452d', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Sugar', '100', 'g'),
('dc97fed3703e4e0ca720f9c0f97602bd', '6389e0182fe14449a82ded0bb695f015', 'Lemon juice', '2', 'tbsp'),
('e0f10b9c7248460895e34372bdc06d4c', '4c3ae7de4533480eba020e8d3e1dade9', 'Milk', '250', 'ml'),
('e39172c29ee74a1199b26c112eb53a70', '12ca42a69c334fae817bae027c3286fb', 'Cakeflour', '240', 'g'),
('e63c7214edc74d12b5c8eb0a39ec8c26', '096f4354068e4c168d6d2b9bf7ae968c', 'Wheat flour', '450', 'g'),
('e84cc2dea4d5493197171529c456a31f', '690a0954fed74f5988dffe487d13c8cb', 'Powdered sugar', '500', 'g'),
('eb4c68021c5e492190b46aef6e668684', 'a64cf46c0cb34210a27744e7e2ee7698', 'Flaky sea salt', '1', 'pinch'),
('ee473b7a08d14ecba8545f7dbc66d4b6', '12ca42a69c334fae817bae027c3286fb', 'Powdered sugar', '50', 'g'),
('ee5646bf3d3942229f49bad56c3cffe2', '6389e0182fe14449a82ded0bb695f015', 'Gelatin leaves (lemon curd)', '2', 'pcs'),
('ee5807ebe13a4785af18cc5e6c17e847', 'a64cf46c0cb34210a27744e7e2ee7698', 'Dark chocolate', '200', 'g'),
('ef05f6be88f54b21a85b55009a3f838f', '4c3ae7de4533480eba020e8d3e1dade9', 'Softened butter (filling)', '100', 'g'),
('f474dd42b8724288bb354fea09155b8a', 'a64cf46c0cb34210a27744e7e2ee7698', 'Egg', '1', ''),
('f50067d8d104460fa8be0561542ccbeb', '912d1260b6fa4525820c19e5dfe64ed0', 'Serrano ham', '1', '');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `instructions`
--

CREATE TABLE `instructions` (
  `instruction_id` char(32) NOT NULL,
  `recipe_fk` char(32) NOT NULL,
  `instruction` varchar(500) NOT NULL,
  `instruction_step_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `instructions`
--

INSERT INTO `instructions` (`instruction_id`, `recipe_fk`, `instruction`, `instruction_step_number`) VALUES
('02fbdb6ff7fd4bcdaa6dff1afd48fcb7', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Pour the mousse over the sponge, smooth the top and refrigerate for at least 4 hours, until set.', 8),
('03c8f2276f7944d1bf8d032752078f64', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Sift the flour, cocoa powder and baking powder over the egg mixture and gently fold it in with a spatula.', 3),
('041c996824904c2dbcab32e785c5707c', '096f4354068e4c168d6d2b9bf7ae968c', 'Brush the buns with water, sprinkle them with oats and bake for 18–20 minutes, until golden brown and they sound hollow when tapped underneath.', 7),
('062f6ef7719b41e1a80c12c8c6e263dc', '12ca42a69c334fae817bae027c3286fb', 'Grease a 24 cm tart tin with butter and when ready place the dough into the tart tin and gently press it into the bottom and sides.\r\nTrim the edges neatly to create an even finish. Prick the bottom of the tart crust several times with a fork.', 4),
('0b69792b6af44da1910230506a615de6', '690a0954fed74f5988dffe487d13c8cb', 'Whisk the flour, baking powder and salt together in a separate bowl.', 3),
('0c4918b5883547ebbb14120b0cbd959a', '6389e0182fe14449a82ded0bb695f015', 'For the mousse, soak 6 gelatin leaves in cold water for 5 minutes. Gently warm half of the elderflower cordial, squeeze the gelatin and dissolve it in the warm cordial. Stir in the rest of the cordial and the lemon juice.', 5),
('0d71846a72324df3861be56671d5398e', 'a64cf46c0cb34210a27744e7e2ee7698', 'Chop the chocolate roughly and fold it into the dough.', 4),
('0deb538e795246ada4c6f395867da198', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Whip the cream to soft peaks and gently fold it into the raspberry purée.', 7),
('13652ad8de624219816dd70dbc287ddc', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Pour the batter into the pan and bake for 15–20 minutes. Let the sponge cool, then put it back in the clean springform pan with a strip of baking paper along the edge.', 4),
('1858012254574e25a486e138531797ef', '912d1260b6fa4525820c19e5dfe64ed0', 'Cut the bought sourdough in half and toast both sides', 1),
('1adce7a36039458499b24aca7c8b7ef7', '096f4354068e4c168d6d2b9bf7ae968c', 'Let the buns cool on a wire rack for at least 15 minutes before serving.', 8),
('24519d2ebf2a4542b21c451e08fcc041', '690a0954fed74f5988dffe487d13c8cb', 'Level the cakes if needed. Place one layer on a serving plate, spread it with a thick layer of buttercream and place the second layer on top.', 8),
('283958dd7ed246e3bb04c65c8cd06d6b', 'e71d8cfea6074e15a6afd56847fc3f36', 'Pour the mousse over the raspberry layer, smooth the top and refrigerate for at least 5 hours or overnight.', 7),
('334f1b0598024a8e9cfe6ed3796e9cff', '096f4354068e4c168d6d2b9bf7ae968c', 'Cover the bowl and let the dough rise at room temperature for 3–4 hours. Give it a stretch and fold every 30 minutes during the first 2 hours.', 3),
('33961387645543d482771aa03daf93b8', '12ca42a69c334fae817bae027c3286fb', 'Roll out the dough between two sheets of baking paper and refrigerate the dough for 30 minutes.', 3),
('35f23987ab2e4edd977df4dbe7e51a69', '12ca42a69c334fae817bae027c3286fb', 'Add the water and sugar to a saucepan.\r\nBring the mixture to a boil and heat it to exactly 118°C. Use a sugar thermometer to monitor the temperature.', 9),
('37eda8227bf648578b7b924a4fd344b5', '12ca42a69c334fae817bae027c3286fb', 'Cover the dough with baking paper and fill the tart with dried beans for blind baking and blind bake in a preheated 175°C fan oven for approximately 15 minutes.', 5),
('39d452b2c92743ff812eb6251ec0a1f8', '4c3ae7de4533480eba020e8d3e1dade9', 'Warm the milk to about 37°C and dissolve the yeast in it.', 1),
('41ff1d9df632423686f0259ecff8a625', '4c3ae7de4533480eba020e8d3e1dade9', 'Stir the butter, brown sugar and cardamom for the filling together until smooth and spreadable.', 4),
('43f0caa5be644577a3a07f4632f45a3a', '12ca42a69c334fae817bae027c3286fb', 'Add the flour, icing sugar, salt, and butter to a food processor. Process until the mixture is smooth and evenly combined.', 1),
('43f5ac2c334a4d4bbdc5c2b36d9f581d', '6389e0182fe14449a82ded0bb695f015', 'Line the bottom of a 24 cm springform pan with baking paper. Crush the biscuits finely, mix them with the melted butter and press the mixture firmly into the bottom of the pan. Refrigerate.', 1),
('44dc9f7b21c747a18cf3c608303ecf06', '6389e0182fe14449a82ded0bb695f015', 'Soak 2 gelatin leaves in cold water for 5 minutes. Remove the curd from the heat, whisk in the butter, then squeeze the gelatin and stir it into the warm curd. Let the curd cool to room temperature.', 4),
('463f15d695824e4a8e434a1f3d9c7fbc', '6389e0182fe14449a82ded0bb695f015', 'For the lemon curd, finely grate the zest of the lemons and squeeze out the juice. Whisk the zest, juice, sugar and eggs together in a saucepan.', 2),
('470ce00daba3481eac6c58bb10d041bc', 'e71d8cfea6074e15a6afd56847fc3f36', 'For the raspberry layer, soak 3 gelatin leaves in cold water for 5 minutes. Heat the raspberries and sugar in a saucepan until the berries fall apart, then press the purée through a sieve.', 2),
('489f66a48aa041b58ce7ca6f9020843c', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Whisk the eggs and sugar for 5–7 minutes until pale, thick and fluffy.', 2),
('4b0b7ef0b4f14fc6b4980342636c16ad', '4c3ae7de4533480eba020e8d3e1dade9', 'Place the knots on baking sheets lined with baking paper, cover them and let them rise for 30 minutes. Preheat the oven to 200°C (conventional).', 7),
('4e1e31b531fa490591dec3e1f27018a3', '12ca42a69c334fae817bae027c3286fb', 'Remove the saucepan from the heat.\r\nGradually whisk in the butter, a little at a time, until completely incorporated.\r\nPour the lemon cream into the baked tart crust and spread it evenly.\r\nPlace the tart in the refrigerator to chill.', 8),
('50a1b8276acf4aa9880d1aa397df4281', '690a0954fed74f5988dffe487d13c8cb', 'Divide the batter between the two pans and bake for 28–32 minutes, until a skewer inserted in the middle comes out clean.', 5),
('512acf4376f24b0db7bacf67c1323064', '096f4354068e4c168d6d2b9bf7ae968c', 'Add both flours and the salt and knead for about 10 minutes until the dough is smooth and elastic. It will still be slightly sticky.', 2),
('51f5c72e7e184ae7bf197bdc85c02e20', '6389e0182fe14449a82ded0bb695f015', 'Run a warm knife along the edge of the pan, release the cake and decorate it with elderflowers or lemon zest before serving.', 10),
('52cbb8aef0924ae0bf19f7928b5660bf', '690a0954fed74f5988dffe487d13c8cb', 'Preheat the oven to 175°C (conventional). Grease two 20 cm round cake pans and line the bottoms with baking paper.', 1),
('623145b079ff4b8d9467fad8f9adbad4', '6389e0182fe14449a82ded0bb695f015', 'Pour the mousse over the biscuit base, smooth the top and refrigerate for at least 1 hour, until the surface has set.', 8),
('64cfa0f3dffc4e9290200a8cc442d78b', 'e71d8cfea6074e15a6afd56847fc3f36', 'Release the cake from the pan, dust it with cocoa powder and a little licorice powder, and decorate with fresh raspberries before serving.', 8),
('68839bfa80334a8da8df184bdc2a76b1', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Soak the gelatin in cold water for 5 minutes. Warm a third of the raspberry purée, squeeze the gelatin and dissolve it in the warm purée. Stir in the rest of the purée.', 6),
('70aa85bb82bf448e8d260b8a25556ec2', '6389e0182fe14449a82ded0bb695f015', 'Spread the cooled lemon curd evenly over the mousse and refrigerate the cake for at least 5 hours or overnight.', 9),
('70f14682080549af981f1eb935bb9ba6', '12ca42a69c334fae817bae027c3286fb', 'Add the eggs, egg yolks, sugar, lemon juice, lemon zest, and cornstarch to a saucepan.\r\nWhisk everything together.\r\nSlowly heat the mixture over medium heat, stirring constantly, until the mixture thickens.', 7),
('71bde2fe2f6d495692a81b2d20da79e3', '4c3ae7de4533480eba020e8d3e1dade9', 'Roll the dough out into a rectangle of about 30 x 40 cm and spread the filling evenly over the whole surface.', 5),
('77bd74cfa15e42c99dd020477dcb8f77', '6389e0182fe14449a82ded0bb695f015', 'Heat the mixture over low to medium heat, whisking constantly, until it thickens (about 8–10 minutes). Do not let it boil.', 3),
('7aa516bded7e490b89779de6fe20d1b3', 'a64cf46c0cb34210a27744e7e2ee7698', 'Melt the butter in a saucepan over medium heat and let it cook, stirring often, until it turns golden brown and smells nutty. Pour it into a bowl and let it cool for 10 minutes.', 1),
('82c701a7d6f94a70953b76ba1a87bbc8', 'e71d8cfea6074e15a6afd56847fc3f36', 'Line the bottom of a 22 cm springform pan with baking paper. Crush the chocolate biscuits finely, mix them with the melted butter and press the mixture firmly into the bottom of the pan. Refrigerate.', 1),
('8540b17020fe458abe7a5bf2c6dd43b6', 'a64cf46c0cb34210a27744e7e2ee7698', 'Sprinkle with flaky sea salt right away and let the cookies cool on the baking sheet for 5 minutes before moving them to a wire rack.', 8),
('854df858da004700afc4298b854653de', '6389e0182fe14449a82ded0bb695f015', 'Whip the cream to soft peaks and gently fold it into the elderflower mixture in two portions.', 7),
('86c6f16a53744b809c36b7cbeed39c40', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Preheat the oven to 180°C (conventional) and line the bottom of a 24 cm springform pan with baking paper.', 1),
('8a9ea1e4d5564670ac0ae35604cd821f', '096f4354068e4c168d6d2b9bf7ae968c', 'Dissolve the active sourdough starter and the honey in the lukewarm water in a large bowl.', 1),
('8f1cc267f0514de2a03e7746a1ac39fd', '690a0954fed74f5988dffe487d13c8cb', 'For the buttercream, beat the butter for 3 minutes until very pale. Gradually add the powdered sugar, then the cream and vanilla, and beat for another 3–4 minutes until light and fluffy.', 7),
('9661af83e60b4f9eb462660e613cab53', 'e71d8cfea6074e15a6afd56847fc3f36', 'For the mousse, soak 2 gelatin leaves in cold water for 5 minutes. Chop the chocolate and melt it gently over a water bath.', 4),
('9c4f3afea901466fb34c06f637f06ba6', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Release the cake from the pan and decorate it with fresh raspberries before serving.', 11),
('9fd512edd7fa4f1ca6f148255ba89e71', 'a64cf46c0cb34210a27744e7e2ee7698', 'Bake for 10–12 minutes, until the edges are golden but the centers still look slightly underbaked.', 7),
('a4e42d747ea84ef88d66b4a83290a9dd', '12ca42a69c334fae817bae027c3286fb', 'Transfer the meringue to a piping bag fitted with a large star nozzle.\r\nPipe many closely spaced meringue peaks over the surface of the tart.\r\nUse a kitchen blowtorch to carefully toast the meringue peaks until they are beautifully golden.', 11),
('a54075bf620c44aa8288cc8165a5b2ed', '12ca42a69c334fae817bae027c3286fb', 'Remove the tart from the oven. Carefully remove the baking paper and dried beans. Return the tart to the oven and bake for another 5–8 minutes, until the crust is lightly golden. Remove from the oven and allow the tart crust to cool slightly.', 6),
('a67fa625b0b54972821b226324d68f24', '9a135cc0fb4b4cf29644d6ab2077a4be', 'For the ganache, chop the chocolate finely. Bring the cream to a simmer, pour it over the chocolate, wait 1 minute and stir until smooth and glossy. Let it cool to about 30°C.', 9),
('a767deb426824c188859865dee226dbc', '4c3ae7de4533480eba020e8d3e1dade9', 'Cover the bowl and let the dough rise in a warm place for 45 minutes, until doubled in size.', 3),
('a76b3e914d5d48f6b5234a422aabaa55', 'a64cf46c0cb34210a27744e7e2ee7698', 'Mix the flour, baking soda and salt and stir it into the butter mixture until just combined.', 3),
('ab2c5b8b62bb4f1eb96286cb9bc03cd9', 'a64cf46c0cb34210a27744e7e2ee7698', 'Whisk the brown sugar and white sugar into the browned butter. Add the egg, egg yolk and vanilla and whisk for 1 minute until smooth and glossy.', 2),
('ab7ea3f16f7a4d0eb6e0969c253910f2', 'a64cf46c0cb34210a27744e7e2ee7698', 'Cover the bowl and refrigerate the dough for at least 30 minutes. Meanwhile, preheat the oven to 180°C (conventional) and line two baking sheets with baking paper.', 5),
('ad8dbf9a2c78405d94e19ac57234c06c', '096f4354068e4c168d6d2b9bf7ae968c', 'Cover the buns and let them rise for 1 hour while the oven preheats to 230°C (conventional).', 6),
('b187811ccd1c4b7593d20877752c2b80', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Thaw the raspberries, blend them and press them through a sieve to remove the seeds. Stir in the sugar.', 5),
('b3562020eca2429d9c6e8654236376c8', '12ca42a69c334fae817bae027c3286fb', 'Serve (:', 12),
('b95b60daa6b64bb7b30425492d9dc6d3', '912d1260b6fa4525820c19e5dfe64ed0', 'Slightly flame the op of the open half the cheese', 3),
('c01c5b6f494e414dafb5b01a20ba8a72', '912d1260b6fa4525820c19e5dfe64ed0', 'Finish by putting the other half on top of the sandwich', 4),
('c07ee331caa0407ab75ef9a42750aa68', '12ca42a69c334fae817bae027c3286fb', 'Transfer the mixture to a bowl. Add the beaten egg and mix until the dough comes together. Add a little cold water if necessary.', 2),
('c0a9615793fb4dd8b0e3d3643f091999', '690a0954fed74f5988dffe487d13c8cb', 'Add the flour mixture to the batter in three portions, alternating with the milk. Mix only until just combined.', 4),
('c49156335b1941919503af871112d024', '6389e0182fe14449a82ded0bb695f015', 'Whisk the cream cheese and powdered sugar until smooth, then stir in the elderflower mixture.', 6),
('c58deaae4b524861bbf38c96ec508234', '690a0954fed74f5988dffe487d13c8cb', 'Beat the softened butter and sugar for 3–4 minutes until pale and fluffy. Add the eggs one at a time, beating well after each, then mix in the vanilla.', 2),
('c8cb6f12b0994e4082890a4c97ccfe8c', 'a64cf46c0cb34210a27744e7e2ee7698', 'Shape the dough into 20 balls and place them on the baking sheets with plenty of space between them.', 6),
('d13e444ae9994499b397b879fadb84cf', '12ca42a69c334fae817bae027c3286fb', 'Meanwhile, whisk the egg whites until they are light, fluffy, and stiff.\r\nSlowly pour the hot sugar syrup into the egg whites in a thin, steady stream while continuing to whisk.\r\nAdd the salt and lemon juice and whisk until incorporated.', 10),
('e27f3af329bb4d50963e6caf0ab1ce75', '4c3ae7de4533480eba020e8d3e1dade9', 'Fold the dough in thirds like a letter and cut it into 10 strips. Twist each strip and tie it into a knot, tucking the ends underneath.', 6),
('e6977eb5faf74bbb829b67c1a7be8d62', '690a0954fed74f5988dffe487d13c8cb', 'Decorate with sprinkles and candles and serve.', 10),
('e7546738283249feafa1b81bd7e6cb4b', '690a0954fed74f5988dffe487d13c8cb', 'Let the cakes cool in the pans for 10 minutes, then turn them out onto a wire rack and let them cool completely.', 6),
('e79cb01880734335bba90bb92458bb2f', '4c3ae7de4533480eba020e8d3e1dade9', 'Let the buns cool slightly on a wire rack and serve them fresh.', 9),
('f034a2d1f46540b88bfda7df03d5cf42', '9a135cc0fb4b4cf29644d6ab2077a4be', 'Pour the ganache over the set mousse and spread it out to the edges. Refrigerate for another 30 minutes.', 10),
('f1c886d638ce435a861fca90cd3bca08', '096f4354068e4c168d6d2b9bf7ae968c', 'Place the covered bowl in the fridge and let the dough rise slowly overnight (8–10 hours).', 4),
('f3745b8cbb6745f795b3b687139d3b01', 'e71d8cfea6074e15a6afd56847fc3f36', 'Whip the cream with the powdered sugar to soft peaks. Stir a third of the cream into the chocolate to loosen it, then gently fold in the rest.', 6),
('f40310fed761432ca1f570bddcbc6851', '912d1260b6fa4525820c19e5dfe64ed0', 'Add rucola, serrano, tomatoe and mozarella cheese in this order', 2),
('f4e02bc8012d411ab7247f0a18aca975', '4c3ae7de4533480eba020e8d3e1dade9', 'Add the sugar, salt, cardamom, egg and most of the flour. Knead for 5 minutes, then add the softened butter and knead for another 5–8 minutes until the dough is smooth and elastic. Add the remaining flour if the dough is very sticky.', 2),
('f70b8d084ea14d7f87a7a80ce7b38f87', '096f4354068e4c168d6d2b9bf7ae968c', 'Tip the cold dough onto a floured surface and divide it into 10 pieces. Shape each piece into a tight ball and place them on a baking sheet lined with baking paper.', 5),
('f84ad91274844e45a6dac9abd051067d', 'e71d8cfea6074e15a6afd56847fc3f36', 'Bring the milk to a simmer and remove it from the heat. Squeeze the gelatin and dissolve it in the milk, stir in the licorice powder, then pour the milk into the melted chocolate and stir until smooth. Let it cool to about 35°C.', 5),
('f9a264609ac5424f9d353fb809986536', 'e71d8cfea6074e15a6afd56847fc3f36', 'Squeeze the gelatin and dissolve it in the warm raspberry purée. Let it cool slightly, pour it over the biscuit base and freeze for 30 minutes until firm.', 3),
('fb10d05b7cf04497be3ab904448f3154', '4c3ae7de4533480eba020e8d3e1dade9', 'Brush the buns with beaten egg, sprinkle them with pearl sugar and bake for 10–12 minutes until golden.', 8),
('ffc863161b2a4a8a8dcaa7774b86b648', '690a0954fed74f5988dffe487d13c8cb', 'Cover the top and sides with a thin layer of buttercream and chill the cake for 20 minutes. Finish with the rest of the buttercream.', 9);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `recipes`
--

CREATE TABLE `recipes` (
  `recipe_id` char(32) NOT NULL,
  `user_id` char(32) NOT NULL,
  `recipe_title` varchar(50) NOT NULL,
  `recipe_description` varchar(255) NOT NULL,
  `recipe_img_key` text NOT NULL,
  `recipe_servings` int(11) NOT NULL,
  `recipe_prep_time` int(11) NOT NULL,
  `recipe_cook_time` int(11) NOT NULL,
  `recipe_created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `recipes`
--

INSERT INTO `recipes` (`recipe_id`, `user_id`, `recipe_title`, `recipe_description`, `recipe_img_key`, `recipe_servings`, `recipe_prep_time`, `recipe_cook_time`, `recipe_created_at`) VALUES
('096f4354068e4c168d6d2b9bf7ae968c', '4713bf5f3bff4c288caeb69152db26ae', 'Sourdoughbuns', 'Soft sourdough buns with a crisp crust and a mild tang. Mix the dough in the evening, let it rise slowly in the fridge overnight and bake fresh buns for breakfast. Perfect with butter and cheese.', '5b4872ac59914b0589164410e581862d.webp', 10, 720, 20, 1773412357),
('12ca42a69c334fae817bae027c3286fb', '4713bf5f3bff4c288caeb69152db26ae', 'Lemon Meringue Pie', 'This lemon meringue pie is perfect for sharing. The homemade lemon curd filling is flavored with lemon juice and zest. It’s tart, smooth, and pairs perfectly with the sweet and fluffy meringue topping.', '1917975f922d471cb5c1017a7b0ff0d8.png', 10, 30, 10, 1773413744),
('4c3ae7de4533480eba020e8d3e1dade9', '4713bf5f3bff4c288caeb69152db26ae', 'Cardamombuns', 'Swedish-style cardamom buns with a soft, buttery dough and a fragrant cardamom sugar filling. Twisted into knots and topped with pearl sugar, they are perfect with an afternoon coffee.', '48fa4a40bdb047c190673d3629a55ae1.webp', 10, 120, 12, 1773412357),
('6389e0182fe14449a82ded0bb695f015', '4713bf5f3bff4c288caeb69152db26ae', 'Elderflowermouse cake with lemoncurd', 'A light, summery mousse cake with a crunchy biscuit base, a fluffy elderflower mousse and a tangy layer of homemade lemon curd on top. Make it the day before so it has time to set in the fridge.', 'd780684c550d478e9339ae968945cb6f.webp', 10, 480, 15, 1773412357),
('690a0954fed74f5988dffe487d13c8cb', '4713bf5f3bff4c288caeb69152db26ae', 'Birthdaycake', 'A classic vanilla layer cake with a fluffy sponge, silky vanilla buttercream and plenty of colorful sprinkles. Easy to decorate and guaranteed to put a smile on the face of the birthday guest.', '43a6262288344926810269c10c6bf786.webp', 10, 90, 30, 1773412357),
('912d1260b6fa4525820c19e5dfe64ed0', '4713bf5f3bff4c288caeb69152db26ae', 'Serrano Sandwich with Sourdoughbread', 'This recipe is an easy and quick way to make some lunch on a summer day.', '1d532eb6d08c4750a690d298ff3df869.jpg', 1, 10, 0, 1773414011),
('9a135cc0fb4b4cf29644d6ab2077a4be', '4713bf5f3bff4c288caeb69152db26ae', 'Raspberrymouse cake with chocolate ganache', 'A light chocolate sponge topped with a fresh, fruity raspberry mousse and a glossy dark chocolate ganache. The balance of tart berries and rich chocolate makes it a perfect cake for any celebration.', 'e9e315c9c6d747d992e4161460b8016a.webp', 10, 420, 20, 1773413393),
('a64cf46c0cb34210a27744e7e2ee7698', '4713bf5f3bff4c288caeb69152db26ae', 'Chocolate Chip Cookies', 'Classic chocolate chip cookies with crispy edges and a soft, chewy center. Browned butter gives them a deep, caramel-like flavor, and a pinch of flaky sea salt on top makes the chocolate shine.', 'fae7b48ba04c4b29a952e8d7eb6924ac.webp', 10, 45, 12, 1773413412),
('e71d8cfea6074e15a6afd56847fc3f36', '4713bf5f3bff4c288caeb69152db26ae', 'Chocolatemouse cake with raspberry &  licorice', 'A rich dark chocolate mousse cake on a crunchy chocolate biscuit base with a hidden layer of raspberry jelly. Raw licorice powder adds a subtle Scandinavian twist that pairs beautifully with chocolate.', '2c7864f0970240f48893d8844181a40e.webp', 10, 420, 10, 1773412529);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `recipes_ingridients`
--

CREATE TABLE `recipes_ingridients` (
  `recipe_fk` char(32) NOT NULL,
  `ingridient_fk` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users`
--

CREATE TABLE `users` (
  `user_id` char(32) NOT NULL,
  `user_username` varchar(20) NOT NULL,
  `user_first_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_country_id` char(32) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_created_at` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `users`
--

INSERT INTO `users` (`user_id`, `user_username`, `user_first_name`, `user_last_name`, `user_country_id`, `user_phone`, `user_password`, `user_email`, `user_created_at`) VALUES
('4713bf5f3bff4c288caeb69152db26ae', 'Test', 'Food', 'Head', '1', '12345678', 'scrypt:32768:8:1$fpHrStCWC0JK8tQO$a57dfd6d9669d574d66aa81c77e7c1411bc95ee029ded02b518fb025a49fa0b17309768ec4d5850dc6980ef4d5d18a4c4090ddca52d2811463173e93f06d28e7', 'test@123.com', 1773265128);

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_id`),
  ADD UNIQUE KEY `country_name` (`country_name`);

--
-- Indeks for tabel `ingridients`
--
ALTER TABLE `ingridients`
  ADD PRIMARY KEY (`ingridient_id`);

--
-- Indeks for tabel `instructions`
--
ALTER TABLE `instructions`
  ADD PRIMARY KEY (`instruction_id`),
  ADD KEY `recipe_fk` (`recipe_fk`);

--
-- Indeks for tabel `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipe_id`);

--
-- Indeks for tabel `recipes_ingridients`
--
ALTER TABLE `recipes_ingridients`
  ADD PRIMARY KEY (`recipe_fk`,`ingridient_fk`),
  ADD KEY `ingridient_fk` (`ingridient_fk`);

--
-- Indeks for tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_username` (`user_username`),
  ADD KEY `user_country_id` (`user_country_id`);

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `instructions`
--
ALTER TABLE `instructions`
  ADD CONSTRAINT `instructions_ibfk_1` FOREIGN KEY (`recipe_fk`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `recipes_ingridients`
--
ALTER TABLE `recipes_ingridients`
  ADD CONSTRAINT `recipes_ingridients_ibfk_1` FOREIGN KEY (`ingridient_fk`) REFERENCES `ingridients` (`ingridient_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recipes_ingridients_ibfk_2` FOREIGN KEY (`recipe_fk`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_country_id`) REFERENCES `countries` (`country_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
