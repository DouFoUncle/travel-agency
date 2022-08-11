package priv.project.controller.web;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import priv.project.service.NoticeService;


/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端消息通知控制器
 */
@RestController
@RequestMapping("/web/notice")
@AllArgsConstructor
public class WebNoticeController {

    private NoticeService noticeService;

}
