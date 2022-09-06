/*
 Navicat Premium Data Transfer

 Source Server         : 腾讯云
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 106.53.73.30:3306
 Source Schema         : travel_agency

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 12/03/2022 22:30:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for t_area
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `province_id` int NULL DEFAULT NULL COMMENT '所属省份ID',
  `area_name` varchar(64) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '区划名字',
  `create_date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_parent` varchar(1) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '是否是一级省份（0不是 1是）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8  COMMENT = '省份城市表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_area
-- ----------------------------
INSERT INTO `t_area` VALUES (9, NULL, '海南省', '2022-02-10 17:44:38', '1');
INSERT INTO `t_area` VALUES (10, 9, '三亚市', '2022-02-10 17:44:54', '0');
INSERT INTO `t_area` VALUES (12, NULL, '河北省', '2022-02-21 17:47:09', '1');
INSERT INTO `t_area` VALUES (13, 12, '石家庄市', '2022-02-21 17:47:16', '0');
INSERT INTO `t_area` VALUES (14, 12, '张家口市', '2022-02-21 17:47:24', '0');
INSERT INTO `t_area` VALUES (15, NULL, '北京市', '2022-02-21 17:47:40', '1');
INSERT INTO `t_area` VALUES (19, NULL, '四川省', '2022-02-21 17:48:09', '1');
INSERT INTO `t_area` VALUES (20, 19, '成都市', '2022-02-21 17:48:21', '0');
INSERT INTO `t_area` VALUES (21, 15, '北京市', '2022-02-21 18:14:46', '0');
INSERT INTO `t_area` VALUES (24, NULL, '江西省', '2022-02-22 00:22:02', '1');
INSERT INTO `t_area` VALUES (25, 24, '吉安市', '2022-02-22 00:22:13', '0');
INSERT INTO `t_area` VALUES (26, NULL, '山东省', '2022-02-22 00:27:28', '1');
INSERT INTO `t_area` VALUES (27, 26, '泰安市', '2022-02-22 00:27:35', '0');
INSERT INTO `t_area` VALUES (28, NULL, '陕西省', '2022-02-22 00:33:05', '1');
INSERT INTO `t_area` VALUES (29, 28, '渭南市', '2022-02-22 00:33:11', '0');
INSERT INTO `t_area` VALUES (30, 28, '西安市', '2022-02-22 18:23:16', '0');
INSERT INTO `t_area` VALUES (31, NULL, '湖南省', '2022-02-26 21:27:24', '1');
INSERT INTO `t_area` VALUES (32, 31, '张家界市', '2022-02-26 21:27:32', '0');
INSERT INTO `t_area` VALUES (33, 24, '南昌市', '2022-02-26 21:52:42', '0');
INSERT INTO `t_area` VALUES (34, 28, '延安市', '2022-02-26 22:21:59', '0');
INSERT INTO `t_area` VALUES (35, NULL, '贵州省', '2022-02-26 22:38:38', '1');
INSERT INTO `t_area` VALUES (36, 35, '安顺市', '2022-02-26 22:38:46', '0');

-- ----------------------------
-- Table structure for t_collect
-- ----------------------------
DROP TABLE IF EXISTS `t_collect`;
CREATE TABLE `t_collect`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int NULL DEFAULT NULL COMMENT '对应用户ID',
  `strategy_id` int NULL DEFAULT NULL COMMENT '对应攻略ID',
  `create_date` datetime NULL DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8  COMMENT = '用户收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_collect
-- ----------------------------
INSERT INTO `t_collect` VALUES (5, 2, 1, '2022-03-03 17:56:16');
INSERT INTO `t_collect` VALUES (6, 2, 3, '2022-03-05 18:35:51');
INSERT INTO `t_collect` VALUES (9, 1, 3, '2022-03-05 18:48:00');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int NULL DEFAULT NULL COMMENT '评论人',
  `strategy_id` int NULL DEFAULT NULL COMMENT '对应的攻略ID',
  `comment_id` int NULL DEFAULT NULL COMMENT '父级评论ID',
  `content` varchar(1024) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '评论内容',
  `create_date` datetime NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8  COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 1, 1, NULL, '测试评论', '2022-02-22 19:47:42');
INSERT INTO `t_comment` VALUES (2, 1, 1, 1, '测试评论222222', '2022-02-22 19:47:42');
INSERT INTO `t_comment` VALUES (3, 2, 1, NULL, '厉害厉害', '2022-03-03 18:31:01');
INSERT INTO `t_comment` VALUES (4, 2, 1, 1, '悟天弟弟', '2022-03-03 20:13:51');
INSERT INTO `t_comment` VALUES (5, 2, 3, NULL, '我去过我去过', '2022-03-05 18:36:03');
INSERT INTO `t_comment` VALUES (6, 1, 3, 5, '我也去过！', '2022-03-05 18:48:12');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `strategy_id` int NULL DEFAULT NULL COMMENT '对应攻略ID',
  `user_id` int NULL DEFAULT NULL COMMENT '对应的用户ID',
  `create_date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8  COMMENT = '消息通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES (1, 1, 2, '2022-03-05 17:18:38');
INSERT INTO `t_notice` VALUES (2, 3, 2, '2022-03-05 18:48:13');

-- ----------------------------
-- Table structure for t_scenic_spot
-- ----------------------------
DROP TABLE IF EXISTS `t_scenic_spot`;
CREATE TABLE `t_scenic_spot`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `type_id` int NULL DEFAULT NULL COMMENT '对应景区分类信息的ID',
  `area_id` int NULL DEFAULT NULL COMMENT '对应所属区域信息的ID',
  `name` varchar(255) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '景区名',
  `readme` text CHARACTER SET utf8  NULL COMMENT '景区简介',
  `business_start_date` time(0) NULL DEFAULT NULL COMMENT '营业开始时间',
  `business_end_date` time(0) NULL DEFAULT NULL COMMENT '营业结束时间',
  `price` decimal(14, 2) NULL DEFAULT NULL COMMENT '票价',
  `skip_url` varchar(255) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '官方购票地址',
  `search_keyword` varchar(255) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '搜索关键字（多个关键字英文逗号分割）',
  `create_date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_red` varchar(1) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '是否是红色景区（0不是 1是）',
  `head_img` varchar(512) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '景区图',
  `is_index` varchar(1) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '是否首页推荐展示 (0否 1是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8  COMMENT = '景区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_scenic_spot
-- ----------------------------
INSERT INTO `t_scenic_spot` VALUES (1, 8, 21, '故宫博物院', '1911年辛亥革命胜利后，清王朝政府宣布退位，这座宫殿本应全部收归国有，但根据当时临时革命政府拟定的《清室优待条件》，逊帝溥仪却被允许“暂居宫禁”，即紫禁城后部的“后寝（内廷）”。当时的政府决定，将热河（承德）行宫（即承德避暑山庄）和盛京（沈阳）故宫的文物移至故宫前半部的“前朝（外朝）”部分，于1914年成立了古物陈列所。\r\n溥仪居宫内，一直与亡清残余势力图谋复辟，且以赏赐、典当、修补等名目，从宫中盗窃大量文物，引起了社会各界的严重关注。1924年，冯玉祥发动“北京政变”，组织摄政内阁，修改对清皇室优待条件，将溥仪逐出宫禁，接管了故宫，同时成立“办理清室善后委员会”，负责清理清皇室公、私财产及处理一切善后事宜。\r\n1925年9月29日，“办理清室善后委员会”制订并通过了《故宫博物院临时组织大纲》，设临时董事会“协议全院重要事物”，由董事严修、卢永祥、蔡元培、熊希龄、张学良、张璧、庄蕴宽、鹿钟麟、许世英、梁士诒、薛笃弼、黄郛、范源濂、胡若愚、吴敬恒、李祖绅、李仲三、汪大燮、王正廷、于右任、李煜瀛等21人组成。又设临时理事会“执行全院事物”，有理事9人。下建古物馆、图书馆。李煜瀛为临时董事兼理事长，易培基任古物馆馆长，陈垣任图书馆馆长。', '08:30:00', '17:00:00', 40.00, 'https://gugong.ktmtech.cn/', '故宫', '2022-02-21 18:30:08', '0', 'http://localhost:8080/travel_agency//upload/2ddb1f3ae4cd40cab4d8ddb94e53c1fd.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (2, 2, 13, '西柏坡纪景区', '西柏坡位于河北省平山县中部，是解放战争时期中央工委、中共中央和解放军总部的所在地。1947年5月，刘少奇、朱德率中央工委进驻西柏坡。1948年5月，毛泽东、周恩来、任弼时率中央前委和解放军总部到西柏坡与中央工委汇合。在这里，毛泽东和他的战友们召开了中国共产党全国土地会议，通过了《中国土地法大纲》，实现了“耕者有其田”；指挥了辽沈、淮海、平津三大战役，决定了中国的命运；召开了中国共产党七届二中全会，描绘了新中国宏伟的蓝图。1949年3月23日，中共中央和解放军总部离开西柏坡，赴京建国。新中国从这里走来。 ', '09:00:00', '17:00:00', 0.00, 'http://www.xbpjng.cn/index.aspx', '红色景区;革命圣地', '2022-02-22 00:15:29', '1', 'http://localhost:8080/travel_agency//upload/b228f49b3a2d4c18a7f0fb10985cefd2.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (3, 2, 25, '井冈山景区', '井冈山，是一块红色的土地；井冈山，是一个绿色的宝库。“四面重峦障，五溪曲水萦。红根已深植，今日正繁荣。”老一辈无产阶级革命家董必武1960年访问井冈山时对井冈山发展的评价。井冈山——革命山——旅游山——文化山，“物华天宝钟灵毓秀，绿色明珠流光溢彩”。从红色中走来，向绿色中走去，希望您能走进井冈山，走进这片神奇的土地……', '08:00:00', '16:30:00', 160.00, 'http://www.jgstour.com/', '红色景区;革命圣地', '2022-02-22 00:23:54', '1', 'http://localhost:8080/travel_agency//upload/4d931fe916884d9684513f3df583e94b.jpeg', '1');
INSERT INTO `t_scenic_spot` VALUES (4, 4, 27, '泰山风景名胜区', '泰山是首例世界文化与自然双遗产、首批国家级风景名胜区、世界地质公园、首批国家5A级旅游景区、首批全国文明风景旅游区。', '00:00:00', '23:59:00', 100.00, 'http://tsgw.taian.gov.cn/art/2021/6/8/art_77180_5653044.html', '五岳;泰山;东岳', '2022-02-22 00:29:09', '0', 'http://localhost:8080/travel_agency//upload/ce4575cf89154459bb1ad0a668f980ca.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (5, 4, 29, '华山风景区', '中华之“华”源于华山，由此，华山有了“华夏之根”之称。华山是中国道教主流全真派圣地，为“第四洞天”，也是中国民间广泛崇奉的神祇，即西岳华山君神。共有72个半悬空洞，道观20余座，其中玉泉院、都龙庙、东道院、镇岳宫被列为全国重点道教宫观，有陈抟、郝大通、贺元希等著名的道教高人。', '08:00:00', '16:00:00', 100.00, 'http://www.chinahuashan.com/front/index.htm', '西岳;太华山;华夏之根', '2022-02-22 00:32:57', '0', 'http://localhost:8080/travel_agency//upload/3ad0493420634546bef96ca639ad15e2.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (6, 4, 20, '都江堰风景区', '都江堰是世界文化遗产（2000年被联合国教科文组织列入“世界文化遗产”名录）、世界自然遗产（四川大熊猫栖息地）、世界灌溉工程遗产、全国重点文物保护单位、国家级风景名胜区、国家AAAAA级旅游景区。', '08:00:00', '18:00:00', 80.00, 'https://www.djy517.com/online.html?channelCode=mpyd', '都江堰', '2022-02-22 00:39:16', '0', 'http://localhost:8080/travel_agency//upload/dde7ef0a963647a193451a90a5486ee3.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (7, 4, 20, '九寨沟景区', '九寨沟位于四川省西北部岷山山脉南段的阿坝藏族羌族自治州九寨沟县漳扎镇境内，地处岷山南段弓杆岭的东北侧。距离成都市400多千米，系长江水系嘉陵江上游白水江源头的一条大支沟。 九寨沟自然保护区地势南高北低，山谷深切，高差悬殊。北缘九寨沟口海拔仅2000米，中部峰岭均在4000米以上，南缘达4500米以上，主沟长30多公里。九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，也是中国第一个以保护自然风景为主要目的的自然保护区。', '08:00:00', '18:00:00', 80.00, 'https://www.jiuzhai.com/intelligent-service/tickets', '九寨沟', '2022-02-26 21:03:47', '0', 'http://localhost:8080/travel_agency//upload/6b20bca108c8467398bf00cdca2d570a.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (8, 4, 32, '张家界风景区', '张家界国家森林公园位于湖南省张家界市武陵源区，1988年8月，张家界武陵源旅游区被列入国家重点风景名胜区；1992年12月，因奇特的石英砂岩大峰林被联合国列入《世界自然遗产名录》，2004年2月被列入世界地质公园；2007年被列入中国首批国家5A级旅游景区，公园总面积4810公顷。武陵源旅游区自然风光以峰称奇、以谷显幽、以林见秀。其间有奇峰3000多座，如人如兽、如器如物，形象逼真，气势壮观，有“奇峰三千，秀水八百”之美称。主要景点有黄石寨、金鞭溪、袁家界、杨家界等。', '00:00:00', '23:59:00', 258.00, 'http://lww.zjj.gov.cn/', '张家界;玻璃栈道;森林', '2022-02-26 21:30:21', '0', 'http://localhost:8080/travel_agency//upload/6bdbb3b1f0cc4debb413273251042856.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (9, 2, 33, '八一起义纪念馆', '南昌八一起义纪念馆是为纪念南昌起义而设立的专题纪念馆。1956年成立，1959年正式对外开放，1961年被国务院公布为全国首批重点文物保护单位（所辖五处革命旧址——总指挥部旧址、贺龙指挥部旧址、叶挺指挥部旧址、朱德军官教育团旧址和朱德旧居）。作为“中国军史第一馆”，周恩来、朱德、陈毅等老一辈无产阶级革命家及江泽民、胡锦涛、习近平等党和国家领导人先后莅临参观指导，表达了我馆的深切关怀。\r\n\r\n       2008年1月，南昌八一起义纪念馆率先向全社会免费开放，并提出“免费不免票，服务不打折”的理念，年均接待量保持在200万余人次。建馆以来，共计接待海内外游客共计3000余万人次，其中未成年人1000余万人次，实现了“以史育人、以物感人、以景诱人”的目标。同时先后获得了“全国文明单位”、“国家一级博物馆”、“国家AAAA级旅游景区”，“全国红色旅游工作先进集体”、“ 中国十大经典红色景区（点）”，全国首批“爱国主义教育示范基地”和“国防教育示范基地”等一系列荣誉。\r\n       在上级有关部门的正确领导下，我馆紧紧围绕纪念馆收藏、陈列、教育三大职能，充分发挥红色革命景区的资源优势，积极开展爱国主义教育和革命传统教育，致力于成为培育和践行社会主义核心价值观的重要阵地。', '08:00:00', '17:00:00', 0.00, 'http://www.81-china.com/', '红色景区;纪念馆;八一起义', '2022-02-26 21:54:52', '1', 'http://localhost:8080/travel_agency//upload/a2e0801112e34641afb62f8d06b8a70f.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (10, 2, 34, '延安革命纪念馆', '延安革命纪念馆成立于1950年7月1日，是新中国成立后最早建成的革命纪念馆之一，是全国爱国主义、革命传统和延安精神三大教育基地，全国廉政教育基地，国家一级博物馆，国家5A级旅游景区。2004年4月，延安革命纪念馆被中共中央宣传部确定为全国爱国主义教育示范基地“一号工程”重点建设的三个教育基地之一；2006年10月，正式动工拆除原馆建新馆；2009年8月28日，新馆全面建成并免费对外开放。延安革命纪念馆建筑面积29853平方米，基本陈列面积为10677平方米。现拥有馆藏文物3.6万多件，历史照片1万余张，图书3万余册，调查访问资料百余卷，是一座集收藏、展示、研究、宣传为一体的革命纪念馆，现年接待观众近400万人次。\r\n\r\n为了庆祝中国共产党成立100周年，延安革命纪念馆全面启动并顺利完成了第10次陈列提升改造工作，基本陈列《伟大历程——中共中央在延安十三年历史》于2021年6月30日重新对外开放，以崭新风貌喜迎建党百年华诞。改陈后的《伟大历程——中共中央在延安十三年历史》陈列面积达10677平方米，展线长度为1200米，共展出珍贵文物2021件（组）、照片900余张，展览有红军长征胜利到陕北（雕塑）、整风学习、“窑洞对”、陕甘宁边区参议会、大生产、群星璀璨（场景）、干部学习、转战陕北（雕塑）、1973周恩来回延安、组雕“旗帜”“窑洞对”等艺术品场景26项，有直罗镇战役（3D裸眼技术）、瓦窑堡会议、红色电波、延安时期的对外交往、延安文艺座谈会、马栏纸动态制作流程、投豆选举等科技多媒体互动展项40项。展览共分为 ：中共中央和红军长征的落脚点 、中国人民抗日战争的政治指导中心、创建新民主主义的模范试验区 、实施党的建设伟大工程 、毛泽东思想指导地位的确立 、夺取全国胜利的出发点和“延安精神 永放光芒”七个部分，全面系统地展示了以毛泽东为核心的中共中央在延安和陕北十三年领导全国革命走向胜利的光辉历史。', '08:00:00', '18:00:00', 0.00, 'http://www.yagmjng.com/', '革命圣地;红色景区', '2022-02-26 22:24:05', '1', 'http://localhost:8080/travel_agency//upload/5f2b10b9151040749ddfbf70ca3a5957.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (11, 4, 36, '黄果树瀑布', '    黄果树风景名胜区是国家重点风景名胜区，位于贵州省西南距省会贵阳市128公里，距旅游中心安顺市45公里，有滇黔铁路、株六复线铁路、黄果树机场、320国道、贵黄高等级公路、新建的清黄（清镇至黄果树）高速路直达景区。景区内以黄果树大瀑布（高77.8米，宽101.0米）为中心，分布着雄、奇、险、秀风格各异的大小18个瀑布，形成一个庞大的瀑布“家族”。\r\n    黄果树风景区被大世界吉尼斯总部评为世界上最大的瀑布群，列入世界吉尼斯记录。它也是中国第一批国家重点风景名胜区和首批获得国家评定的4A级风景名胜区之一。1999年11月被中国科协定为全国科普教育基地。', '08:00:00', '20:00:00', 210.00, 'https://www.hgscn.com/', '瀑布;黄果树', '2022-02-26 22:40:40', '0', 'http://localhost:8080/travel_agency//upload/c00e96c851a847ddbedca857745e863d.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (12, 3, 10, '南山文化旅游区', '\r\n南山文化旅游区位于海南省三亚市西南40公里处，是中国最南端的山，属热带海洋季风性气候，其空气质量和海水质量居全国首位，森林覆盖率为97%，是一座展示中国佛教传统文化的大型园区。南山文化旅游区是国家AAAAA旅游景区，国家重点风景名胜区，全国文明风景旅游区示范点，中国人居环境范例奖，中国佛教名山胜地，中国旅游业发展优先项目，海南省生态旅游示范景区。\r\n南山主要景点有南山寺、海上观音、不二法门、观音文化苑、天竺圣迹、佛名胜景观苑、十方塔林与归根园、佛教文化交流中心、素斋购物一条街等。其中，108米海上观音是当之无愧的亮点之一，是世界首尊金玉观世音菩萨塑像，闻名全海南的镇岛之宝。', '08:00:00', '17:00:00', 150.00, 'https://you.ctrip.com/sight/sanya61/3227.html', '海边;海滩;公园;海', '2022-02-28 16:08:43', '0', 'http://localhost:8080/travel_agency//upload/fef7c7d31cb8459aaa5a3a0846942ef9.jpg', '1');
INSERT INTO `t_scenic_spot` VALUES (13, 8, 30, '兵马俑博物馆', '秦始皇兵马俑博物馆位于陕西省西安市临潼区秦陵镇，成立于1975年11月，原为秦始皇兵马俑筹建处，于1979年10月1日正式开馆，建于临潼县东7.5公里的骊山北麓的秦始皇帝陵兵马俑坑遗址上，西距西安37.5公里；和丽山园合称秦始皇帝陵博物院。截至2020年1月，秦始皇兵马俑博物馆已接待海内外观众达8000多万人次。秦兵马俑地下大军先后接待观众近5000万人次，其中共接待外国国家元首、政府首脑187批，副总统、副总理和议长506批、部长级客人1852批。截至2020年1月，已先后建成并开放了秦俑一、三、二号坑和文物陈列厅。目前秦俑博物馆面积已扩大到46.1公顷，拥有藏品5万余（套）件。一号兵马俑坑内约埋藏陶俑、陶马6000件，同时还有大量的青铜兵器；二号兵马俑坑内埋藏陶俑、陶马1300余件，二号俑坑较一号俑坑的内容更丰富，兵种更齐全；三号俑坑的规模较小，坑内埋藏陶俑、陶马72件；陈列厅内有一、二号铜车马。', '08:00:00', '16:30:00', 150.00, 'http://www.bmy.com.cn/', '兵马俑;秦始皇', '2022-02-28 16:14:29', '0', 'http://localhost:8080/travel_agency//upload/11063e5462c24d3397070606ad215519.jpg', '0');
INSERT INTO `t_scenic_spot` VALUES (14, 8, 30, '大唐不夜城', '大唐不夜城位于陕西省西安市雁塔区的大雁塔脚下，北起大雁塔南广场，南至唐城墙遗址，东起慈恩东路，西至慈恩西路，街区南北长2100米，东西宽500米，总建筑面积65万平方米。大唐不夜城以盛唐文化为背景，以唐风元素为主线，建有大雁塔北广场、玄奘广场、贞观广场、创领新时代广场四大广场，西安音乐厅、陕西大剧院、西安美术馆、曲江太平洋电影城等四大文化场馆，大唐佛文化、大唐群英谱、贞观之治、武后行从、开元盛世等五大文化雕塑，是西安唐文化展示和体验的首选之地。', '00:00:00', '23:59:00', 0.00, 'http://www.mafengwo.cn/poi/5434638.html', '步行街;', '2022-02-28 16:30:21', '0', 'http://localhost:8080/travel_agency//upload/91f8fd58bfb04b7a9a22c5cb1dcce351.jpeg', '0');
INSERT INTO `t_scenic_spot` VALUES (15, 1, 10, '亚龙湾旅游区', '亚龙湾是中华人民共和国海南省三亚市东郊的一处优质热带海滨风景区，沙滩平缓开阔，沙粒洁白细软，海水清澈澄莹，海底资源丰富，生长众多原始热带植被，颇具热带海岛风情。海湾距离市中心区约10公里，以野猪岛为中心，南有东洲岛、西洲岛，西面有东排、西排，可开展多种水上运动。亚龙湾为一个月牙湾，拥有7千米长的银白色海滩，沙质相当细腻。而这里的南海没有受到污染，海水洁净透明，远望呈现几种不同的蓝色，而水面下珊瑚种类丰富，可清楚观赏珊瑚，适合多种水面下活动包括潜水等，令海底成为了当地的旅游的核心。岸上林木郁郁葱葱。冬季这里的气温27摄氏度，水温20摄氏度，是一处理想的冬季避寒和休闲度假胜地。号称“东方夏威夷”。沿海岸一带布满多座高级酒店，包括国际五星级的假日酒店。', '00:00:00', '23:00:00', 0.00, 'https://baijiahao.baidu.com/s?id=1685698989231526972&wfr=spider&for=pc', '海滩;海边;海', '2022-02-28 16:38:04', '0', 'http://localhost:8080/travel_agency//upload/fecc5b2838e042188169edfbc35f5015.jpg', '0');


-- ----------------------------
-- Table structure for t_strategy
-- ----------------------------
DROP TABLE IF EXISTS `t_strategy`;
CREATE TABLE `t_strategy`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `title` varchar(32) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '攻略标题',
  `index_img` varchar(512) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '攻略首图（缩略图）',
  `content` text CHARACTER SET utf8  NULL COMMENT '攻略内容',
  `create_date` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `user_id` int NULL DEFAULT NULL COMMENT '对应的用户ID',
  `user_type` varchar(1) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '发布用户的类型 0代表用户  1代表管理员',
  `resume` varchar(512) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '攻略简述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8  COMMENT = '旅游攻略表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_strategy
-- ----------------------------
INSERT INTO `t_strategy` VALUES (1, '测试发布', 'http://localhost:8080/travel_agency//upload/8463280c7b124c7b8baadfafaa031031.png', '<p align=\"center\">测试攻略的发布</p><p align=\"center\"><br></p><p align=\"center\"><img src=\"http://localhost:8080/travel_agency/lib/layui/images/face/8.gif\" alt=\"[挤眼]\"><img src=\"http://localhost:8080/travel_agency/lib/layui/images/face/8.gif\" alt=\"[挤眼]\"></p><p align=\"center\"><br></p><p align=\"center\"><img src=\"http://localhost:8080/travel_agency//upload/1f69d63ff2604575a660ce8172885852.jpg\" alt=\"1f69d63ff2604575a660ce8172885852.jpg\"></p><p align=\"center\"><br></p><p>&nbsp;&nbsp;&nbsp;\n \n攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述</p><p>&nbsp;&nbsp;&nbsp; 攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述</p>', '2022-02-25 16:23:09', 1, '1', '攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述攻略简述');
INSERT INTO `t_strategy` VALUES (3, '深圳湾海滨公园', 'http://localhost:8080/travel_agency//upload/b4643be94c6449a28e6548ca52e6589b.jpg', '<div class=\"para\" data-pid=\"1\"><p>&nbsp;&nbsp;&nbsp; 2011年8月6日开园的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%B7%B1%E5%9C%B3%E6%B9%BE%E5%85%AC%E5%9B%AD/479632\" data-lemmaid=\"479632\">深圳湾公园</a>，包括已建成开放的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%A6%8F%E7%94%B0\">福田</a><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%BA%A2%E6%A0%91%E6%9E%97\">红树林</a>海滨<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%94%9F%E6%80%81%E5%85%AC%E5%9B%AD\">生态公园</a>，另外还有新建的12个<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B8%BB%E9%A2%98%E5%85%AC%E5%9B%AD/7536524\" data-lemmaid=\"7536524\">主题公园</a>，公园建设<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%8C%83%E5%9B%B4/33207\" data-lemmaid=\"33207\">范围</a>东起红树林海滨生态公园，西至西部口岸<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%8D%97%E6%B5%B7/27429\" data-lemmaid=\"27429\">南海</a>堤，由东至西南共分A、B、C三个区域。总设计面积为108．07公顷。地址:南山区<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%BB%A8%E6%B5%B7%E5%A4%A7%E9%81%93/3957572\" data-lemmaid=\"3957572\">滨海大道</a>(近望海路)</p><p><br></p></div><p>&nbsp;&nbsp;&nbsp; <a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%B7%B1%E5%9C%B3%E6%B9%BE\">深圳湾</a>公园位于深圳市西南部沿海，东起福田红树林鸟类自然保护区，西至深港<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%B7%A8%E6%B5%B7%E5%A4%A7%E6%A1%A5\">跨海大桥</a>西侧，北靠滨海大道，南临深圳湾，隔海遥望香港米埔自然保护区。沿<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%B5%B7%E5%B2%B8%E7%BA%BF/10975\" data-lemmaid=\"10975\">海岸线</a>长约11公里，总面积约128．74公顷，是深圳市惟一的密集滨海休闲带。深圳湾公园由已开放的红树林海滨生态公园和深圳湾滨海休闲带两部分组成。<img src=\"http://localhost:8080/travel_agency//lib/layui/images/face/46.gif\" alt=\"[互粉]\"><img src=\"http://localhost:8080/travel_agency//lib/layui/images/face/46.gif\" alt=\"[互粉]\"></p><p><br></p><p align=\"center\"><img src=\"http://localhost:8080/travel_agency//upload/aee8a5f91f384ca9b3d11cff3c31ec5a.jpg\" alt=\"aee8a5f91f384ca9b3d11cff3c31ec5a.jpg\"><br></p><p><br></p>', '2022-03-05 13:25:20', 2, '0', '    2011年8月6日开园的深圳湾公园，包括已建成开放的福田红树林海滨生态公园，另外还有新建的12个主题公园，公园建设范围东起红树林海滨生态公园，西至西部口岸南海堤，由东至西南共分A、B、C三个区域。总设计面积为108．07公顷。地址:南山区滨海大道(近望海路)');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `login_name` varchar(64) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '姓名',
  `user_name` varchar(90) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '登录用户名',
  `password` varchar(255) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '密码（MD5加密）',
  `age` int NULL DEFAULT NULL COMMENT '用户年龄',
  `sex` varchar(1) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '用户性别（0女  1男）',
  `head_img` varchar(255) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '用户头像',
  `id_card` varchar(32) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '用户身份证号',
  `birthday` date NULL DEFAULT NULL COMMENT '用户生日',
  `create_date` datetime NULL DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8  COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, '孙悟天222', 'wutian', 'e10adc3949ba59abbe56e057f20f883e', 24, '1', 'http://localhost:8080/travel_agency//upload/a9c336cd37dd4eeda954747b1f95f0f2.jpg', '140827199802280012', '1998-02-28', '2022-02-10 14:30:41');
INSERT INTO `t_user` VALUES (2, '孙悟饭123', 'wufan', '4297f44b13955235245b2497399d7a93', 22, '1', 'http://localhost:8080/travel_agency//upload/52de084e2ceb43b4bccb78679937c94e.jpg', '320724199903195713', '1999-03-19', '2022-03-02 16:28:47');

-- ----------------------------
-- Table structure for t_visit
-- ----------------------------
DROP TABLE IF EXISTS `t_visit`;
CREATE TABLE `t_visit`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int NULL DEFAULT NULL COMMENT '对应用户ID',
  `strategy_id` int NULL DEFAULT NULL COMMENT '对应攻略ID',
  `create_date` datetime NULL DEFAULT NULL COMMENT '浏览时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8  COMMENT = '用户浏览记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_visit
-- ----------------------------
INSERT INTO `t_visit` VALUES (6, 2, 1, '2022-03-03 18:23:24');
INSERT INTO `t_visit` VALUES (7, 2, 1, '2022-03-03 18:24:03');
INSERT INTO `t_visit` VALUES (8, 2, 1, '2022-03-03 18:24:25');
INSERT INTO `t_visit` VALUES (9, 2, 1, '2022-03-03 18:25:07');
INSERT INTO `t_visit` VALUES (10, 2, 1, '2022-03-03 18:27:42');
INSERT INTO `t_visit` VALUES (11, 2, 1, '2022-03-03 18:28:40');
INSERT INTO `t_visit` VALUES (12, 2, 1, '2022-03-03 18:30:04');
INSERT INTO `t_visit` VALUES (13, 2, 1, '2022-03-03 18:31:02');
INSERT INTO `t_visit` VALUES (14, 2, 1, '2022-03-03 20:12:29');
INSERT INTO `t_visit` VALUES (16, 2, 1, '2022-03-04 09:59:15');
INSERT INTO `t_visit` VALUES (17, 2, 1, '2022-03-04 10:49:47');
INSERT INTO `t_visit` VALUES (18, 2, 3, '2022-03-05 13:27:10');
INSERT INTO `t_visit` VALUES (19, 2, 3, '2022-03-05 15:30:23');
INSERT INTO `t_visit` VALUES (20, 2, 1, '2022-03-05 17:19:04');
INSERT INTO `t_visit` VALUES (21, 2, 1, '2022-03-05 17:21:23');
INSERT INTO `t_visit` VALUES (22, 2, 1, '2022-03-05 17:26:33');
INSERT INTO `t_visit` VALUES (23, 2, 1, '2022-03-05 17:27:17');
INSERT INTO `t_visit` VALUES (24, 2, 1, '2022-03-05 17:28:28');
INSERT INTO `t_visit` VALUES (25, 2, 1, '2022-03-05 17:29:15');
INSERT INTO `t_visit` VALUES (26, 2, 3, '2022-03-05 18:35:00');
INSERT INTO `t_visit` VALUES (27, 2, 3, '2022-03-05 18:35:47');
INSERT INTO `t_visit` VALUES (28, 2, 3, '2022-03-05 18:36:04');
INSERT INTO `t_visit` VALUES (29, 1, 3, '2022-03-05 18:43:57');
INSERT INTO `t_visit` VALUES (30, 1, 3, '2022-03-05 18:47:48');
INSERT INTO `t_visit` VALUES (31, 1, 3, '2022-03-05 18:48:15');
INSERT INTO `t_visit` VALUES (32, 1, 3, '2022-03-05 18:49:06');
INSERT INTO `t_visit` VALUES (33, 1, 3, '2022-03-05 19:08:33');

SET FOREIGN_KEY_CHECKS = 1;
