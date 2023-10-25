use datawebmaydomba;

CREATE TABLE role (
  `idrole` INT NOT NULL AUTO_INCREMENT,
  `rolename` VARCHAR(45) NULL,
  `action` VARCHAR(45) NOT NULL,
  `status` INT NOT NULL,
  `createAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `updateAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idrole`));


CREATE TABLE permission  (
  `idpermission` INT NOT NULL AUTO_INCREMENT,
  `permissionname` VARCHAR(45) NULL,-- Thêm sản phẩm
  `action` VARCHAR(45) NOT NULL,-- client-- keyword AddProduct
  `status` INT NOT NULL,
  `createAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `updateAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idpermission`));


CREATE TABLE role_permission (
  `idrole` INT NOT NULL,
  `idpermission` INT NOT NULL,
  `status` INT NOT NULL,
  `createAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `updateAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idrole`, `idpermission`));


ALTER TABLE role_permission
ADD CONSTRAINT `fk_idrole`
  FOREIGN KEY (`idrole`)
  REFERENCES `role` (`idrole`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


ALTER TABLE role_permission 
ADD CONSTRAINT `fk_idpermission`
  FOREIGN KEY (`idpermission`)
  REFERENCES `permission` (`idpermission`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE user 
ADD COLUMN `idrole` INT NULL AFTER `status`;

ALTER TABLE user 
ADD CONSTRAINT `fk_idrole_user`
  FOREIGN KEY (`idrole`)
  REFERENCES `role` (`idrole`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

select * from user where username = 'admin' and password = '6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090' and status = 1;
-- có roleid
-- dánh sách vai trờ (role) và quyền (permission)
select rp.idrole, r.rolename, r.action, rp.idpermission,  p.permissionname, p.action
from role_permission rp
join role r on rp.idrole = r.idrole
join permission p on rp.idpermission = p.idpermission
where rp.idrole = 3;


/* Du lieu */

INSERT INTO role (`idrole`, `rolename`, `status`, `action`) VALUES (1,'Giám đốc', '1', 'giamdoc');
INSERT INTO role (`idrole`, `rolename`, `status`, `action`) VALUES (2,'Quản lí sản phẩm', '1', 'quanlisanpham');
INSERT INTO role (`idrole`, `rolename`, `status`, `action`) VALUES (3,'Quản lí đơn hàng', '1', 'quanlidonhang');
INSERT INTO role (`idrole`, `rolename`, `status`, `action`) VALUES (4,'Quản lí bình luận', '1', 'quanlibinhluan');

UPDATE user SET `idrole` = '1' WHERE (`iduser` = '1');
UPDATE user SET `role` = '2', `idrole` = '2' WHERE (`iduser` = '5');

INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (1, 'Danh sách sản phẩm', 'product.list', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (2, 'Thêm sản phẩm', 'product.add', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (3, 'Chỉnh sửa sản phẩm', 'product.edit', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (4, 'Xem chi tiết sản phẩm', 'product.detail', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (5, 'Xóa sản phẩm', 'product.delete', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (6, 'Danh sách đơn hàng', 'order.list', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (7, 'Cập nhật trạng thái đơn hàng', 'order.edit', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (8, 'Chi tiết đơn hàng', 'order.detail', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (9, 'Danh sách tài khoản', 'user.list', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (10, 'Thêm tài khoản', 'user.add', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (11, 'Chỉnh sửa tài khoản', 'user.edit', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (12, 'Xem chi tiết tài khoản', 'user.detail', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (13, 'Xóa tài khoản', 'user.delete', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (14, 'Phân quyền', 'permission.list', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (15, 'Thêm phân quyền', 'permission.add', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (16, 'Chỉnh sửa phân quyền', 'permission.edit', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (17, 'Xem chi tiết phân quyền', 'permission.detail', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (18, 'Xóa phân quyền', 'permission.delete', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (19, 'Role', 'role.list', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (20, 'Quản lí phân quyền', 'permission.crud.list', '1');
INSERT INTO permission (`idpermission`,`permissionname`, `action`, `status`) VALUES (21, 'Quản lí role', 'role.crud.list', '1');


INSERT INTO `datawebmaydomba`.`permission` (`idpermission`, `permissionname`, `action`, `status`) VALUES ('22', 'Quản lý bình luận', 'comments.list', '1');
INSERT INTO `datawebmaydomba`.`permission` (`idpermission`, `permissionname`, `action`, `status`) VALUES ('23', 'Quản lý giới thiệu', 'aboutus.list', '1');
INSERT INTO `datawebmaydomba`.`permission` (`idpermission`, `permissionname`, `action`, `status`) VALUES ('24', 'Quản lý tin tức', 'news.list', '1');


INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 1, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 2, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 3, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 4, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 5, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 6, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 7, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 8, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 9, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 10, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 11, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 12, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 13, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 14, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 15, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 16, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 17, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 18, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 19, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 20, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (1, 21, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (2, 1, 1);
INSERT INTO role_permission (`idrole`, `idpermission`, `status`) VALUES (2, 2, 0);
INSERT INTO `datawebmaydomba`.`role_permission` (`idrole`, `idpermission`, `status`) VALUES ('1', '22', '1');
INSERT INTO `datawebmaydomba`.`role_permission` (`idrole`, `idpermission`, `status`) VALUES ('1', '23', '1');
INSERT INTO `datawebmaydomba`.`role_permission` (`idrole`, `idpermission`, `status`) VALUES ('1', '24', '1');



CREATE TABLE `log` (
  `idlog` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `createAt` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idlog`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4


/* fk_useridaddress
fk_useridcoupons
fk_useridinvoice
fk_useridorders */

CREATE TABLE `facebook` (
  `idfacebook` varchar(45) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idfacebook`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `user`
ADD COLUMN `idfacebook` VARCHAR(45) NULL DEFAULT NULL AFTER `idrole`;


ALTER TABLE user 
ADD CONSTRAINT `fk_idfacebook_user`
  FOREIGN KEY (`idfacebook`)
  REFERENCES `facebook` (`idfacebook`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

DROP TABLE IF EXISTS `voucher_users`;
CREATE TABLE datawebmaydomba.`voucher_users` (
                                                 idvouchers INT NOT NULL,
                                                 iduser INT NOT NULL,
                                                 quantity INT NULL,
                                                 isActive INT NULL,
                                                 PRIMARY KEY (idvouchers, iduser));

ALTER TABLE datawebmaydomba.`voucher_users`
    ADD CONSTRAINT fk_iduser
        FOREIGN KEY (iduser)
            REFERENCES datawebmaydomba.`user` (iduser)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
ADD CONSTRAINT fk_idvoucher
  FOREIGN KEY (idvouchers)
  REFERENCES datawebmaydomba.`vouchers` (idvouchers)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
-- ----------------------------
-- Records of voucher_users
-- ----------------------------
INSERT INTO `voucher_users` VALUES (1, 2, 1, 1);
INSERT INTO `voucher_users` VALUES (2, 2, 1, 1);
INSERT INTO `voucher_users` VALUES (3, 2, 1, 1);
INSERT INTO `voucher_users` VALUES (4, 2, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;

DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers`  (
                             `idvouchers` int NOT NULL AUTO_INCREMENT,
                             `nameVoucher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                             `quantity` int NULL DEFAULT NULL,
                             `diktat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                             `value` int NULL DEFAULT NULL,
                             `startAt` datetime NULL DEFAULT NULL,
                             `finishAt` datetime NULL DEFAULT NULL,
                             `status` int NULL DEFAULT NULL COMMENT '0: lock; 1: active',
                             `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                             PRIMARY KEY (`idvouchers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

INSERT INTO `vouchers` VALUES (1, 'Giảm tối đa 400K', 99, 'Đơn tối thiểu 0đ', 400000, '2022-12-23 06:00:00', '2023-06-30 06:00:00', 1, NULL);
INSERT INTO `vouchers` VALUES (2, 'Giảm tối đa 100K', 500, 'Đơn tối thiểu 0đ', 100000, '2023-06-01 06:00:00', '2023-06-10 06:00:00', 1, NULL);
INSERT INTO `vouchers` VALUES (3, 'Giảm tối đa 1 triệu', 10, 'Đơn tối thiểu 500K', 1000000, '2023-06-06 06:00:00', '2023-06-06 23:00:00', 0, NULL);
INSERT INTO `vouchers` VALUES (4, 'Giảm tối đa 350K', 150, 'Đơn tối thiểu 500K', 350000, '2023-05-15 06:00:00', '2023-05-15 13:00:00', 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;