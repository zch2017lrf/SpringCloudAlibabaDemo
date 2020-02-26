/*
 Navicat Premium Data Transfer

 Source Server         : 云上数据库
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 122.51.68.122:8306
 Source Schema         : kaleldo_nacos

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 26/02/2020 18:11:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'auth.yaml', 'DEFAULT_GROUP', 'server:\r\n  port: 8101\r\n\r\nspring:\r\n  boot:\r\n        admin:\r\n          client:\r\n            url: http://localhost:8401\r\n            username: kaleldo\r\n            password: 123456\r\n  redis:\r\n      database: 0\r\n      host: 192.168.1.195\r\n      port: 8379\r\n      password: kaleldo123456\r\n      lettuce:\r\n        pool:\r\n          min-idle: 8\r\n          max-idle: 500\r\n          max-active: 2000\r\n          max-wait: 10000\r\n      timeout: 5000\r\n  datasource:\r\n    dynamic:\r\n      hikari:\r\n        connection-timeout: 30000\r\n        max-lifetime: 1800000\r\n        max-pool-size: 15\r\n        min-idle: 5\r\n        connection-test-query: select 1\r\n        pool-name: FebsHikariCP\r\n      primary: base\r\n      datasource:\r\n        base:\r\n          username: root\r\n          password: kaleldo123456\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://122.51.68.122:8306/kaleldo_cloud_base?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.kaleldo.pojo.system\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\n\r\n#eureka:\r\n#  instance:\r\n#    lease-renewal-interval-in-seconds: 20\r\n#  client:\r\n#    register-with-eureka: true\r\n#    fetch-registry: true\r\n#    instance-info-replication-interval-seconds: 30\r\n#    registry-fetch-interval-seconds: 3\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS', '3bcd42e10edf18ad0d8ea875ae33df98', '2020-02-26 17:04:11', '2020-02-26 17:04:11', NULL, '0:0:0:0:0:0:0:1', '', '', 'auth验证服务配置', NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (2, 'gateway.yaml', 'DEFAULT_GROUP', 'server:\r\n  port: 8301\r\n\r\nspring:\r\n  application:\r\n    name: Kaleldo-Gateway\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\n  cloud:\r\n      gateway:\r\n        routes:\r\n          - id: Kaleldo-Auth\r\n            uri: lb://Kaleldo-Auth\r\n            predicates:\r\n              - Path=/auth/**\r\n          - id: Server-System\r\n            uri: lb://Server-System\r\n            predicates:\r\n              - Path=/system/**\r\n            filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-System\r\n          - id: Server-Test\r\n            uri: lb://Server-Test\r\n            predicates:\r\n              - Path=/test/**\r\n            filters: #定义Server-Test的熔断器\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-Test\r\n        default-filters:\r\n              - StripPrefix=1\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000 #超时时间', 'c841aee729805acb4c7bcc6eddcf966d', '2020-02-26 17:13:40', '2020-02-26 18:09:52', NULL, '0:0:0:0:0:0:0:1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (3, 'system.yaml', 'DEFAULT_GROUP', 'spring:\r\n  datasource:\r\n      dynamic:\r\n        p6spy: true #p6spy用于在控制台中打印MyBatis执行的SQL\r\n        hikari:\r\n          connection-timeout: 30000\r\n          max-lifetime: 1800000\r\n          max-pool-size: 15\r\n          min-idle: 5\r\n          connection-test-query: select 1\r\n          pool-name: FebsHikariCP\r\n        primary: base\r\n        datasource:\r\n          base:\r\n            username: root\r\n            password: kaleldo123456\r\n            driver-class-name: com.mysql.cj.jdbc.Driver\r\n            url: jdbc:mysql://122.51.68.122:8306/kaleldo_cloud_base?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n  boot:\r\n        admin:\r\n          client:\r\n            url: http://localhost:8401\r\n            username: kaleldo\r\n            password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.kaleldo.pojo.system\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\nserver:\r\n  port: 8762\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user\r\nlogging:\r\n  level:\r\n    com.alibaba.nacos.client: error', '2789f6d50fee47af69b9dc4b8b96e99d', '2020-02-26 17:14:37', '2020-02-26 18:06:04', NULL, '0:0:0:0:0:0:0:1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (4, 'test.yaml', 'DEFAULT_GROUP', 'spring:\r\n  thymeleaf:\r\n      cache: false\r\n      mode: LEGACYHTML5\r\n      encoding: UTF-8\r\n      servlet:\r\n        content-type: text/html\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nserver:\r\n  port: 8764\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\nhystrix:\r\n    shareSecurityContext: true\r\nlogging:\r\n  level:\r\n    com.alibaba.nacos.client: error', 'a7ed9c67c9066bdc899f8c17b3bf421b', '2020-02-26 17:15:22', '2020-02-26 18:06:18', NULL, '0:0:0:0:0:0:0:1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (5, 'monitor.yaml', 'DEFAULT_GROUP', 'server:\r\n  port: 8401\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: ${spring.application.name}\r\n  security:\r\n      user:\r\n        name: kaleldo\r\n        password: 123456', 'd33917b72af5851d1283e10b7388edb8', '2020-02-26 17:31:24', '2020-02-26 17:31:24', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(64) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (0, 1, 'auth.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 8101\r\n\r\nspring:\r\n  boot:\r\n        admin:\r\n          client:\r\n            url: http://localhost:8401\r\n            username: kaleldo\r\n            password: 123456\r\n  redis:\r\n      database: 0\r\n      host: 192.168.1.195\r\n      port: 8379\r\n      password: kaleldo123456\r\n      lettuce:\r\n        pool:\r\n          min-idle: 8\r\n          max-idle: 500\r\n          max-active: 2000\r\n          max-wait: 10000\r\n      timeout: 5000\r\n  datasource:\r\n    dynamic:\r\n      hikari:\r\n        connection-timeout: 30000\r\n        max-lifetime: 1800000\r\n        max-pool-size: 15\r\n        min-idle: 5\r\n        connection-test-query: select 1\r\n        pool-name: FebsHikariCP\r\n      primary: base\r\n      datasource:\r\n        base:\r\n          username: root\r\n          password: kaleldo123456\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://122.51.68.122:8306/kaleldo_cloud_base?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.kaleldo.pojo.system\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\n\r\n#eureka:\r\n#  instance:\r\n#    lease-renewal-interval-in-seconds: 20\r\n#  client:\r\n#    register-with-eureka: true\r\n#    fetch-registry: true\r\n#    instance-info-replication-interval-seconds: 30\r\n#    registry-fetch-interval-seconds: 3\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS', '3bcd42e10edf18ad0d8ea875ae33df98', '2010-05-05 00:00:00', '2020-02-26 17:04:11', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 2, 'gateway.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 8301\r\n\r\nspring:\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\n  cloud:\r\n      gateway:\r\n        routes:\r\n          - id: Kaleldo-Auth\r\n            uri: lb://Kaleldo-Auth #路由的目标地址，可以指定为HTTP地址，也可以通过lb://{微服务名称}来指定。lb为load balance的缩写，微服务名称为注册中心中对应的微服务名称。比如将uri配置为lb://Kaleldo-Auth\r\n            predicates:\r\n              - Path=/auth/** #表示请求Path以/auth开头的都会被匹配\r\n          - id: Server-System\r\n            uri: lb://Server-System\r\n            predicates:\r\n              - Path=/system/**\r\n            filters: #定义Server-System的熔断器\r\n              - name: Hystrix #指定添加Hystrix过滤器\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-System #fallbackUri指定了回退的重定向地址\r\n          - id: Server-Test\r\n            uri: lb://Server-Test\r\n            predicates:\r\n              - Path=/test/**\r\n            filters: #定义Server-Test的熔断器\r\n              - name: Hystrix #指定添加Hystrix过滤器\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-Test #fallbackUri指定了回退的重定向地址\r\n        default-filters:\r\n              - StripPrefix=1 #请求转发前，将Path的内容截去前面一位\r\n#eureka:\r\n#  instance:\r\n#    lease-renewal-interval-in-seconds: 20\r\n#  client:\r\n#    register-with-eureka: true\r\n#    fetch-registry: true\r\n#    instance-info-replication-interval-seconds: 30\r\n#    registry-fetch-interval-seconds: 3\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n#zuul:\r\n#  routes:\r\n#    auth:\r\n#      path: /auth/**\r\n#      serviceId: Kaleldo-Auth\r\n#      sensitiveHeaders: \"*\"\r\n#    system:\r\n#      path: /system/**\r\n#      serviceId: Server-System\r\n#      sensitiveHeaders: \"*\"\r\n#    test:\r\n#      path: /test/**\r\n#      serviceId: Server-Test\r\n#      sensitiveHeaders: \"*\"\r\n#  retryable: true\r\n#  ignored-services: \"*\"\r\n#  ribbon:\r\n#    eager-load:\r\n#      enabled: true\r\n\r\n#ribbon:\r\n#  ReadTimeout: 3000\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000 #超时时间', '274c69a8bb8b95cdf9bf63ed6ccfe56f', '2010-05-05 00:00:00', '2020-02-26 17:13:40', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 3, 'system.yaml', 'DEFAULT_GROUP', '', 'spring:\r\n  datasource:\r\n      dynamic:\r\n        p6spy: true #p6spy用于在控制台中打印MyBatis执行的SQL\r\n        hikari:\r\n          connection-timeout: 30000\r\n          max-lifetime: 1800000\r\n          max-pool-size: 15\r\n          min-idle: 5\r\n          connection-test-query: select 1\r\n          pool-name: FebsHikariCP\r\n        primary: base\r\n        datasource:\r\n          base:\r\n            username: root\r\n            password: 123456\r\n            driver-class-name: com.mysql.cj.jdbc.Driver\r\n            url: jdbc:mysql://192.168.1.195:3306/kaleldo_cloud_base?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n  boot:\r\n        admin:\r\n          client:\r\n            url: http://localhost:8401\r\n            username: kaleldo\r\n            password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.kaleldo.pojo.system\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\nserver:\r\n  port: 8762\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user', '6ba54dce0a132a5819276d96bea5403f', '2010-05-05 00:00:00', '2020-02-26 17:14:37', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 4, 'test.yaml', 'DEFAULT_GROUP', '', 'spring:\r\n  thymeleaf:\r\n      cache: false\r\n      mode: LEGACYHTML5\r\n      encoding: UTF-8\r\n      servlet:\r\n        content-type: text/html\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nserver:\r\n  port: 8764\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\nhystrix:\r\n    shareSecurityContext: true', '6df1506528b2c6bd0f07193f828ba3ae', '2010-05-05 00:00:00', '2020-02-26 17:15:22', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 5, 'monitor.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 8401\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: ${spring.application.name}\r\n  security:\r\n      user:\r\n        name: kaleldo\r\n        password: 123456', 'd33917b72af5851d1283e10b7388edb8', '2010-05-05 00:00:00', '2020-02-26 17:31:24', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (3, 6, 'system.yaml', 'DEFAULT_GROUP', '', 'spring:\r\n  datasource:\r\n      dynamic:\r\n        p6spy: true #p6spy用于在控制台中打印MyBatis执行的SQL\r\n        hikari:\r\n          connection-timeout: 30000\r\n          max-lifetime: 1800000\r\n          max-pool-size: 15\r\n          min-idle: 5\r\n          connection-test-query: select 1\r\n          pool-name: FebsHikariCP\r\n        primary: base\r\n        datasource:\r\n          base:\r\n            username: root\r\n            password: 123456\r\n            driver-class-name: com.mysql.cj.jdbc.Driver\r\n            url: jdbc:mysql://192.168.1.195:3306/kaleldo_cloud_base?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n  boot:\r\n        admin:\r\n          client:\r\n            url: http://localhost:8401\r\n            username: kaleldo\r\n            password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.kaleldo.pojo.system\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\nserver:\r\n  port: 8762\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user', '6ba54dce0a132a5819276d96bea5403f', '2010-05-05 00:00:00', '2020-02-26 17:32:57', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 7, 'gateway.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 8301\r\n\r\nspring:\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\n  cloud:\r\n      gateway:\r\n        routes:\r\n          - id: Kaleldo-Auth\r\n            uri: lb://Kaleldo-Auth #路由的目标地址，可以指定为HTTP地址，也可以通过lb://{微服务名称}来指定。lb为load balance的缩写，微服务名称为注册中心中对应的微服务名称。比如将uri配置为lb://Kaleldo-Auth\r\n            predicates:\r\n              - Path=/auth/** #表示请求Path以/auth开头的都会被匹配\r\n          - id: Server-System\r\n            uri: lb://Server-System\r\n            predicates:\r\n              - Path=/system/**\r\n            filters: #定义Server-System的熔断器\r\n              - name: Hystrix #指定添加Hystrix过滤器\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-System #fallbackUri指定了回退的重定向地址\r\n          - id: Server-Test\r\n            uri: lb://Server-Test\r\n            predicates:\r\n              - Path=/test/**\r\n            filters: #定义Server-Test的熔断器\r\n              - name: Hystrix #指定添加Hystrix过滤器\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-Test #fallbackUri指定了回退的重定向地址\r\n        default-filters:\r\n              - StripPrefix=1 #请求转发前，将Path的内容截去前面一位\r\n#eureka:\r\n#  instance:\r\n#    lease-renewal-interval-in-seconds: 20\r\n#  client:\r\n#    register-with-eureka: true\r\n#    fetch-registry: true\r\n#    instance-info-replication-interval-seconds: 30\r\n#    registry-fetch-interval-seconds: 3\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n#zuul:\r\n#  routes:\r\n#    auth:\r\n#      path: /auth/**\r\n#      serviceId: Kaleldo-Auth\r\n#      sensitiveHeaders: \"*\"\r\n#    system:\r\n#      path: /system/**\r\n#      serviceId: Server-System\r\n#      sensitiveHeaders: \"*\"\r\n#    test:\r\n#      path: /test/**\r\n#      serviceId: Server-Test\r\n#      sensitiveHeaders: \"*\"\r\n#  retryable: true\r\n#  ignored-services: \"*\"\r\n#  ribbon:\r\n#    eager-load:\r\n#      enabled: true\r\n\r\n#ribbon:\r\n#  ReadTimeout: 3000\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000 #超时时间', '274c69a8bb8b95cdf9bf63ed6ccfe56f', '2010-05-05 00:00:00', '2020-02-26 17:49:28', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 8, 'gateway.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 8301\r\n\r\nspring:\r\n  application:\r\n    name: Kaleldo-Gateway\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\n  cloud:\r\n      gateway:\r\n        routes:\r\n          - id: Kaleldo-Auth\r\n            uri: lb://Kaleldo-Auth\r\n            predicates:\r\n              - Path=/auth/**\r\n          - id: Server-System\r\n            uri: lb://Server-System\r\n            predicates:\r\n              - Path=/system/**\r\n            filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-System\r\n          - id: Server-Test\r\n            uri: lb://Server-Test\r\n            predicates:\r\n              - Path=/test/**\r\n            filters: #定义Server-Test的熔断器\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-Test\r\n        default-filters:\r\n              - StripPrefix=1\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000 #超时时间', 'c841aee729805acb4c7bcc6eddcf966d', '2010-05-05 00:00:00', '2020-02-26 18:04:04', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (3, 9, 'system.yaml', 'DEFAULT_GROUP', '', 'spring:\r\n  datasource:\r\n      dynamic:\r\n        p6spy: true #p6spy用于在控制台中打印MyBatis执行的SQL\r\n        hikari:\r\n          connection-timeout: 30000\r\n          max-lifetime: 1800000\r\n          max-pool-size: 15\r\n          min-idle: 5\r\n          connection-test-query: select 1\r\n          pool-name: FebsHikariCP\r\n        primary: base\r\n        datasource:\r\n          base:\r\n            username: root\r\n            password: kaleldo123456\r\n            driver-class-name: com.mysql.cj.jdbc.Driver\r\n            url: jdbc:mysql://122.51.68.122:8306/kaleldo_cloud_base?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n  boot:\r\n        admin:\r\n          client:\r\n            url: http://localhost:8401\r\n            username: kaleldo\r\n            password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.kaleldo.pojo.system\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\nserver:\r\n  port: 8762\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user', '26d35683d3c59c3aab4773e225a5bfa8', '2010-05-05 00:00:00', '2020-02-26 18:06:04', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 10, 'test.yaml', 'DEFAULT_GROUP', '', 'spring:\r\n  thymeleaf:\r\n      cache: false\r\n      mode: LEGACYHTML5\r\n      encoding: UTF-8\r\n      servlet:\r\n        content-type: text/html\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\n\r\nserver:\r\n  port: 8764\r\n\r\n#eureka:\r\n#  client:\r\n#    serviceUrl:\r\n#      defaultZone: http://localhost:8761/eureka/\r\n\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://localhost:8301/auth/user\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\nhystrix:\r\n    shareSecurityContext: true', '6df1506528b2c6bd0f07193f828ba3ae', '2010-05-05 00:00:00', '2020-02-26 18:06:18', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 11, 'gateway.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 8301\r\n\r\nspring:\r\n  application:\r\n    name: Kaleldo-Gateway\r\n  autoconfigure:\r\n    exclude: com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration\r\n  boot:\r\n          admin:\r\n            client:\r\n              url: http://localhost:8401\r\n              username: kaleldo\r\n              password: 123456\r\n  cloud:\r\n      gateway:\r\n        routes:\r\n          - id: Kaleldo-Auth\r\n            uri: lb://Kaleldo-Auth\r\n            predicates:\r\n              - Path=/auth/**\r\n          - id: Kaleldo-System\r\n            uri: lb://Kaleldo-System\r\n            predicates:\r\n              - Path=/system/**\r\n            filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-System\r\n          - id: Kaleldo-Test\r\n            uri: lb://Kaleldo-Test\r\n            predicates:\r\n              - Path=/test/**\r\n            filters: #定义Server-Test的熔断器\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Server-Test\r\n        default-filters:\r\n              - StripPrefix=1\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\n  endpoint:\r\n    health:\r\n      show-details: ALWAYS\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000 #超时时间', '9340cf05491e455a7c726149e78e7ad1', '2010-05-05 00:00:00', '2020-02-26 18:09:52', NULL, '0:0:0:0:0:0:0:1', 'U', '');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
