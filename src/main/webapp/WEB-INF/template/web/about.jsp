<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="priv.project.util.ServletUtils" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit"/>
<meta name="force-rendering" content="webkit"/>
<title>一旅阳光网</title>
<link type="text/css" rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_css/style.css" />
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/web_js/banner.js"></script>
</head>

<body>

<!-- 引入公共的头部导航条 -->
<%@include file="header.jsp"%>

<div class="clear"></div>

<!-- 引入公共的轮播图部分 -->
<%@include file="banner.jsp"%>

<div class="clear"></div>
<div class="mabody">
<div class="mainWarp">
  <div class="mainLeft">
    <div class="typebox">
      <div class="titbox">
        <h3 class="ccsl">景区景点</h3>
        <hr />
        <p class="ccsl">product center</p>
      </div>
      <ul>
        <li><a href="piclist.jsp" class="ccsl">巴厘岛</a></li>
        <li><a href="piclist.jsp" class="ccsl">马尔代夫</a></li>
        <li><a href="piclist.jsp" class="ccsl">迪拜</a></li>
        <li><a href="piclist.jsp" class="ccsl">香港</a></li>
        <li><a href="piclist.jsp" class="ccsl">旧金山</a></li>
        <li><a href="piclist.jsp" class="ccsl">云南</a></li>
      </ul>
    </div>
    <div class="newsbox">
      <div class="titbox">
        <p class="ccsl">最新资讯 </p>
        <a href="list.jsp">更多>> </a>
      </div>
      <ul>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
      </ul>
    </div>
    <div class="newsbox">
      <div class="titbox">
        <p class="ccsl">联系我们 </p>
        <a href="about.jsp">更多>> </a>
      </div>
      <div class="lxwmbox">
        <div>湖南省长沙地区<br />XXX10（马）<br />lvyou***@qq.com</div>
      </div>
    </div>
  </div>
  <div class="mainRight">
    <div class="brandnavbox">
       <p class="ccsl">关于我们</p>
       <div class="con ccsl">首页 > 关于我们 ></div>
    </div>
    <div class="detailbox">
      <div class="xq">
        <div class="con">
          <p>近年来我国开始流行生态旅游。生态旅游是由国际自然保护联盟于1983年首次提出。这一概念包括两个要点，第一是生态旅游的物件是自然景物;第二是生态旅游的物件不应受到损害。1993年国际生态旅游协会把生态旅游定义为:具有保护自然环境和维护当地人民生活双重责任的旅游活动。生态旅游的内涵更强调的是对自然景观的保护，是可持续发展的旅游。</p>
          <p>生态旅游的特征有:</p>
          <p>首先，生态旅游的目的地是一些保护完整的自然和文化生态系统，参与者能够获得与众不同的经历，这种经历具有原始性、独特性的特点。</p>
          <p>其次，生态旅游强调旅游规模的小型化，限定在承受能力范围之内，这样有利于游人的观光质量，又不会对旅游环境造成大的破坏。</p>
          <p>再次，生态旅游可以让旅游者亲自参与其中，在实际体验中领略生态旅游的奥秘，从而更加热爱自然，这也有利于自然与文化资源的保护。</p>
          <p>最后，生态旅游是一种负责任的旅游，这些责任包括对旅游资源的保护，对旅游的可持续发展的责任等。由于生态旅游自身的这些特征能满足旅游需求和旅游供给的需要，所以，当今的生态旅游方兴未艾。</p>
          <p>发达国家如何开展生态旅游?</p>
          <p>在西方发达国家，周末和节假日到大自然去旅游已成为一种时尚。很多发达国家在生态旅游活动中极为重视保护旅游物件。在生态旅游开发中，避免大兴土木等有损自然景观的做法，旅游交通以步行为主，旅游接待设施小巧，住宿多为帐篷露营，尽一切可能将旅游对旅游物件的影响降至最低。在生态旅游管理中，提出了"留下的只有脚印，带走的只有照片"等保护环境的响亮口号，并在生态旅游目的地设置一些解释大自然奥秘和保护与人类息息相关的大自然标牌及喜闻乐见的旅游活动，让游客在愉悦中增强环境意识，使生态旅游区成为提高人们环境意识的天然大课堂。</p>
          <p>过去，那些旅游者喜欢到热带海滨去休闲度假，热带海滨特有的温暖的阳光(Sun)，碧蓝的大海(Sea)和舒适的沙滩(Sand)，使居住于污染严重、竞争激烈的西方发达国家游客的身心得到平静，"3S"作为最具吸引力旅游目的地成为人们所向往的地方。随着生态旅游的开展，游客环境意识的增加，西方游客的旅游热点正从"3S"转向"3N"，即到大"自然(Nature)"中，去缅怀人类曾经与自然和谐相处的"怀旧(Nostalgia)"情结，使自己在融入自然中进入"天堂(Nirvana)"最高精神，更强调的是对自然景观的保护，是可持续发展的旅游。</p>
          <p>发展中国家如何开始生态旅游?</p>
          <p>生态旅游并不象人们一般意义上认为的开始于发达国家，它最初是在发展中国家开展的，其中生态旅游开展得最好的国家是肯尼亚，哥斯达黎加等。尽管生态旅游这个词语如今被非常广泛地使用，但对于"生态旅游"的概念，现今学术界也还存在着一些争论。不过，不管是发展中国家还是发达国家，对于生态旅游较为统一的认识是:生态旅游是区别于以往的大众旅游的一种非大众旅游形式。 首先，在对于资源的利用方面看，在生态旅游开展较好的国家，强调对自然资源的保护，对于具有显著性的景观资源和动植物资源，更强调在保护的前提下进行旅游开发。其次，从规划建设角度来看，开展生态旅游较好的国家已经开始逐步建立 ros(recreational opportunity spactum娱乐机会谱系)，并开始使用诸如lac(可接受容量限制)，verp(游客经历保护)等措施来实施生态旅游地的管理工作，如美国的国家公园河道实施以上这几种管理体系以来，已经得到了比较明显的管理效果，并在其他一些地区进行示范推广。再次，另一个生态旅游区别于大众旅游的重要方面就是，强调对旅游者的教育，及公众参与，社区受益。对于社区受益还都处在进一步的探索阶段。我国现阶段对于生态旅游的认识上，存在有将"生态旅游"概念泛化的趋势，认为凡是到自然界进行游览的行为都被冠以"生态旅游"的概念，凡是具有显著自然景观及资源的旅游地都试图冠以"生态旅游区"的名称。这与国际上对于"生态旅游"的认识还存在一定的出入。</p>
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
</div>
<div class="clear"></div>
<div class="footer">
  <div class="main">
    <div class="ewm">
      <img src="<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_img/5.jpg" width="140" height="140"/>
    </div>
    <div class="footerR">
      <div class="fnav">
        <a href="index.jsp">首页</a>
        <a href="about.jsp">关于我们</a>
        <a href="piclist.jsp">景区景点</a>
        <a href="list.jsp">景区动态</a>
        <a href="piclist.jsp">景区项目</a>
        <a href="list.jsp">行业动态</a>
        <a href="contact.jsp">联系我们</a>
      </div>
      <div class="fcon">
        <div>创意景区景点模板公司  地址：湖南省长沙地区<br />联系人：马经理  电话：000-000-0000  邮箱：lvyou***@qq.com  QQ：XXX</div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
</body>
</html>                      
