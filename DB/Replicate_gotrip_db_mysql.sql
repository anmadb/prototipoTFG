DROP TABLE IF EXISTS `Friendship`;
DROP TABLE IF EXISTS `Messages`;
DROP TABLE IF EXISTS `Reactions`;
DROP TABLE IF EXISTS `Posts`;
DROP TABLE IF EXISTS `TypeOfReactions`;
DROP TABLE IF EXISTS `Users`;

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `bio` varchar(255),
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_avatar_index` (`avatar`),
  KEY `users_bio_index` (`bio`),
  KEY `users_password_index` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `Friendship`
--

CREATE TABLE `Friendship` (
  `id` bigint NOT NULL,
  `user-id` bigint NOT NULL,
  `friend-id` bigint NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `friendship_user_id_unique` (`user-id`),
  UNIQUE KEY `friendship_friend_id_unique` (`friend-id`),
  CONSTRAINT `friendship_friend_id_foreign` FOREIGN KEY (`friend-id`) REFERENCES `Users` (`id`),
  CONSTRAINT `friendship_user_id_foreign` FOREIGN KEY (`user-id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `Posts`
--

CREATE TABLE `Posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user-id` bigint NOT NULL,
  `img` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `geoCode` json DEFAULT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_description_index` (`description`),
  KEY `posts_img_index` (`img`),
  CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user-id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



INSERT INTO `Users` (`id`, `username`, `email`, `password`, `avatar`, `bio`, `created_at`) VALUES
(1, 'juanperez', 'juan.perez@mail.com', 'hashed_password1', 'juan_avatar.png', 'Apasionado por la fotografía y la tecnología.', '2025-02-14'),
(2, 'maria_lopez', 'maria.lopez@mail.com', 'hashed_password2', 'maria_avatar.png', 'Diseñadora gráfica y amante del café.', '2025-02-14'),
(3, 'carlosgomez', 'carlos.gomez@mail.com', 'hashed_password3', 'carlos_avatar.png', 'Jugador de ajedrez y programador backend.', '2025-02-14'),
(4, 'lucia_rodriguez', 'lucia.rodriguez@mail.com', 'hashed_password4', 'lucia_avatar.png', 'Fan del cine clásico y la literatura.', '2025-02-14'),
(5, 'diego_fernandez', 'diego.fernandez@mail.com', 'hashed_password5', 'diego_avatar.png', 'Guitarrista aficionado y viajero frecuente.', '2025-02-14');

--
-- Dumping data for table `Posts`
--

INSERT INTO `Posts` (`latitude`,`longitude`) VALUES
( '48.8566','2.3522'),
('40.7128', '-74.006'),
('34.0522',' -118.2437'),
('51.5074',' -0.1278'),
('19.4326',' -99.1332')
where id is < 5;

INSERT INTO posts ("user-id","img","description","latitude","longitude") values ('','','','','');


-- Set auto-increment values
ALTER TABLE `Users` AUTO_INCREMENT=6;
ALTER TABLE `Posts` AUTO_INCREMENT=6;