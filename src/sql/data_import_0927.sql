/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.20.31_23306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 192.168.20.31:23306
 Source Schema         : fashion

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 05/07/2024 20:56:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Customer ID',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Customer Name',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES ('c1', 'PolyU');
INSERT INTO `customers` VALUES ('c2', 'John');
INSERT INTO `customers` VALUES ('c3', 'Emily');
INSERT INTO `customers` VALUES ('c4', 'James');
INSERT INTO `customers` VALUES ('c5', 'Sophia');
INSERT INTO `customers` VALUES ('c6', 'Michael');
INSERT INTO `customers` VALUES ('c7', 'Olivia');
INSERT INTO `customers` VALUES ('c8', 'William');

-- ----------------------------
-- Table structure for cutting_material_allocation
-- ----------------------------
DROP TABLE IF EXISTS `cutting_material_allocation`;
CREATE TABLE `cutting_material_allocation`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Cutting Task Material Allocation ID',
  `warehouse_material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Warehouse Material ID',
  `cutting_task_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Cutting Task ID',
  `allocated_num` int(11) NOT NULL DEFAULT 0 COMMENT 'Allocated Material Quantity',
  `is_allocated` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is Material Allocated',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cutting_task_id`(`cutting_task_id`) USING BTREE,
  INDEX `warehouse_material_id`(`warehouse_material_id`) USING BTREE,
  CONSTRAINT `cutting_material_allocation_ibfk_1` FOREIGN KEY (`cutting_task_id`) REFERENCES `cutting_tasks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cutting_material_allocation_ibfk_2` FOREIGN KEY (`warehouse_material_id`) REFERENCES `warehouse_material` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cutting_material_allocation
