-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 07, 2017 at 06:55 AM
-- Server version: 5.6.33
-- PHP Version: 7.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `artlife`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(10) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `users_id` int(10) NOT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `country_id` int(10) NOT NULL,
  `status` int(10) DEFAULT NULL,
  `cuid` int(11) DEFAULT NULL,
  `uuid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) NOT NULL,
  `parentid` int(10) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `category_key` varchar(45) DEFAULT NULL,
  `meta` text,
  `cuid` int(10) DEFAULT NULL,
  `uuid` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parentid`, `name`, `category_key`, `meta`, `cuid`, `uuid`, `created_at`, `updated_at`) VALUES
(1, 0, 'Paints', 'paints', '{"description":"This is a paint\\r\\n                            "}', 1, 1, '2016-10-06 14:37:08', '2016-11-16 19:39:05'),
(2, 0, 'Pencil', 'pencil', '{"description":"This is a pencil"}', 1, 1, '2016-10-06 14:57:09', '2016-10-06 14:57:09'),
(3, 0, 'Demo category ', 'demo category ', '{"description":"sample demo category"}', 1, 1, '2016-10-08 12:13:52', '2016-10-08 12:13:52'),
(4, 1, 'Demo category 4', 'demo category 4', '{"description":"sample demo category"}', 1, 1, '2016-10-08 12:14:50', '2016-10-08 12:14:50'),
(5, 4, 'Electronic', 'electronic', '{"description":"vbvb h gh se"}', 1, 1, '2016-10-08 13:01:38', '2016-10-08 13:01:38'),
(6, 5, 'Demo 123', 'demo 123', '{"description":"Newly created one"}', 1, 1, '2016-10-14 05:41:55', '2016-10-14 05:41:55'),
(7, 4, 'Demo 123', 'demo 123', '{"description":"This is updated"}', 1, 1, '2016-10-14 05:52:04', '2016-10-14 05:52:23'),
(8, 5, 'Reshan', 'reshan', '{"description":""}', 1, 1, '2017-01-06 05:22:35', '2017-01-06 05:22:35'),
(9, 5, 'Chamal', 'chamal', '{"description":""}', 1, 1, '2017-01-06 05:22:44', '2017-01-06 05:22:44'),
(10, 0, 'Demo 123', 'demo 123', '{"description":""}', 1, 1, '2017-01-07 07:55:55', '2017-01-07 07:55:55');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `currency_code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`, `code`, `currency_code`) VALUES
(2, 'Andorra', 'AD', 'EUR'),
(3, 'United Arab Emirates', 'AE', 'AED'),
(4, 'Afghanistan', 'AF', 'AFN'),
(5, 'Antigua and Barbuda', 'AG', 'XCD'),
(6, 'Anguilla', 'AI', 'XCD'),
(7, 'Albania', 'AL', 'ALL'),
(8, 'Armenia', 'AM', 'AMD'),
(9, 'Angola', 'AO', 'AOA'),
(10, 'Antarctica', 'AQ', ''),
(11, 'Argentina', 'AR', 'ARS'),
(12, 'American Samoa', 'AS', 'USD'),
(13, 'Austria', 'AT', 'EUR'),
(14, 'Australia', 'AU', 'AUD'),
(15, 'Aruba', 'AW', 'AWG'),
(16, 'Åland', 'AX', 'EUR'),
(17, 'Azerbaijan', 'AZ', 'AZN'),
(18, 'Bosnia and Herzegovina', 'BA', 'BAM'),
(19, 'Barbados', 'BB', 'BBD'),
(20, 'Bangladesh', 'BD', 'BDT'),
(21, 'Belgium', 'BE', 'EUR'),
(22, 'Burkina Faso', 'BF', 'XOF'),
(23, 'Bulgaria', 'BG', 'BGN'),
(24, 'Bahrain', 'BH', 'BHD'),
(25, 'Burundi', 'BI', 'BIF'),
(26, 'Benin', 'BJ', 'XOF'),
(27, 'Saint Barthélemy', 'BL', 'EUR'),
(28, 'Bermuda', 'BM', 'BMD'),
(29, 'Brunei', 'BN', 'BND'),
(30, 'Bolivia', 'BO', 'BOB'),
(31, 'Bonaire', 'BQ', 'USD'),
(32, 'Brazil', 'BR', 'BRL'),
(33, 'Bahamas', 'BS', 'BSD'),
(34, 'Bhutan', 'BT', 'BTN'),
(35, 'Bouvet Island', 'BV', 'NOK'),
(36, 'Botswana', 'BW', 'BWP'),
(37, 'Belarus', 'BY', 'BYR'),
(38, 'Belize', 'BZ', 'BZD'),
(39, 'Canada', 'CA', 'CAD'),
(40, 'Cocos [Keeling] Islands', 'CC', 'AUD'),
(41, 'Democratic Republic of the Congo', 'CD', 'CDF'),
(42, 'Central African Republic', 'CF', 'XAF'),
(43, 'Republic of the Congo', 'CG', 'XAF'),
(44, 'Switzerland', 'CH', 'CHF'),
(45, 'Ivory Coast', 'CI', 'XOF'),
(46, 'Cook Islands', 'CK', 'NZD'),
(47, 'Chile', 'CL', 'CLP'),
(48, 'Cameroon', 'CM', 'XAF'),
(49, 'China', 'CN', 'CNY'),
(50, 'Colombia', 'CO', 'COP'),
(51, 'Costa Rica', 'CR', 'CRC'),
(52, 'Cuba', 'CU', 'CUP'),
(53, 'Cape Verde', 'CV', 'CVE'),
(54, 'Curacao', 'CW', 'ANG'),
(55, 'Christmas Island', 'CX', 'AUD'),
(56, 'Cyprus', 'CY', 'EUR'),
(57, 'Czechia', 'CZ', 'CZK'),
(58, 'Germany', 'DE', 'EUR'),
(59, 'Djibouti', 'DJ', 'DJF'),
(60, 'Denmark', 'DK', 'DKK'),
(61, 'Dominica', 'DM', 'XCD'),
(62, 'Dominican Republic', 'DO', 'DOP'),
(63, 'Algeria', 'DZ', 'DZD'),
(64, 'Ecuador', 'EC', 'USD'),
(65, 'Estonia', 'EE', 'EUR'),
(66, 'Egypt', 'EG', 'EGP'),
(67, 'Western Sahara', 'EH', 'MAD'),
(68, 'Eritrea', 'ER', 'ERN'),
(69, 'Spain', 'ES', 'EUR'),
(70, 'Ethiopia', 'ET', 'ETB'),
(71, 'Finland', 'FI', 'EUR'),
(72, 'Fiji', 'FJ', 'FJD'),
(73, 'Falkland Islands', 'FK', 'FKP'),
(74, 'Micronesia', 'FM', 'USD'),
(75, 'Faroe Islands', 'FO', 'DKK'),
(76, 'France', 'FR', 'EUR'),
(77, 'Gabon', 'GA', 'XAF'),
(78, 'United Kingdom', 'GB', 'GBP'),
(79, 'Grenada', 'GD', 'XCD'),
(80, 'Georgia', 'GE', 'GEL'),
(81, 'French Guiana', 'GF', 'EUR'),
(82, 'Guernsey', 'GG', 'GBP'),
(83, 'Ghana', 'GH', 'GHS'),
(84, 'Gibraltar', 'GI', 'GIP'),
(85, 'Greenland', 'GL', 'DKK'),
(86, 'Gambia', 'GM', 'GMD'),
(87, 'Guinea', 'GN', 'GNF'),
(88, 'Guadeloupe', 'GP', 'EUR'),
(89, 'Equatorial Guinea', 'GQ', 'XAF'),
(90, 'Greece', 'GR', 'EUR'),
(91, 'South Georgia and the South Sandwich Islands', 'GS', 'GBP'),
(92, 'Guatemala', 'GT', 'GTQ'),
(93, 'Guam', 'GU', 'USD'),
(94, 'Guinea-Bissau', 'GW', 'XOF'),
(95, 'Guyana', 'GY', 'GYD'),
(96, 'Hong Kong', 'HK', 'HKD'),
(97, 'Heard Island and McDonald Islands', 'HM', 'AUD'),
(98, 'Honduras', 'HN', 'HNL'),
(99, 'Croatia', 'HR', 'HRK'),
(100, 'Haiti', 'HT', 'HTG'),
(101, 'Hungary', 'HU', 'HUF'),
(102, 'Indonesia', 'ID', 'IDR'),
(103, 'Ireland', 'IE', 'EUR'),
(104, 'Israel', 'IL', 'ILS'),
(105, 'Isle of Man', 'IM', 'GBP'),
(106, 'India', 'IN', 'INR'),
(107, 'British Indian Ocean Territory', 'IO', 'USD'),
(108, 'Iraq', 'IQ', 'IQD'),
(109, 'Iran', 'IR', 'IRR'),
(110, 'Iceland', 'IS', 'ISK'),
(111, 'Italy', 'IT', 'EUR'),
(112, 'Jersey', 'JE', 'GBP'),
(113, 'Jamaica', 'JM', 'JMD'),
(114, 'Jordan', 'JO', 'JOD'),
(115, 'Japan', 'JP', 'JPY'),
(116, 'Kenya', 'KE', 'KES'),
(117, 'Kyrgyzstan', 'KG', 'KGS'),
(118, 'Cambodia', 'KH', 'KHR'),
(119, 'Kiribati', 'KI', 'AUD'),
(120, 'Comoros', 'KM', 'KMF'),
(121, 'Saint Kitts and Nevis', 'KN', 'XCD'),
(122, 'North Korea', 'KP', 'KPW'),
(123, 'South Korea', 'KR', 'KRW'),
(124, 'Kuwait', 'KW', 'KWD'),
(125, 'Cayman Islands', 'KY', 'KYD'),
(126, 'Kazakhstan', 'KZ', 'KZT'),
(127, 'Laos', 'LA', 'LAK'),
(128, 'Lebanon', 'LB', 'LBP'),
(129, 'Saint Lucia', 'LC', 'XCD'),
(130, 'Liechtenstein', 'LI', 'CHF'),
(131, 'Sri Lanka', 'LK', 'LKR'),
(132, 'Liberia', 'LR', 'LRD'),
(133, 'Lesotho', 'LS', 'LSL'),
(134, 'Lithuania', 'LT', 'EUR'),
(135, 'Luxembourg', 'LU', 'EUR'),
(136, 'Latvia', 'LV', 'EUR'),
(137, 'Libya', 'LY', 'LYD'),
(138, 'Morocco', 'MA', 'MAD'),
(139, 'Monaco', 'MC', 'EUR'),
(140, 'Moldova', 'MD', 'MDL'),
(141, 'Montenegro', 'ME', 'EUR'),
(142, 'Saint Martin', 'MF', 'EUR'),
(143, 'Madagascar', 'MG', 'MGA'),
(144, 'Marshall Islands', 'MH', 'USD'),
(145, 'Macedonia', 'MK', 'MKD'),
(146, 'Mali', 'ML', 'XOF'),
(147, 'Myanmar [Burma]', 'MM', 'MMK'),
(148, 'Mongolia', 'MN', 'MNT'),
(149, 'Macao', 'MO', 'MOP'),
(150, 'Northern Mariana Islands', 'MP', 'USD'),
(151, 'Martinique', 'MQ', 'EUR'),
(152, 'Mauritania', 'MR', 'MRO'),
(153, 'Montserrat', 'MS', 'XCD'),
(154, 'Malta', 'MT', 'EUR'),
(155, 'Mauritius', 'MU', 'MUR'),
(156, 'Maldives', 'MV', 'MVR'),
(157, 'Malawi', 'MW', 'MWK'),
(158, 'Mexico', 'MX', 'MXN'),
(159, 'Malaysia', 'MY', 'MYR'),
(160, 'Mozambique', 'MZ', 'MZN'),
(161, 'Namibia', 'NA', 'NAD'),
(162, 'New Caledonia', 'NC', 'XPF'),
(163, 'Niger', 'NE', 'XOF'),
(164, 'Norfolk Island', 'NF', 'AUD'),
(165, 'Nigeria', 'NG', 'NGN'),
(166, 'Nicaragua', 'NI', 'NIO'),
(167, 'Netherlands', 'NL', 'EUR'),
(168, 'Norway', 'NO', 'NOK'),
(169, 'Nepal', 'NP', 'NPR'),
(170, 'Nauru', 'NR', 'AUD'),
(171, 'Niue', 'NU', 'NZD'),
(172, 'New Zealand', 'NZ', 'NZD'),
(173, 'Oman', 'OM', 'OMR'),
(174, 'Panama', 'PA', 'PAB'),
(175, 'Peru', 'PE', 'PEN'),
(176, 'French Polynesia', 'PF', 'XPF'),
(177, 'Papua New Guinea', 'PG', 'PGK'),
(178, 'Philippines', 'PH', 'PHP'),
(179, 'Pakistan', 'PK', 'PKR'),
(180, 'Poland', 'PL', 'PLN'),
(181, 'Saint Pierre and Miquelon', 'PM', 'EUR'),
(182, 'Pitcairn Islands', 'PN', 'NZD'),
(183, 'Puerto Rico', 'PR', 'USD'),
(184, 'Palestine', 'PS', 'ILS'),
(185, 'Portugal', 'PT', 'EUR'),
(186, 'Palau', 'PW', 'USD'),
(187, 'Paraguay', 'PY', 'PYG'),
(188, 'Qatar', 'QA', 'QAR'),
(189, 'Réunion', 'RE', 'EUR'),
(190, 'Romania', 'RO', 'RON'),
(191, 'Serbia', 'RS', 'RSD'),
(192, 'Russia', 'RU', 'RUB'),
(193, 'Rwanda', 'RW', 'RWF'),
(194, 'Saudi Arabia', 'SA', 'SAR'),
(195, 'Solomon Islands', 'SB', 'SBD'),
(196, 'Seychelles', 'SC', 'SCR'),
(197, 'Sudan', 'SD', 'SDG'),
(198, 'Sweden', 'SE', 'SEK'),
(199, 'Singapore', 'SG', 'SGD'),
(200, 'Saint Helena', 'SH', 'SHP'),
(201, 'Slovenia', 'SI', 'EUR'),
(202, 'Svalbard and Jan Mayen', 'SJ', 'NOK'),
(203, 'Slovakia', 'SK', 'EUR'),
(204, 'Sierra Leone', 'SL', 'SLL'),
(205, 'San Marino', 'SM', 'EUR'),
(206, 'Senegal', 'SN', 'XOF'),
(207, 'Somalia', 'SO', 'SOS'),
(208, 'Suriname', 'SR', 'SRD'),
(209, 'South Sudan', 'SS', 'SSP'),
(210, 'São Tomé and Príncipe', 'ST', 'STD'),
(211, 'El Salvador', 'SV', 'USD'),
(212, 'Sint Maarten', 'SX', 'ANG'),
(213, 'Syria', 'SY', 'SYP'),
(214, 'Swaziland', 'SZ', 'SZL'),
(215, 'Turks and Caicos Islands', 'TC', 'USD'),
(216, 'Chad', 'TD', 'XAF'),
(217, 'French Southern Territories', 'TF', 'EUR'),
(218, 'Togo', 'TG', 'XOF'),
(219, 'Thailand', 'TH', 'THB'),
(220, 'Tajikistan', 'TJ', 'TJS'),
(221, 'Tokelau', 'TK', 'NZD'),
(222, 'East Timor', 'TL', 'USD'),
(223, 'Turkmenistan', 'TM', 'TMT'),
(224, 'Tunisia', 'TN', 'TND'),
(225, 'Tonga', 'TO', 'TOP'),
(226, 'Turkey', 'TR', 'TRY'),
(227, 'Trinidad and Tobago', 'TT', 'TTD'),
(228, 'Tuvalu', 'TV', 'AUD'),
(229, 'Taiwan', 'TW', 'TWD'),
(230, 'Tanzania', 'TZ', 'TZS'),
(231, 'Ukraine', 'UA', 'UAH'),
(232, 'Uganda', 'UG', 'UGX'),
(233, 'U.S. Minor Outlying Islands', 'UM', 'USD'),
(234, 'United States', 'US', 'USD'),
(235, 'Uruguay', 'UY', 'UYU'),
(236, 'Uzbekistan', 'UZ', 'UZS'),
(237, 'Vatican City', 'VA', 'EUR'),
(238, 'Saint Vincent and the Grenadines', 'VC', 'XCD'),
(239, 'Venezuela', 'VE', 'VEF'),
(240, 'British Virgin Islands', 'VG', 'USD'),
(241, 'U.S. Virgin Islands', 'VI', 'USD'),
(242, 'Vietnam', 'VN', 'VND'),
(243, 'Vanuatu', 'VU', 'VUV'),
(244, 'Wallis and Futuna', 'WF', 'XPF'),
(245, 'Samoa', 'WS', 'WST'),
(246, 'Kosovo', 'XK', 'EUR'),
(247, 'Yemen', 'YE', 'YER'),
(248, 'Mayotte', 'YT', 'EUR'),
(249, 'South Africa', 'ZA', 'ZAR'),
(250, 'Zambia', 'ZM', 'ZMW'),
(251, 'Zimbabwe', 'ZW', 'ZWL');

