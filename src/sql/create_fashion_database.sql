-- 创建数据库
CREATE DATABASE fashion;

-- 创建用户并授权数据库
CREATE USER 'fashion'@'%' IDENTIFIED BY 'Fashion!@#';
GRANT ALL PRIVILEGES ON fashion.* TO 'fashion'@'%';
FLUSH PRIVILEGES;

USE fashion;

-- 客户信息表
CREATE TABLE `customers` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '客户ID',
  `customer_name` VARCHAR(255) NOT NULL COMMENT '客户名称'
);

-- 订单信息表
CREATE TABLE `orders` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '订单ID',
  `user_id` VARCHAR(36) NOT NULL COMMENT '客户ID',
  `order_name` VARCHAR(255) NOT NULL COMMENT '订单名称',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间'
);

-- 产品类型表
CREATE TABLE `products_types` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '产品类型ID',
  `description` VARCHAR(255) NOT NULL COMMENT '产品类型描述'
);

-- 产品表
CREATE TABLE `products` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '产品ID',
  `products_type_id` VARCHAR(36) NOT NULL COMMENT '产品类型ID',
  `attributes` VARCHAR(255) NOT NULL COMMENT '产品属性'
);

-- 原料表
CREATE TABLE `materials` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '原料ID',
  `name` VARCHAR(255) NOT NULL COMMENT '原料名称',
  `unit` VARCHAR(255) NOT NULL COMMENT '原料单位',
  `type` ENUM('wip', 'origin') NOT NULL COMMENT '原料类型'
);

-- 订单产品关系表
CREATE TABLE `order_product` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '订单产品ID', 
  `order_id` VARCHAR(36) NOT NULL COMMENT '订单ID',
  `product_id` VARCHAR(36) NOT NULL COMMENT '产品ID',
  `number` INTEGER NOT NULL DEFAULT 0 COMMENT '订单产品数量'
);

-- 工作组表
CREATE TABLE `working_group` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '工作组ID',
  `type` ENUM('sew', 'cut') NOT NULL COMMENT '工作组类型，缝纫小组、裁剪小组',
  `name` VARCHAR(255) NOT NULL COMMENT '工作组名称'
);

-- 订单产品裁剪任务表
CREATE TABLE `cutting_tasks` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '裁剪任务ID',
  `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '裁剪任务开始时间',
  `end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '裁剪任务结束时间',
  `working_group_id` VARCHAR(36) NOT NULL COMMENT '工作组ID',
  `order_product_id` VARCHAR(36) NOT NULL COMMENT '订单产品ID',
  `planned_number` INTEGER NOT NULL DEFAULT 0 COMMENT '计划裁剪数量',
  `completed_number` INTEGER NOT NULL DEFAULT 0 COMMENT '已完成裁剪数量',
  `is_started` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '裁剪任务是否已开始'
);

-- 订单产品缝纫任务表
CREATE TABLE `sewing_tasks` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '缝纫任务ID',
  `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缝纫任务开始时间',
  `end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缝纫任务结束时间',
  `working_group_id` VARCHAR(36) NOT NULL COMMENT '工作组ID',
  `order_product_id` VARCHAR(36) NOT NULL COMMENT '订单产品ID',
  `planned_number` INTEGER NOT NULL DEFAULT 0 COMMENT '计划缝纫数量',
  `completed_number` INTEGER NOT NULL DEFAULT 0 COMMENT '已完成缝纫数量',
  `is_started` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '缝纫任务是否已开始'
);

-- 订单产品裁剪任务原料分配表
CREATE TABLE `cutting_material_allocation` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '裁剪任务原料分配ID',
  `warehouse_material_id` VARCHAR(36) NOT NULL COMMENT '仓库原料ID',
  `cutting_task_id` VARCHAR(36) NOT NULL COMMENT '裁剪任务ID',
  `allocated_num` INTEGER NOT NULL DEFAULT 0 COMMENT '原料分配数量',
  `is_allocated` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '原料是否已分配'
);

-- 订单产品缝纫任务原料分配表
CREATE TABLE `sewing_material_allocation` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '缝纫任务原料分配ID',
  `warehouse_material_id` VARCHAR(36) NOT NULL COMMENT '仓库原料ID',
  `sewing_task_id` VARCHAR(36) NOT NULL COMMENT '缝纫任务ID',
  `allocated_num` INTEGER NOT NULL DEFAULT 0 COMMENT '原料分配数量',
  `is_allocated` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '原料是否已分配'
);

-- 仓库表
CREATE TABLE `warehouse` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '仓库ID',
  `name` VARCHAR(255) NOT NULL COMMENT '仓库名称'
);

-- 仓库产品关系表
CREATE TABLE `warehouse_product` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '仓库产品ID',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '仓库ID',
  `product_id` VARCHAR(36) NOT NULL COMMENT '产品ID',
  `left_number` INTEGER NOT NULL DEFAULT 0 COMMENT '产品剩余库存数量'
);

-- 仓库原料关系表
CREATE TABLE `warehouse_material` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '仓库原料ID',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '仓库ID',
  `material_id` VARCHAR(36) NOT NULL COMMENT '原料ID',
  `left_number` INTEGER NOT NULL DEFAULT 0 COMMENT '原料剩余库存数量'
);

