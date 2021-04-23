-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 23, 2021 at 12:02 PM
-- Server version: 10.3.28-MariaDB-log-cll-lve
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tekajexy_fix`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(7) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `tgl_input` date NOT NULL,
  `spek` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `jenis_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `tgl_input`, `spek`, `stok`, `satuan_id`, `jenis_id`) VALUES
('B000001', 'Tang Krimping', '0000-00-00', 'TKI2', 9, 1, 2),
('BSW0002', 'Router', '2021-04-20', '', 0, 1, 8),
('KEY0000', 'Keyboard', '0000-00-00', 'Rapoo', 36, 1, 3),
('MON0001', 'Monitor', '0000-00-00', 'HP', 0, 1, 3),
('MS00001', 'Mouse', '0000-00-00', 'Rapoo', 0, 1, 3),
('SW0001', 'Switch', '0000-00-00', 'TP-Link', 13, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang_keluar` char(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_keluar` int(11) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `ket` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang_keluar`, `user_id`, `barang_id`, `jumlah_keluar`, `tanggal_keluar`, `ket`) VALUES
('T-BK-21041900001', 1, 'KEY0000', 18, '2021-04-19', 'Rusak');

--
-- Triggers `barang_keluar`
--
DELIMITER $$
CREATE TRIGGER `update_stok_keluar` BEFORE INSERT ON `barang_keluar` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.jumlah_keluar WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang_masuk` char(16) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `status` varchar(255) NOT NULL,
  `jumlah_masuk` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `supplier_id`, `user_id`, `barang_id`, `status`, `jumlah_masuk`, `tanggal_masuk`) VALUES
('T-BM-21041900001', 2, 1, 'SW0001', 'Baru', 13, '2021-04-19'),
('T-BM-21041900002', 3, 1, 'KEY0000', 'Baru', 42, '2021-04-19');

--
-- Triggers `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `update_stok_masuk` BEFORE INSERT ON `barang_masuk` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + NEW.jumlah_masuk WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `jenis`
--

CREATE TABLE `jenis` (
  `id_jenis` int(11) NOT NULL,
  `nama_jenis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jenis`
--

INSERT INTO `jenis` (`id_jenis`, `nama_jenis`) VALUES
(1, 'Kabel'),
(2, 'Perkakas'),
(3, 'Perangkat Komputer'),
(4, 'Material'),
(5, 'Perlengkapan'),
(8, 'Alat');

-- --------------------------------------------------------

--
-- Table structure for table `satuan`
--

CREATE TABLE `satuan` (
  `id_satuan` int(11) NOT NULL,
  `nama_satuan` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `satuan`
--

INSERT INTO `satuan` (`id_satuan`, `nama_satuan`) VALUES
(1, 'Unit'),
(2, 'Meter'),
(3, 'Pcs'),
(5, 'CM'),
(6, 'Kilogram');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `toko` varchar(255) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  `npwp` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `toko`, `no_telp`, `alamat`, `npwp`) VALUES
(1, 'Fathurahman', 'Barokah', '08123456', 'CIketing Udik', 812312312),
(2, 'Rizky Novan', 'Toko Maju', '0812345', 'Griya', 12000134),
(3, 'Suhman', 'Toko Mundur', '083123124', 'Ciketing', 12123123);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `role` enum('gudang','admin') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  `foto` text NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `email`, `no_telp`, `role`, `password`, `created_at`, `foto`, `is_active`) VALUES
(1, 'Ferdian', 'admin', 'ferdikennedy@protonmail.com', '081318563101', 'admin', '$2y$10$B2I69jExC.rOtPKxpI7NJePHyQLTJ3XVoJFNlQYKLgh94ZVvfG70e', 1568689561, 'user.png', 1),
(7, 'Ferdi S Kennedy', 'ferdian', 'ferdi@admin.com', '081318563101', 'admin', '$2y$10$5es8WhFQj8xCmrhDtH86Fu71j97og9f8aR4T22soa7716kAusmaeK', 1568691611, 'user.png', 1),
(8, 'Fathurahman', 'fathur', 'fathur@gudang.com', '0813123124', 'gudang', '$2y$10$5SGUIbRyEXH7JslhtEegEOpp6cvxtK6X.qdiQ1eZR7nd0RZjjx3qe', 1568691629, 'user.png', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `satuan_id` (`satuan_id`),
  ADD KEY `kategori_id` (`jenis_id`);

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_barang_keluar`),
  ADD KEY `id_user` (`user_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang_masuk`),
  ADD KEY `id_user` (`user_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indexes for table `jenis`
--
ALTER TABLE `jenis`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`id_satuan`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jenis`
--
ALTER TABLE `jenis`
  MODIFY `id_jenis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `satuan`
--
ALTER TABLE `satuan`
  MODIFY `id_satuan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`satuan_id`) REFERENCES `satuan` (`id_satuan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`jenis_id`) REFERENCES `jenis` (`id_jenis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_3` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