-- --------------------------------------------------------

--
-- Table structure for table `login_details`
--

CREATE TABLE `login_details` (
  `id` int(10) NOT NULL,
  `users_id` int(10) NOT NULL,
  `meta` text,
  `login_at` timestamp NULL DEFAULT NULL,
  `logedout_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login_details`
--

INSERT INTO `login_details` (`id`, `users_id`, `meta`, `login_at`, `logedout_at`) VALUES
(1, 1, '', '2017-02-04 16:59:39', '2017-02-04 17:10:50'),
(2, 2, '', '2016-11-16 20:50:25', '2016-11-16 20:50:27'),
(3, 3, '', '2017-01-30 13:01:24', '2017-01-30 14:01:05'),
(4, 4, '', '2017-01-30 14:02:14', '2017-01-30 14:04:47'),
(5, 5, '', '2017-01-30 11:40:20', '2017-01-30 11:41:24'),
(6, 6, '', '2017-02-04 15:41:14', '2017-02-04 15:44:30');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) NOT NULL,
  `users_id` int(10) NOT NULL,
  `number_of_products` int(11) DEFAULT NULL,
  `total` decimal(12,4) DEFAULT NULL,
  `meta` text,
  `status` int(11) DEFAULT NULL,
  `cuid` int(11) DEFAULT NULL,
  `uuid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) NOT NULL,
  `categories_id` int(10) NOT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `weight` decimal(12,2) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `product_price` decimal(12,2) DEFAULT NULL,
  `selling_price` decimal(12,2) DEFAULT NULL,
  `shipping_price` decimal(12,2) DEFAULT NULL,
  `meta` text,
  `status` int(11) DEFAULT NULL,
  `cuid` int(10) DEFAULT NULL,
  `uuid` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `categories_id`, `sku`, `barcode`, `name`, `weight`, `qty`, `product_price`, `selling_price`, `shipping_price`, `meta`, `status`, `cuid`, `uuid`, `created_at`, `updated_at`) VALUES
(1, 1, 'AL1223', '', '12 color pencil', '0.00', 6, '130.00', '130.00', '0.00', '{"depth":0.0,"weight_unit":1,"supplier":{"supplier_country":2,"supplier":"Demo sup","supplier_email":"sup@sup.com","supplier_web":"http:\\/\\/www.lipsum.com\\/feed\\/html"},"width":0.0,"description":{"short":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.","long":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet."},"brandname":"Pental","manufacturer":{"manufacturer_email":"manu@manu.com","manufacturer_web":"http:\\/\\/www.lipsum.com\\/feed\\/html","manufacturer_country":131,"manufacturer":"Demo manu"},"length_unit":1,"height":0.0}', 1, 1, 1, '2017-01-27 18:12:50', '2017-01-27 18:12:50'),
(2, 1, 'AL1', '86868', 'Water colors', '5.00', 100, '200.00', '250.00', '50.00', '{"depth":67.98,"weight_unit":1,"supplier":{"supplier_country":1,"supplier":"Demo sup","supplier_email":"sup@sup.com","supplier_web":"http:\\/\\/www.lipsum.com\\/feed\\/html"},"width":45.97,"description":{"short":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.","long":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet."},"brandname":"Pental","manufacturer":{"manufacturer_email":"manu@manu.com","manufacturer_web":"http:\\/\\/www.lipsum.com\\/feed\\/html","manufacturer_country":1,"manufacturer":"Demo manu"},"length_unit":1,"height":12.88}', 1, 1, 1, '2016-10-22 08:56:58', '2016-10-22 08:56:58'),
(3, 3, 'ALboard12', '123456', 'Art Board', '0.00', 100, '2500.00', '2500.00', '0.00', '{"depth":0.0,"weight_unit":1,"supplier":{"supplier_country":2,"supplier":"Demo sup","supplier_email":"sup@sup.com","supplier_web":"http:\\/\\/www.lipsum.com\\/feed\\/html"},"width":0.0,"description":{"short":"This is short demo descriptiona","long":"This is long demo descriptiona"},"brandname":"Camel","manufacturer":{"manufacturer_email":"manu@manu.com","manufacturer_web":"http:\\/\\/www.lipsum.com\\/feed\\/html","manufacturer_country":2,"manufacturer":"Demo manu"},"length_unit":1,"height":0.0}', 1, 1, 1, '2017-01-19 15:22:50', '2017-01-19 15:22:50'),
(4, 6, 'AL123', '123456', 'Camlin 12 Set', '0.00', 100, '25.00', '30.00', '0.00', '{"depth":0.0,"weight_unit":1,"supplier":{"supplier_country":131,"supplier":"Srimal Shop","supplier_email":"","supplier_web":""},"width":0.0,"description":{"short":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.","long":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse venenatis varius purus, eu mollis ligula rutrum sit amet."},"brandname":"Camlin","manufacturer":{"manufacturer_email":"nataraj@gmail.com","manufacturer_web":"http:\\/\\/www.jsoneditoronline.org\\/","manufacturer_country":131,"manufacturer":"Nataraj"},"length_unit":1,"height":0.0}', 1, 1, 1, '2017-01-19 15:52:43', '2017-01-19 15:52:43');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `id` int(10) NOT NULL,
  `products_id` int(10) NOT NULL,
  `users_id` int(10) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `telephones` text,
  `email` text,
  `shipping_names` text,
  `billing_names` text,
  `addresses_id` int(10) NOT NULL,
  `meta` text,
  `purchased_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shop_bag`
--

CREATE TABLE `shop_bag` (
  `id` int(10) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `products_id` int(10) NOT NULL,
  `users_id` int(10) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `added_at` timestamp NULL DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `meta` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shop_bag`