-- ----------------------------
INSERT INTO `cutting_material_allocation` VALUES ('cm1', 'wm1', 'ct1', 100, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm10', 'wm11', 'ct10', 100, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm11', 'wm3', 'ct11', 140, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm12', 'wm5', 'ct11', 140, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm13', 'wm3', 'ct12', 150, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm14', 'wm5', 'ct12', 150, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm15', 'wm3', 'ct13', 130, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm16', 'wm5', 'ct13', 130, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm17', 'wm3', 'ct14', 120, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm18', 'wm5', 'ct14', 120, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm19', 'wm3', 'ct15', 185, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm2', 'wm1', 'ct2', 240, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm20', 'wm7', 'ct15', 185, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm21', 'wm13', 'ct16', 200, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm22', 'wm3', 'ct16', 200, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm23', 'wm7', 'ct16', 200, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm24', 'wm3', 'ct17', 175, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm25', 'wm7', 'ct17', 175, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm26', 'wm3', 'ct18', 200, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm27', 'wm7', 'ct18', 200, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm28', 'wm1', 'ct19', 95, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm29', 'wm9', 'ct19', 95, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm3', 'wm1', 'ct3', 150, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm30', 'wm3', 'ct20', 90, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm31', 'wm7', 'ct20', 90, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm32', 'wm1', 'ct21', 85, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm33', 'wm9', 'ct21', 85, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm34', 'wm3', 'ct22', 115, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm35', 'wm11', 'ct23', 110, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm36', 'wm11', 'ct24', 105, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm37', 'wm13', 'ct25', 75, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm38', 'wm3', 'ct25', 75, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm39', 'wm7', 'ct25', 75, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm4', 'wm1', 'ct4', 220, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm40', 'wm3', 'ct26', 70, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm41', 'wm3', 'ct27', 60, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm42', 'wm7', 'ct27', 60, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm43', 'wm13', 'ct27', 60, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm44', 'wm1', 'ct28', 210, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm45', 'wm9', 'ct28', 210, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm46', 'wm3', 'ct29', 180, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm47', 'wm11', 'ct30', 195, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm48', 'wm1', 'ct31', 260, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm49', 'wm9', 'ct31', 260, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm5', 'wm1', 'ct5', 260, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm50', 'wm3', 'ct32', 150, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm51', 'wm7', 'ct32', 150, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm52', 'wm11', 'ct33', 120, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm53', 'wm1', 'ct34', 330, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm54', 'wm9', 'ct34', 330, 0);
INSERT INTO `cutting_material_allocation` VALUES ('cm6', 'wm11', 'ct6', 95, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm7', 'wm11', 'ct7', 110, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm8', 'wm11', 'ct8', 50, 1);
INSERT INTO `cutting_material_allocation` VALUES ('cm9', 'wm11', 'ct9', 80, 1);

-- ----------------------------
-- Table structure for cutting_tasks
-- ----------------------------
DROP TABLE IF EXISTS `cutting_tasks`;
CREATE TABLE `cutting_tasks`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Cutting Task ID',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Cutting Task Start Time',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Cutting Task End Time',
  `working_group_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Working Group ID',
  `order_product_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Order Product ID',
  `produced_wip_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Produced WIP material ID',
  `planned_number` int(11) NOT NULL DEFAULT 0 COMMENT 'Planned Cutting Quantity',
  `completed_number` int(11) NOT NULL DEFAULT 0 COMMENT 'Completed Cutting Quantity',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT 'Status of the task 0: not start, 1: on-going, 2: completed',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `working_group_id`(`working_group_id`) USING BTREE,
  INDEX `order_product_id`(`order_product_id`) USING BTREE,
  CONSTRAINT `cutting_tasks_ibfk_1` FOREIGN KEY (`working_group_id`) REFERENCES `working_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cutting_tasks_ibfk_2` FOREIGN KEY (`order_product_id`) REFERENCES `order_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cutting_tasks
-- ----------------------------
INSERT INTO `cutting_tasks` VALUES ('ct1', '2024-01-10 00:00:00', '2024-01-18 00:00:00', 'wg2', 'op1',  'm2', 100, 100, 2);
INSERT INTO `cutting_tasks` VALUES ('ct10', '2024-03-02 00:00:00', '2024-03-29 00:00:00', 'wg3', 'op10','m4', 100, 100, 1);
INSERT INTO `cutting_tasks` VALUES ('ct11', '2024-03-02 00:00:00', '2024-03-21 00:00:00', 'wg4', 'op11','m8', 140, 140, 1);
INSERT INTO `cutting_tasks` VALUES ('ct12', '2024-03-02 00:00:00', '2024-03-27 00:00:00', 'wg5', 'op12','m10', 150, 150, 1);
INSERT INTO `cutting_tasks` VALUES ('ct13', '2024-03-02 00:00:00', '2024-03-27 00:00:00', 'wg2', 'op13','m12', 130, 130, 1);
INSERT INTO `cutting_tasks` VALUES ('ct14', '2024-03-02 00:00:00', '2024-03-18 00:00:00', 'wg5', 'op14','m6', 120, 120, 1);
INSERT INTO `cutting_tasks` VALUES ('ct15', '2024-03-11 00:00:00', '2024-03-26 00:00:00', 'wg2', 'op15','m6', 185, 185, 1);
INSERT INTO `cutting_tasks` VALUES ('ct16', '2024-03-11 00:00:00', '2024-04-10 00:00:00', 'wg4', 'op16','m8', 200, 200, 1);
INSERT INTO `cutting_tasks` VALUES ('ct17', '2024-03-11 00:00:00', '2024-03-25 00:00:00', 'wg2', 'op17','m4', 175, 175, 1);
INSERT INTO `cutting_tasks` VALUES ('ct18', '2024-03-11 00:00:00', '2024-04-07 00:00:00', 'wg1', 'op18','m10', 200, 200, 1);
INSERT INTO `cutting_tasks` VALUES ('ct19', '2024-03-18 00:00:00', '2024-04-12 00:00:00', 'wg4', 'op19','m6', 95, 95, 1);
INSERT INTO `cutting_tasks` VALUES ('ct2', '2024-01-10 00:00:00', '2024-02-02 00:00:00', 'wg3', 'op2',  'm10', 240, 240, 1);
INSERT INTO `cutting_tasks` VALUES ('ct20', '2024-03-18 00:00:00', '2024-04-15 00:00:00', 'wg4', 'op20','m12', 90, 90, 1);
INSERT INTO `cutting_tasks` VALUES ('ct21', '2024-03-18 00:00:00', '2024-04-04 00:00:00', 'wg4', 'op21','m10', 85, 85, 1);
INSERT INTO `cutting_tasks` VALUES ('ct22', '2024-03-25 00:00:00', '2024-04-09 00:00:00', 'wg2', 'op22','m10', 115, 115, 1);
INSERT INTO `cutting_tasks` VALUES ('ct23', '2024-03-25 00:00:00', '2024-04-19 00:00:00', 'wg3', 'op23','m4', 110, 110, 1);
INSERT INTO `cutting_tasks` VALUES ('ct24', '2024-03-25 00:00:00', '2024-04-23 00:00:00', 'wg3', 'op24','m8', 105, 105, 1);
INSERT INTO `cutting_tasks` VALUES ('ct25', '2024-04-14 00:00:00', '2024-05-14 00:00:00', 'wg2', 'op25','m6', 75, 75, 1);
INSERT INTO `cutting_tasks` VALUES ('ct26', '2024-04-14 00:00:00', '2024-05-04 00:00:00', 'wg4', 'op26','m4', 70, 70, 0);
INSERT INTO `cutting_tasks` VALUES ('ct27', '2024-04-14 00:00:00', '2024-05-04 00:00:00', 'wg4', 'op27','m8', 60, 60, 0);
INSERT INTO `cutting_tasks` VALUES ('ct28', '2024-04-19 00:00:00', '2024-05-12 00:00:00', 'wg2', 'op28','m4', 210, 210, 1);
INSERT INTO `cutting_tasks` VALUES ('ct29', '2024-04-19 00:00:00', '2024-05-11 00:00:00', 'wg2', 'op29','m6', 180, 180, 2);
INSERT INTO `cutting_tasks` VALUES ('ct3', '2024-01-10 00:00:00', '2024-01-19 00:00:00', 'wg3', 'op3',  'm2', 150, 150, 2);
INSERT INTO `cutting_tasks` VALUES ('ct30', '2024-04-19 00:00:00', '2024-04-26 00:00:00', 'wg1', 'op30','m10', 195, 195, 1);
INSERT INTO `cutting_tasks` VALUES ('ct31', '2024-05-10 00:00:00', '2024-05-26 00:00:00', 'wg3', 'op31','m8', 260, 260, 1);
INSERT INTO `cutting_tasks` VALUES ('ct32', '2024-06-01 00:00:00', '2024-06-17 00:00:00', 'wg2', 'op32','m8', 150, 120, 1);
INSERT INTO `cutting_tasks` VALUES ('ct33', '2024-06-25 00:00:00', '2024-07-17 00:00:00', 'wg3', 'op33','m10', 120, 0, 0);
INSERT INTO `cutting_tasks` VALUES ('ct34', '2024-06-30 00:00:00', '2024-07-10 00:00:00', 'wg4', 'op34','m2', 330, 0, 0);
INSERT INTO `cutting_tasks` VALUES ('ct4', '2024-01-10 00:00:00', '2024-01-17 00:00:00', 'wg2', 'op4',  'm4', 220, 220, 1);
INSERT INTO `cutting_tasks` VALUES ('ct5', '2024-01-10 00:00:00', '2024-02-02 00:00:00', 'wg2', 'op5',  'm8', 260, 260, 1);
INSERT INTO `cutting_tasks` VALUES ('ct6', '2024-02-28 00:00:00', '2024-03-20 00:00:00', 'wg3', 'op6',  'm6', 95, 95, 1);
INSERT INTO `cutting_tasks` VALUES ('ct7', '2024-02-28 00:00:00', '2024-03-06 00:00:00', 'wg2', 'op7',  'm12', 110, 110, 1);
INSERT INTO `cutting_tasks` VALUES ('ct8', '2024-02-28 00:00:00', '2024-03-08 00:00:00', 'wg4', 'op8',  'm6', 50, 50, 1);
INSERT INTO `cutting_tasks` VALUES ('ct9', '2024-03-01 00:00:00', '2024-03-06 00:00:00', 'wg3', 'op9',  'm12', 80, 80, 1);

-- ----------------------------
-- Table structure for materials
-- ----------------------------
DROP TABLE IF EXISTS `materials`;
CREATE TABLE `materials`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Material ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Material Name',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Material Unit',
  `type` enum('wip','origin') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Material Type',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of materials
-- ----------------------------
INSERT INTO `materials` VALUES ('m1', 'Cotton Fabric', 'meters', 'origin');
INSERT INTO `materials` VALUES ('m10', 'Synthetic Fiber Pieces', 'pieces', 'wip');
INSERT INTO `materials` VALUES ('m11', 'Denim Fabric', 'meters', 'origin');
INSERT INTO `materials` VALUES ('m12', 'Denim Fabric Pieces', 'pieces', 'wip');
INSERT INTO `materials` VALUES ('m13', 'Down', 'kilograms', 'origin');
INSERT INTO `materials` VALUES ('m14', 'Down Pieces', 'pieces', 'origin');
INSERT INTO `materials` VALUES ('m2', 'Fabric Pieces', 'pieces', 'wip');
INSERT INTO `materials` VALUES ('m3', 'Wool', 'kilograms', 'origin');
INSERT INTO `materials` VALUES ('m4', 'Wool Pieces', 'pieces', 'wip');
INSERT INTO `materials` VALUES ('m5', 'Silk', 'grams', 'origin');
INSERT INTO `materials` VALUES ('m6', 'Silk Pieces', 'pieces', 'wip');
INSERT INTO `materials` VALUES ('m7', 'Leather', 'meters', 'origin');
INSERT INTO `materials` VALUES ('m8', 'Leather Pieces', 'pieces', 'wip');
INSERT INTO `materials` VALUES ('m9', 'Synthetic Fiber', 'kilograms', 'origin');

-- ----------------------------
-- Table structure for order_product
-- ----------------------------
DROP TABLE IF EXISTS `order_product`;
CREATE TABLE `order_product`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Order Product ID',
  `order_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Order ID',
  `product_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Product ID',
  `number` int(11) NOT NULL DEFAULT 0 COMMENT 'Order Product Quantity',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `order_product_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_product
-- ----------------------------
INSERT INTO `order_product` VALUES ('op1', 'o1', 'p1', 100);
INSERT INTO `order_product` VALUES ('op10', 'o2', 'p20', 100);
INSERT INTO `order_product` VALUES ('op11', 'o3', 'p21', 140);
INSERT INTO `order_product` VALUES ('op12', 'o3', 'p29', 150);
INSERT INTO `order_product` VALUES ('op13', 'o3', 'p13', 130);
INSERT INTO `order_product` VALUES ('op14', 'o3', 'p5', 120);
INSERT INTO `order_product` VALUES ('op15', 'o4', 'p22', 185);
INSERT INTO `order_product` VALUES ('op16', 'o4', 'p26', 200);
INSERT INTO `order_product` VALUES ('op17', 'o4', 'p14', 175);
INSERT INTO `order_product` VALUES ('op18', 'o4', 'p6', 200);
INSERT INTO `order_product` VALUES ('op19', 'o5', 'p23', 95);
INSERT INTO `order_product` VALUES ('op2', 'o1', 'p19', 240);
INSERT INTO `order_product` VALUES ('op20', 'o5', 'p30', 90);
INSERT INTO `order_product` VALUES ('op21', 'o5', 'p15', 85);
INSERT INTO `order_product` VALUES ('op22', 'o6', 'p25', 115);
INSERT INTO `order_product` VALUES ('op23', 'o6', 'p8', 110);
INSERT INTO `order_product` VALUES ('op24', 'o6', 'p16', 105);
INSERT INTO `order_product` VALUES ('op25', 'o7', 'p18', 75);
INSERT INTO `order_product` VALUES ('op26', 'o7', 'p17', 70);
INSERT INTO `order_product` VALUES ('op27', 'o7', 'p10', 60);
INSERT INTO `order_product` VALUES ('op28', 'o8', 'p7', 210);
INSERT INTO `order_product` VALUES ('op29', 'o8', 'p9', 180);
INSERT INTO `order_product` VALUES ('op3', 'o1', 'p3', 150);
INSERT INTO `order_product` VALUES ('op30', 'o8', 'p24', 195);
INSERT INTO `order_product` VALUES ('op31', 'o9', 'p15', 260);
INSERT INTO `order_product` VALUES ('op32', 'o10', 'p30', 150);
INSERT INTO `order_product` VALUES ('op33', 'o11', 'p20', 120);
INSERT INTO `order_product` VALUES ('op34', 'o12', 'p7', 330);
INSERT INTO `order_product` VALUES ('op4', 'o1', 'p11', 220);
INSERT INTO `order_product` VALUES ('op5', 'o1', 'p27', 260);
INSERT INTO `order_product` VALUES ('op6', 'o2', 'p12', 95);
INSERT INTO `order_product` VALUES ('op7', 'o2', 'p28', 110);
INSERT INTO `order_product` VALUES ('op8', 'o2', 'p2', 50);
INSERT INTO `order_product` VALUES ('op9', 'o2', 'p4', 80);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Order ID',
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户ID',
  `order_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Order Name',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Order 创建Time ',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('o1', 'c1', 'PolyU_Tshirt', '2024-01-10 00:00:00');
INSERT INTO `orders` VALUES ('o10', 'c2', 'John_Jacket', '2024-06-01 00:00:00');
INSERT INTO `orders` VALUES ('o11', 'c3', 'Emily_Pants', '2024-06-02 00:00:00');
INSERT INTO `orders` VALUES ('o12', 'c4', 'James_Skirt', '2024-06-09 00:00:00');
INSERT INTO `orders` VALUES ('o2', 'c2', 'John_Pants', '2024-02-28 00:00:00');
INSERT INTO `orders` VALUES ('o3', 'c3', 'Emily_Dress', '2024-03-02 00:00:00');
INSERT INTO `orders` VALUES ('o4', 'c4', 'James_WinterOrder', '2024-03-11 00:00:00');
INSERT INTO `orders` VALUES ('o5', 'c5', 'Sophia_SkirtAndJacket', '2024-03-18 00:00:00');
INSERT INTO `orders` VALUES ('o6', 'c6', 'Michael_SweaterAndShorts', '2024-03-25 00:00:00');
INSERT INTO `orders` VALUES ('o7', 'c7', 'Olivia_WinterOrder', '2024-04-14 00:00:00');
INSERT INTO `orders` VALUES ('o8', 'c8', 'William_Skirt_Sweater_Shorts', '2024-04-19 00:00:00');
INSERT INTO `orders` VALUES ('o9', 'c1', 'PolyU_Skirt', '2024-05-10 00:00:00');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'product ID',
  `products_type_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'product typeID',
  `attributes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'product 属性',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_type_id`(`products_type_id`) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`products_type_id`) REFERENCES `products_types` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES ('p1', 'pt1', 'Red, M size');
INSERT INTO `products` VALUES ('p10', 'pt8', 'White, L size');
INSERT INTO `products` VALUES ('p11', 'pt1', 'White, XL size');
INSERT INTO `products` VALUES ('p12', 'pt2', 'Blue, 30 size');
INSERT INTO `products` VALUES ('p13', 'pt3', 'Black, S size');
INSERT INTO `products` VALUES ('p14', 'pt4', 'Yellow, L size');
INSERT INTO `products` VALUES ('p15', 'pt5', 'Pink, M size');
INSERT INTO `products` VALUES ('p16', 'pt6', 'Grey, XL size');
INSERT INTO `products` VALUES ('p17', 'pt7', 'Blue, XL size');
INSERT INTO `products` VALUES ('p18', 'pt8', 'Purple, S size');
INSERT INTO `products` VALUES ('p19', 'pt1', 'Green, M size');
INSERT INTO `products` VALUES ('p2', 'pt2', 'Blue, 35 size');
INSERT INTO `products` VALUES ('p20', 'pt2', 'Grey, 29 size');
INSERT INTO `products` VALUES ('p21', 'pt3', 'Gold, L size');
INSERT INTO `products` VALUES ('p22', 'pt4', 'Brown, S size');
INSERT INTO `products` VALUES ('p23', 'pt5', 'Green, XL size');
INSERT INTO `products` VALUES ('p24', 'pt6', 'Red, L size');
INSERT INTO `products` VALUES ('p25', 'pt7', 'Blue, S size');
INSERT INTO `products` VALUES ('p26', 'pt8', 'Red, M size');
INSERT INTO `products` VALUES ('p27', 'pt1', 'Yellow, S size');
INSERT INTO `products` VALUES ('p28', 'pt2', 'Brown, 34 size');
INSERT INTO `products` VALUES ('p29', 'pt3', 'Red, M size');
INSERT INTO `products` VALUES ('p3', 'pt1', 'Blue, L size');
INSERT INTO `products` VALUES ('p30', 'pt4', 'Black, XL size');
INSERT INTO `products` VALUES ('p4', 'pt2', 'Black, 34 size');
INSERT INTO `products` VALUES ('p5', 'pt3', 'Pink, S size');
INSERT INTO `products` VALUES ('p6', 'pt4', 'Brown, L size');
INSERT INTO `products` VALUES ('p7', 'pt5', 'Purple, M size');
INSERT INTO `products` VALUES ('p8', 'pt6', 'Silver, S size');
INSERT INTO `products` VALUES ('p9', 'pt7', 'Grey, L size');

-- ----------------------------
-- Table structure for products_types
-- ----------------------------
DROP TABLE IF EXISTS `products_types`;
CREATE TABLE `products_types`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'product typeID',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'product type描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products_types
-- ----------------------------
INSERT INTO `products_types` VALUES ('pt1', 'T-shirt');
INSERT INTO `products_types` VALUES ('pt2', 'Pants');
INSERT INTO `products_types` VALUES ('pt3', 'Dress');
INSERT INTO `products_types` VALUES ('pt4', 'Jacket');
INSERT INTO `products_types` VALUES ('pt5', 'Skirt');
INSERT INTO `products_types` VALUES ('pt6', 'Shorts');
INSERT INTO `products_types` VALUES ('pt7', 'Sweater');
INSERT INTO `products_types` VALUES ('pt8', 'Coat');

-- ----------------------------
-- Table structure for sewing_material_allocation
-- ----------------------------
DROP TABLE IF EXISTS `sewing_material_allocation`;
CREATE TABLE `sewing_material_allocation`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Sewing Task Material 分配ID',
  `warehouse_material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse Material ID',
  `sewing_task_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Sewing Task ID',
  `allocated_num` int(11) NOT NULL DEFAULT 0 COMMENT 'Material 分配number',
  `is_allocated` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Material 是否已分配',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sewing_task_id`(`sewing_task_id`) USING BTREE,
  INDEX `warehouse_material_id`(`warehouse_material_id`) USING BTREE,
  CONSTRAINT `sewing_material_allocation_ibfk_1` FOREIGN KEY (`sewing_task_id`) REFERENCES `sewing_tasks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sewing_material_allocation_ibfk_2` FOREIGN KEY (`warehouse_material_id`) REFERENCES `warehouse_material` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sewing_material_allocation
-- ----------------------------
INSERT INTO `sewing_material_allocation` VALUES ('cm1', 'wm2', 'sw1', 100, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm10', 'wm12', 'sw10', 100, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm11', 'wm4', 'sw11', 140, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm12', 'wm5', 'sw11', 140, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm13', 'wm3', 'sw12', 150, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm14', 'wm5', 'sw12', 150, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm15', 'wm3', 'sw13', 130, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm16', 'wm5', 'sw13', 130, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm17', 'wm3', 'sw14', 120, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm18', 'wm5', 'sw14', 120, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm19', 'wm3', 'sw15', 185, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm2', 'wm1', 'sw2', 240, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm20', 'wm7', 'sw15', 185, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm21', 'wm13', 'sw16', 200, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm22', 'wm3', 'sw16', 200, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm23', 'wm7', 'sw16', 200, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm24', 'wm3', 'sw17', 175, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm25', 'wm7', 'sw17', 175, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm26', 'wm3', 'sw18', 200, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm27', 'wm7', 'sw18', 200, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm28', 'wm1', 'sw19', 95, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm29', 'wm9', 'sw19', 95, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm3', 'wm1', 'sw3', 150, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm30', 'wm3', 'sw20', 90, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm31', 'wm7', 'sw20', 90, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm32', 'wm1', 'sw21', 85, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm33', 'wm9', 'sw21', 85, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm34', 'wm3', 'sw22', 115, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm35', 'wm11', 'sw23', 110, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm36', 'wm11', 'sw24', 105, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm37', 'wm13', 'sw25', 75, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm38', 'wm3', 'sw25', 75, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm39', 'wm7', 'sw25', 75, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm4', 'wm1', 'sw4', 220, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm40', 'wm3', 'sw26', 70, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm41', 'wm3', 'sw27', 60, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm42', 'wm7', 'sw27', 60, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm43', 'wm13', 'sw27', 60, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm44', 'wm1', 'sw28', 210, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm45', 'wm9', 'sw28', 210, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm46', 'wm3', 'sw29', 180, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm47', 'wm11', 'sw30', 195, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm48', 'wm1', 'sw31', 260, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm49', 'wm9', 'sw31', 260, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm5', 'wm1', 'sw5', 260, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm50', 'wm3', 'sw32', 150, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm51', 'wm7', 'sw32', 150, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm52', 'wm11', 'sw33', 120, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm53', 'wm1', 'sw34', 330, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm54', 'wm9', 'sw34', 330, 0);
INSERT INTO `sewing_material_allocation` VALUES ('cm6', 'wm11', 'sw6', 95, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm7', 'wm11', 'sw7', 110, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm8', 'wm11', 'sw8', 50, 1);
INSERT INTO `sewing_material_allocation` VALUES ('cm9', 'wm11', 'sw9', 80, 1);

-- ----------------------------
-- Table structure for sewing_tasks
-- ----------------------------
DROP TABLE IF EXISTS `sewing_tasks`;
CREATE TABLE `sewing_tasks`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Sewing Task ID',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Sewing Task Start Time ',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Sewing Task End Time ',
  `working_group_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Working Group ID',
  `order_product_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Order product ID',
  `planned_number` int(11) NOT NULL DEFAULT 0 COMMENT 'planned Sewing number',
  `completed_number` int(11) NOT NULL DEFAULT 0 COMMENT 'completed Sewing number',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT 'Status of the task 0: not start, 1: on-going, 2: completed',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `working_group_id`(`working_group_id`) USING BTREE,
  INDEX `order_product_id`(`order_product_id`) USING BTREE,
  CONSTRAINT `sewing_tasks_ibfk_1` FOREIGN KEY (`working_group_id`) REFERENCES `working_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sewing_tasks_ibfk_2` FOREIGN KEY (`order_product_id`) REFERENCES `order_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sewing_tasks
-- ----------------------------
INSERT INTO `sewing_tasks` VALUES ('sw1', '2024-01-18 00:00:00', '2024-02-07 00:00:00', 'wg2', 'op1', 100, 100, 2);
INSERT INTO `sewing_tasks` VALUES ('sw10', '2024-03-29 00:00:00', '2024-04-09 00:00:00', 'wg2', 'op10', 100, 100, 0);
INSERT INTO `sewing_tasks` VALUES ('sw11', '2024-03-21 00:00:00', '2024-04-14 00:00:00', 'wg9', 'op11', 140, 140, 0);
INSERT INTO `sewing_tasks` VALUES ('sw12', '2024-03-27 00:00:00', '2024-04-12 00:00:00', 'wg2', 'op12', 150, 150, 1);
INSERT INTO `sewing_tasks` VALUES ('sw13', '2024-03-27 00:00:00', '2024-04-06 00:00:00', 'wg2', 'op13', 130, 130, 1);
INSERT INTO `sewing_tasks` VALUES ('sw14', '2024-03-18 00:00:00', '2024-04-08 00:00:00', 'wg2', 'op14', 120, 120, 1);
INSERT INTO `sewing_tasks` VALUES ('sw15', '2024-03-26 00:00:00', '2024-04-09 00:00:00', 'wg2', 'op15', 185, 185, 1);
INSERT INTO `sewing_tasks` VALUES ('sw16', '2024-04-10 00:00:00', '2024-05-07 00:00:00', 'wg8', 'op16', 200, 200, 2);
INSERT INTO `sewing_tasks` VALUES ('sw17', '2024-03-25 00:00:00', '2024-04-22 00:00:00', 'wg7', 'op17', 175, 175, 2);
INSERT INTO `sewing_tasks` VALUES ('sw18', '2024-04-07 00:00:00', '2024-04-21 00:00:00', 'wg7', 'op18', 200, 200, 2);
INSERT INTO `sewing_tasks` VALUES ('sw19', '2024-04-12 00:00:00', '2024-04-23 00:00:00', 'wg7', 'op19', 95, 95, 1);
INSERT INTO `sewing_tasks` VALUES ('sw2', '2024-02-02 00:00:00', '2024-02-15 00:00:00', 'wg9', 'op2', 240, 240, 1);
INSERT INTO `sewing_tasks` VALUES ('sw20', '2024-04-15 00:00:00', '2024-05-07 00:00:00', 'wg8', 'op20', 90, 90, 1);
INSERT INTO `sewing_tasks` VALUES ('sw21', '2024-04-04 00:00:00', '2024-04-12 00:00:00', 'wg8', 'op21', 85, 85, 1);
INSERT INTO `sewing_tasks` VALUES ('sw22', '2024-04-09 00:00:00', '2024-04-22 00:00:00', 'wg8', 'op22', 115, 115, 0);
INSERT INTO `sewing_tasks` VALUES ('sw23', '2024-04-19 00:00:00', '2024-05-01 00:00:00', 'wg7', 'op23', 110, 110, 0);
INSERT INTO `sewing_tasks` VALUES ('sw24', '2024-04-23 00:00:00', '2024-05-20 00:00:00', 'wg2', 'op24', 105, 105, 0);
INSERT INTO `sewing_tasks` VALUES ('sw25', '2024-05-14 00:00:00', '2024-06-03 00:00:00', 'wg8', 'op25', 75, 75, 0);
INSERT INTO `sewing_tasks` VALUES ('sw26', '2024-05-04 00:00:00', '2024-05-15 00:00:00', 'wg9', 'op26', 70, 70, 0);
INSERT INTO `sewing_tasks` VALUES ('sw27', '2024-05-04 00:00:00', '2024-05-15 00:00:00', 'wg7', 'op27', 60, 60, 0);
INSERT INTO `sewing_tasks` VALUES ('sw28', '2024-05-12 00:00:00', '2024-05-28 00:00:00', 'wg7', 'op28', 210, 210, 1);
INSERT INTO `sewing_tasks` VALUES ('sw29', '2024-05-11 00:00:00', '2024-05-19 00:00:00', 'wg7', 'op29', 180, 180, 1);
INSERT INTO `sewing_tasks` VALUES ('sw3', '2024-01-19 00:00:00', '2024-02-08 00:00:00', 'wg9', 'op3', 150, 150, 1);
INSERT INTO `sewing_tasks` VALUES ('sw30', '2024-04-26 00:00:00', '2024-05-15 00:00:00', 'wg2', 'op30', 195, 195, 1);
INSERT INTO `sewing_tasks` VALUES ('sw31', '2024-05-26 00:00:00', '2024-06-04 00:00:00', 'wg10', 'op31', 260, 260, 1);
INSERT INTO `sewing_tasks` VALUES ('sw32', '2024-06-17 00:00:00', '2024-07-14 00:00:00', 'wg9', 'op32', 150, 0, 0);
INSERT INTO `sewing_tasks` VALUES ('sw33', '2024-07-17 00:00:00', '2024-08-03 00:00:00', 'wg8', 'op33', 120, 0, 0);
INSERT INTO `sewing_tasks` VALUES ('sw34', '2024-07-10 00:00:00', '2024-07-20 00:00:00', 'wg10', 'op34', 330, 0, 0);
INSERT INTO `sewing_tasks` VALUES ('sw4', '2024-01-17 00:00:00', '2024-01-30 00:00:00', 'wg2', 'op4', 220, 220, 1);
INSERT INTO `sewing_tasks` VALUES ('sw5', '2024-02-02 00:00:00', '2024-02-25 00:00:00', 'wg2', 'op5', 260, 260, 1);
INSERT INTO `sewing_tasks` VALUES ('sw6', '2024-03-20 00:00:00', '2024-04-07 00:00:00', 'wg8', 'op6', 95, 95, 1);
INSERT INTO `sewing_tasks` VALUES ('sw7', '2024-03-06 00:00:00', '2024-03-22 00:00:00', 'wg8', 'op7', 110, 110, 1);
INSERT INTO `sewing_tasks` VALUES ('sw8', '2024-03-08 00:00:00', '2024-04-05 00:00:00', 'wg7', 'op8', 50, 50, 1);
INSERT INTO `sewing_tasks` VALUES ('sw9', '2024-03-06 00:00:00', '2024-03-20 00:00:00', 'wg8', 'op9', 80, 80, 1);

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse Name',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of warehouse
-- ----------------------------
INSERT INTO `warehouse` VALUES ('w1', 'Main Warehouse');
INSERT INTO `warehouse` VALUES ('w2', 'Auxiliary warehouse');

-- ----------------------------
-- Table structure for warehouse_material
-- ----------------------------
DROP TABLE IF EXISTS `warehouse_material`;
CREATE TABLE `warehouse_material`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse Material ID',
  `warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse ID',
  `material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Material ID',
  `left_number` int(11) NOT NULL DEFAULT 0 COMMENT 'Remaining Material Inventory Quantity',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `material_id`(`material_id`) USING BTREE,
  CONSTRAINT `warehouse_material_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `warehouse_material_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of warehouse_material
-- ----------------------------
INSERT INTO `warehouse_material` VALUES ('wm1', 'w1', 'm1', 3500);
INSERT INTO `warehouse_material` VALUES ('wm10', 'w2', 'm10', 1500);
INSERT INTO `warehouse_material` VALUES ('wm11', 'w1', 'm11', 4500);
INSERT INTO `warehouse_material` VALUES ('wm12', 'w2', 'm12', 3180);
INSERT INTO `warehouse_material` VALUES ('wm13', 'w1', 'm13', 1230);
INSERT INTO `warehouse_material` VALUES ('wm14', 'w2', 'm14', 2420);
INSERT INTO `warehouse_material` VALUES ('wm2', 'w2', 'm2', 3200);
INSERT INTO `warehouse_material` VALUES ('wm3', 'w1', 'm3', 4100);
INSERT INTO `warehouse_material` VALUES ('wm4', 'w2', 'm4', 3550);
INSERT INTO `warehouse_material` VALUES ('wm5', 'w1', 'm5', 1100);
INSERT INTO `warehouse_material` VALUES ('wm6', 'w2', 'm6', 5400);
INSERT INTO `warehouse_material` VALUES ('wm7', 'w1', 'm7', 2200);
INSERT INTO `warehouse_material` VALUES ('wm8', 'w2', 'm8', 1300);
INSERT INTO `warehouse_material` VALUES ('wm9', 'w1', 'm9', 2300);

-- ----------------------------
-- Table structure for warehouse_product
-- ----------------------------
DROP TABLE IF EXISTS `warehouse_product`;
CREATE TABLE `warehouse_product`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse product ID',
  `warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'warehouse ID',
  `product_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'product ID',
  `left_number` int(11) NOT NULL DEFAULT 0 COMMENT 'Remaining Product Inventory Quantity',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `warehouse_product_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `warehouse_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of warehouse_product
-- ----------------------------
INSERT INTO `warehouse_product` VALUES ('wp1', 'w1', 'p1', 0);
INSERT INTO `warehouse_product` VALUES ('wp2', 'w2', 'p2', 0);

-- ----------------------------
-- Table structure for working_group
-- ----------------------------
DROP TABLE IF EXISTS `working_group`;
CREATE TABLE `working_group`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Working Group ID',
  `type` enum('sew','cut') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Working Group type，Sewing group、Cutting group',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Working Group Name',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of working_group
-- ----------------------------
INSERT INTO `working_group` VALUES ('wg1', 'cut', 'Precision Cutters');
INSERT INTO `working_group` VALUES ('wg10', 'sew', 'Elite Sewers');
INSERT INTO `working_group` VALUES ('wg2', 'sew', 'Master Sewers');
INSERT INTO `working_group` VALUES ('wg3', 'cut', 'Master Cutters');
INSERT INTO `working_group` VALUES ('wg4', 'cut', 'Expert Cutters');
INSERT INTO `working_group` VALUES ('wg5', 'cut', 'Professional Cutters');
INSERT INTO `working_group` VALUES ('wg6', 'cut', 'Advanced Cutters');
INSERT INTO `working_group` VALUES ('wg7', 'sew','Skilled Sewers');
INSERT INTO `working_group` VALUES ('wg8', 'sew', 'Advanced Sewers');
INSERT INTO `working_group` VALUES ('wg9', 'sew', 'Premier Sewers');

-- ----------------------------
-- Table structure for product_material
-- ----------------------------
DROP TABLE IF EXISTS `product_material`;
CREATE TABLE `product_material`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Product Material ID',
  `product_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Product ID',
  `material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Material ID',
  `number` int(11) NOT NULL DEFAULT 0.0 COMMENT 'Required Quantity of material',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `product_material_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `product_material_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of working_group
-- ----------------------------
INSERT INTO `product_material` VALUES
('pm1', 'p1', 'm10', 2), ('pm2', 'p1', 'm2', 4), ('pm3', 'p10', 'm8', 3), ('pm4', 'p10', 'm12', 1), ('pm5', 'p10', 'm6', 5),
('pm6', 'p11', 'm4', 3), ('pm7', 'p11', 'm2', 2 ), ('pm8', 'p12', 'm8', 4), ('pm9', 'p12', 'm6', 2), ('pm10', 'p12', 'm10', 1),
('pm11', 'p13', 'm10', 3), ('pm12', 'p13', 'm12', 4), ('pm13', 'p14', 'm2', 2), ('pm14', 'p14', 'm4', 3), ('pm15', 'p14', 'm6', 1),
('pm16', 'p15', 'm8', 5), ('pm17', 'p15', 'm10', 2), ('pm18', 'p16', 'm2', 3), ('pm19', 'p16', 'm6', 1), ('pm20', 'p17', 'm4', 2),
('pm21', 'p17', 'm12', 3), ('pm22', 'p18', 'm10', 4), ('pm23', 'p18', 'm6', 1), ('pm24', 'p18', 'm2', 3), ('pm25', 'p19', 'm2', 2),
('pm26', 'p19', 'm12', 5), ('pm27', 'p2', 'm6', 2), ('pm28', 'p2', 'm4', 1), ('pm29', 'p20', 'm2', 3), ('pm30', 'p20', 'm6', 4),
('pm31', 'p21', 'm12', 2), ('pm32', 'p21', 'm8', 3), ('pm33', 'p22', 'm10', 1), ('pm34', 'p22', 'm12', 2), ('pm35', 'p23', 'm4', 3),
('pm36', 'p23', 'm2', 1), ('pm37', 'p24', 'm10', 2), ('pm38', 'p24', 'm8', 5), ('pm39', 'p25', 'm4', 4), ('pm40', 'p25', 'm6', 3),
('pm41', 'p26', 'm12', 1), ('pm42', 'p26', 'm2', 3), ('pm43', 'p27', 'm6', 4), ('pm44', 'p27', 'm10', 2), ('pm45', 'p28', 'm6', 3),
('pm46', 'p28', 'm8', 2), ('pm47', 'p29', 'm10', 4), ('pm48', 'p29', 'm12', 1), ('pm49', 'p3', 'm4', 3), ('pm50', 'p3', 'm8', 2),
('pm51', 'p30', 'm2', 5), ('pm52', 'p30', 'm10', 1), ('pm53', 'p4', 'm12', 3), ('pm54', 'p4', 'm8', 2), ('pm55', 'p5', 'm4', 4),
('pm56', 'p5', 'm10', 1), ('pm57', 'p6', 'm6', 2), ('pm58', 'p6', 'm8', 3), ('pm59', 'p7', 'm12', 5), ('pm60', 'p7', 'm6', 2),
('pm61', 'p8', 'm2', 1), ('pm62', 'p8', 'm4', 3), ('pm63', 'p9', 'm12', 4), ('pm64', 'p9', 'm10', 2);

-- ----------------------------
-- Table structure for product_material
-- ----------------------------
DROP TABLE IF EXISTS `wip_material`;
CREATE TABLE `wip_material`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Product Material ID',
  `wip_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Wip material ID',
  `origin_material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Original Material ID',
  `number` float NOT NULL DEFAULT 0.0 COMMENT 'Required Quantity of material',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wip_id`(`wip_id`) USING BTREE,
  CONSTRAINT `wip_material_ibfk_1` FOREIGN KEY (`wip_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `wip_material_ibfk_2` FOREIGN KEY (`origin_material_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of working_group
-- ----------------------------
INSERT INTO `wip_material` VALUES
('wm1', 'm10', 'm9', 0.6),   ('wm2', 'm10', 'm1', 0.35),  ('wm3', 'm10', 'm13', 0.8),  ('wm4', 'm12', 'm11', 0.7),  ('wm5', 'm12', 'm1', 0.5),
('wm6', 'm2', 'm1', 0.4),    ('wm7', 'm2', 'm11', 0.65),  ('wm8', 'm2', 'm3', 0.2),    ('wm9', 'm4', 'm3', 0.5),    ('wm10', 'm4', 'm14', 0.15),
('wm11', 'm4', 'm13', 0.3),  ('wm12', 'm6', 'm5', 0.75),  ('wm13', 'm6', 'm1', 0.4),   ('wm14', 'm8', 'm7', 1.0),   ('wm15', 'm8', 'm9', 0.2),
('wm16', 'm8', 'm5', 0.1);
SET FOREIGN_KEY_CHECKS = 1;
