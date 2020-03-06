-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2020 at 04:45 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `univisit`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()  SELECT * FROM user$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(10) DEFAULT NULL,
  `admin_email` varchar(20) DEFAULT NULL,
  `admin_password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `admin_name`, `admin_email`, `admin_password`) VALUES
(2, 'matt', 'matt_enad@yahoo.com', '827ccb0eea8a706c4c34a16891f84e7b'),
(3, 'hudas', 'hudaas@virgin.com', '111');

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

CREATE TABLE `record` (
  `record_id` int(11) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `visitor_type` varchar(50) DEFAULT NULL,
  `visitor_school` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `visitor_purpose` varchar(50) DEFAULT NULL,
  `visitor_image` text DEFAULT NULL,
  `visitor_id` int(50) DEFAULT NULL,
  `visitor_status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`record_id`, `user_id`, `visitor_type`, `visitor_school`, `date`, `time`, `visitor_purpose`, `visitor_image`, `visitor_id`, `visitor_status`) VALUES
(10, 1, 'Student', 'UC-Main', '2020-03-16', '08:22:26', 'Others', 'http://10.0.2.2:8080/dbproject/uploads/sample.png', 1234, 'Declined'),
(11, 1, 'Student', 'UC-Main', '2020-03-10', '19:42:28', 'Clearance', 'http://10.0.2.2:8080/dbproject/uploads/matt.png', 12345, 'Declined'),
(12, 5, 'Parent', 'UC-Main', '2020-03-12', '20:40:22', 'Clearance', 'http://10.0.2.2:8080/dbproject/uploads/sss.png', 1234567, 'Accepted'),
(13, 4, 'Parent', 'UC-Main', '2020-03-06', '09:29:54', '', 'http://10.0.2.2:8080/dbproject/uploads/idpic.png', 12134458, 'Accepted'),
(14, 4, 'Student', 'UC-Banilad', '2020-03-05', '09:31:48', 'Diploma/TOR', 'http://10.0.2.2:8080/dbproject/uploads/diploma.png', 11122233, 'Accepted'),
(15, 4, 'Other', 'UC-Banilad', '2020-03-06', '09:53:35', 'chill chill ra ko brad', 'http://10.0.2.2:8080/dbproject/uploads/chilljpeg.png', 11111, 'Pending'),
(16, 4, 'trabahante', 'UC-Banilad', '2020-03-06', '09:56:37', 'manglimpyo ra ko', 'http://10.0.2.2:8080/dbproject/uploads/manglimpyo.jpeg.png', 999, 'Pending'),
(17, 4, 'Parent', 'UC-Main', '2020-03-18', '20:01:54', 'Clearance', 'http://10.0.2.2:8080/dbproject/uploads/sample.png', 12345, 'Accepted'),
(18, 4, 'Alumni', 'UC-Main', '2020-03-15', '07:03:55', 'Clearance', 'http://10.0.2.2:8080/dbproject/uploads/wawa.png', 123456, 'Accepted');

--
-- Triggers `record`
--
DELIMITER $$
CREATE TRIGGER `sampleTrigger` AFTER UPDATE ON `record` FOR EACH ROW BEGIN
	IF (NEW.visitor_status = 'Accepted') THEN
        INSERT INTO record_logs(rec_id, time, action)
        VALUES(NEW.record_id, NOW(), 'Accepted');
   	ELSE
    	INSERT INTO record_logs(rec_id, time, action)
        VALUES(NEW.record_id, NOW(), 'Declined');
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `record_logs`
--

CREATE TABLE `record_logs` (
  `rec_log_id` int(11) NOT NULL,
  `rec_id` int(11) NOT NULL,
  `time` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `action` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `record_logs`
--

INSERT INTO `record_logs` (`rec_log_id`, `rec_id`, `time`, `action`) VALUES
(1, 13, '2020-03-06 11:36:21', 'Accepted'),
(2, 10, '2020-03-06 11:38:28', 'Accepted'),
(3, 11, '2020-03-06 11:38:40', 'Declined'),
(4, 10, '2020-03-06 11:39:04', 'Declined'),
(5, 14, '2020-03-06 11:39:12', 'Accepted'),
(6, 17, '2020-03-06 11:41:46', 'Pending'),
(7, 18, '2020-03-06 11:42:13', 'Accepted');

-- --------------------------------------------------------

--
-- Table structure for table `registration_logs`
--

CREATE TABLE `registration_logs` (
  `log_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `action` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registration_logs`
--

INSERT INTO `registration_logs` (`log_id`, `id`, `time`, `action`) VALUES
(3, 6, '2020-03-06 03:10:20', 'Registered');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `user_fname` varchar(10) DEFAULT NULL,
  `user_lname` varchar(10) DEFAULT NULL,
  `user_address` varchar(20) DEFAULT NULL,
  `user_contact` varchar(10) DEFAULT NULL,
  `user_uname` varchar(10) DEFAULT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  `user_password` varchar(50) DEFAULT NULL,
  `user_photo` text DEFAULT NULL,
  `user_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `user_fname`, `user_lname`, `user_address`, `user_contact`, `user_uname`, `user_email`, `user_password`, `user_photo`, `user_status`) VALUES
(1, 'richard', 'enad', 'carcar', '123456', 'matt', '@me.com', '827ccb0eea8a706c4c34a16891f84e7b', 'http://10.0.2.2:8080/dbproject/uploads/sample.png', 'Inactive'),
(4, 'matias', 'enad', 'kalunasan', '1234', 'hudas', 'hudas2mail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'http://10.0.2.2:8080/dbproject/uploads/judas.png', 'Inactive'),
(5, 'dennis', 'durano', 'guadalupe', '12345', 'tidert', 'ddthanos@mail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'http://10.0.2.2:8080/dbproject/uploads/sample.png', 'Active'),
(6, 'jun', 'amante', 'lorega', '1231231231', 'june@me.co', 'june@gmail.com', '123', '', 'active');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `triggerMaster` AFTER INSERT ON `user` FOR EACH ROW INSERT INTO registration_logs VALUES(null, NEW.id, NOW(), 'Registered')
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `record_logs`
--
ALTER TABLE `record_logs`
  ADD PRIMARY KEY (`rec_log_id`);

--
-- Indexes for table `registration_logs`
--
ALTER TABLE `registration_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `logs_ibfk_1` (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `record`
--
ALTER TABLE `record`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `record_logs`
--
ALTER TABLE `record_logs`
  MODIFY `rec_log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `registration_logs`
--
ALTER TABLE `registration_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `registration_logs`
--
ALTER TABLE `registration_logs`
  ADD CONSTRAINT `registration_logs_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