--

INSERT INTO `shop_bag` (`id`, `type`, `products_id`, `users_id`, `quantity`, `added_at`, `status`, `meta`) VALUES
(1, 1, 1, 1, 4, '2017-02-01 19:45:51', 0, '{"sellingPrice":"130.00"}'),
(2, 1, 4, 1, 1, '2017-01-30 04:26:19', 0, '{"sellingPrice":"30.00"}'),
(3, 1, 3, 1, 29, '2017-01-30 11:54:28', 0, '{"sellingPrice":"2500.00"}'),
(4, 1, 2, 3, 2, '2017-01-30 13:24:16', 0, '{"sellingPrice":"250.00"}'),
(5, 1, 2, 1, 7, '2017-01-30 11:54:20', 1, '{"sellingPrice":"250.00"}'),
(6, 1, 4, 3, 1, '2017-01-30 13:06:02', 0, '{"sellingPrice":"30.00"}'),
(8, 1, 1, 4, 1, '2017-01-30 14:02:25', 0, '{"sellingPrice":"130.00"}'),
(9, 1, 1, 4, 2, '2017-01-30 14:02:43', 0, '{"sellingPrice":"130.00"}'),
(10, 1, 1, 4, 1, '2017-01-30 14:03:43', 1, '{"sellingPrice":"130.00"}'),
(11, 1, 1, 1, 1, '2017-02-04 13:55:16', 1, '{"sellingPrice":"130.00"}'),
(12, 1, 3, 1, 10, '2017-02-04 14:06:45', 1, '{"sellingPrice":"2500.00"}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `meta` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `type`, `firstname`, `lastname`, `mobile`, `email`, `password`, `status`, `remember_token`, `meta`, `created_at`, `updated_at`) VALUES
(1, 1, 'Chamal', 'Jayasuriya', '+94776145841', 'chamaljaya@gmail.com', '10b8e822d03fb4fd946188e852a4c3e2', 1, '', '', '2016-10-06 14:31:53', '2016-10-06 14:31:53'),
(2, 3, 'Demo', 'DemoS', '+94771234567', 'demo@demo.com', '10b8e822d03fb4fd946188e852a4c3e2', 1, '', '', '2016-10-29 08:43:29', '2016-10-29 08:43:29'),
(3, 3, 'Sam', 'Patrick', '+94776912341', 'sam@gmail.com', '10b8e822d03fb4fd946188e852a4c3e2', 1, '', '', '2017-01-16 06:52:04', '2017-01-16 06:52:04'),
(4, 2, 'Jasmine', 'Fernandz', '+94778912312', 'jasmine@gmail.com', '10b8e822d03fb4fd946188e852a4c3e2', 1, '', '', '2017-01-23 13:25:49', '2017-01-23 13:25:49'),
(5, 3, 'Dulanji', 'Dharmawansha', '+94713423456', 'dulanjild@gmail.com', '202cb962ac59075b964b07152d234b70', 1, '', '', '2017-01-30 11:40:20', '2017-01-30 11:40:20'),
(6, 3, '', '', '', '', 'd41d8cd98f00b204e9800998ecf8427e', 0, '', '', '2017-02-04 15:41:14', '2017-02-04 15:41:14');

-- --------------------------------------------------------

--
-- Table structure for table `users_has_login_details`
--

CREATE TABLE `users_has_login_details` (
  `users_id` int(10) NOT NULL,
  `login_details_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_addresses_country1_idx` (`country_id`),
  ADD KEY `fk_addresses_users1_idx` (`users_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_details`
--
ALTER TABLE `login_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_login_details_users1_idx` (`users_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_orders_users1_idx` (`users_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_products_categories1_idx` (`categories_id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_purchase_products1_idx` (`products_id`),
  ADD KEY `fk_purchase_users1_idx` (`users_id`),
  ADD KEY `fk_purchase_addresses1_idx` (`addresses_id`);

--
-- Indexes for table `shop_bag`
--
ALTER TABLE `shop_bag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_shop_bag_products1_idx` (`products_id`),
  ADD KEY `fk_shop_bag_users1_idx` (`users_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_has_login_details`
--
ALTER TABLE `users_has_login_details`
  ADD PRIMARY KEY (`users_id`,`login_details_id`),
  ADD KEY `fk_users_has_login_details_login_details1_idx` (`login_details_id`),
  ADD KEY `fk_users_has_login_details_users1_idx` (`users_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=252;
--
-- AUTO_INCREMENT for table `login_details`
--
ALTER TABLE `login_details`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shop_bag`
--
ALTER TABLE `shop_bag`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `fk_addresses_country1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_addresses_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `login_details`
--
ALTER TABLE `login_details`
  ADD CONSTRAINT `fk_login_details_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `fk_purchase_addresses1` FOREIGN KEY (`addresses_id`) REFERENCES `addresses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_purchase_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_purchase_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `shop_bag`
--
ALTER TABLE `shop_bag`
  ADD CONSTRAINT `fk_shop_bag_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_shop_bag_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users_has_login_details`
--
ALTER TABLE `users_has_login_details`
  ADD CONSTRAINT `fk_users_has_login_details_login_details1` FOREIGN KEY (`login_details_id`) REFERENCES `login_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_login_details_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