-- 外键约束
ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `customers` (`id`);
ALTER TABLE `products` ADD FOREIGN KEY (`products_type_id`) REFERENCES `products_types` (`id`);
ALTER TABLE `order_product` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
ALTER TABLE `order_product` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
ALTER TABLE `warehouse_product` ADD FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`);
ALTER TABLE `warehouse_material` ADD FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`);
ALTER TABLE `warehouse_material` ADD FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`);
ALTER TABLE `sewing_tasks` ADD FOREIGN KEY (`working_group_id`) REFERENCES `working_group` (`id`);
ALTER TABLE `cutting_tasks` ADD FOREIGN KEY (`working_group_id`) REFERENCES `working_group` (`id`);
ALTER TABLE `cutting_tasks` ADD FOREIGN KEY (`order_product_id`) REFERENCES `order_product` (`id`);
ALTER TABLE `warehouse_product` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
ALTER TABLE `sewing_material_allocation` ADD FOREIGN KEY (`sewing_task_id`) REFERENCES `sewing_tasks` (`id`);
ALTER TABLE `cutting_material_allocation` ADD FOREIGN KEY (`cutting_task_id`) REFERENCES `cutting_tasks` (`id`);
ALTER TABLE `cutting_material_allocation` ADD FOREIGN KEY (`warehouse_material_id`) REFERENCES `warehouse_material` (`id`);
ALTER TABLE `sewing_material_allocation` ADD FOREIGN KEY (`warehouse_material_id`) REFERENCES `warehouse_material` (`id`);
ALTER TABLE `sewing_tasks` ADD FOREIGN KEY (`order_product_id`) REFERENCES `order_product` (`id`);

-- 插入示例数据

-- 问题：id类型需要设置成自增的整型吗
-- 插入客户数据
INSERT INTO `customers` (`id`, `customer_name`) VALUES
('c1', '香港理工大学'),
('c2', '客户B');

-- 插入订单数据
INSERT INTO `orders` (`id`, `user_id`, `order_name`, `created_at`) VALUES
('o1', 'c1', '订单1', '2024-05-01 08:00:00'),
('o2', 'c2', '订单2', '2024-05-02 09:00:00');

-- 插入产品类型数据
INSERT INTO `products_types` (`id`, `description`) VALUES
('pt1', 'T恤'),
('pt2', '裤子');

-- 插入产品数据
INSERT INTO `products` (`id`, `products_type_id`, `attributes`) VALUES
('p1', 'pt1', '红色, M号'),
('p2', 'pt2', '蓝色, 32码');

-- 插入原料数据
INSERT INTO `materials` (`id`, `name`, `unit`, `type`) VALUES
('m1', '棉布', '米', 'origin'),
('m2', '棉布片', '片', 'wip');

-- 插入工作组数据
INSERT INTO `working_group` (`id`, `type`, `name`) VALUES
('wg1', 'cut', '标兵组'),
('wg2', 'sew', '缝纫组1');

-- 插入订单产品关系数据
INSERT INTO `order_product` (`id`, `order_id`, `product_id`, `number`) VALUES
('op1', 'o1', 'p1', 100), -- 订单1中包含100个T恤
('op2', 'o2', 'p2', 50); -- 订单2中包含50个裤子

-- 插入裁剪任务数据
-- 问题：是否缺失了origin原料 -> wip原料 合成用量与损耗率的表
INSERT INTO `cutting_tasks` (`id`, `start_time`, `end_time`, `working_group_id`, `order_product_id`, `planned_number`, `completed_number`, `is_started`) VALUES
('ct1', '2024-05-03 08:00:00', '2024-05-04 17:00:00', 'wg1', 'op1', 100, 50, TRUE); -- 订单1的裁剪任务, 计划裁剪100个棉布片, 已完成裁剪50个

-- 插入缝纫任务数据
-- 问题：是否缺失了wip原料 -> product 合成用量与损耗率的表
INSERT INTO `sewing_tasks` (`id`, `start_time`, `end_time`, `working_group_id`, `order_product_id`, `planned_number`, `completed_number`, `is_started`) VALUES
('st1', '2024-05-05 08:00:00', '2024-05-06 17:00:00', 'wg2', 'op1', 100, 30, TRUE); -- 订单1的缝纫任务, 计划缝纫100个T恤, 已完成缝纫30个

-- 插入仓库数据
INSERT INTO `warehouse` (`id`, `name`) VALUES
('w1', '主仓库'),
('w2', '辅助仓库');

-- 插入仓库产品关系数据
-- 问题：是否统计进行中缝纫任务完成的产品，什么时候入库
INSERT INTO `warehouse_product` (`id`, `warehouse_id`, `product_id`, `left_number`) VALUES
('wp1', 'w1', 'p1', 0),
('wp2', 'w2', 'p2', 0);

-- 插入仓库原料关系数据
-- 问题：是否统计进行中裁剪任务使用的原料以及裁剪后的半成品，什么时候出库与入库
-- 问题：是否统计进行中的缝纫任务使用的半成品，什么时候出库
INSERT INTO `warehouse_material` (`id`, `warehouse_id`, `material_id`, `left_number`) VALUES
('wm1', 'w1', 'm1', 500), -- 主仓库有500米棉布
('wm2', 'w2', 'm2', 200); -- 辅助仓库有50个棉布片

-- 插入裁剪任务原料分配数据
INSERT INTO `cutting_material_allocation` (`id`, `warehouse_material_id`, `cutting_task_id`, `allocated_num`, `is_allocated`) VALUES
('cma1', 'wm1', 'ct1', 100, TRUE); -- 主仓库的100米棉布分配给订单1的裁剪任务, 1米棉布裁剪1个棉布片

-- 插入缝纫任务原料分配数据
INSERT INTO `sewing_material_allocation` (`id`, `warehouse_material_id`, `sewing_task_id`, `allocated_num`, `is_allocated`) VALUES
('sma1', 'wm2', 'st1', 100, TRUE); -- 辅助仓库的100片棉布片分配给订单1的缝纫任务, 1片棉布片缝纫1个T恤
