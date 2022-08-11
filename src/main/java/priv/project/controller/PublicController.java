package priv.project.controller;


import cn.hutool.core.lang.UUID;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import priv.project.pojo.ResultMessage;
import priv.project.util.ServletUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 一些公共的控制器
 */
@Controller
@RequestMapping("/public")
public class PublicController {

    /**
     * 富文本上传文件
     * @return
     */
    @RequestMapping("/uploadImages")
    @ResponseBody
    public ResultMessage toUploadImagesOverride(@RequestParam("file") MultipartFile file,
                                       HttpServletRequest request) {
        // 设置文件存放路径
        String path = request.getSession().getServletContext().getRealPath("/upload/");
        System.out.println("=============path==============：" + path);
        try {
            // 判断文件是否为空
            System.out.println(file.getSize());
            if (file.isEmpty() || file.getSize() <= 0) {
                return new ResultMessage(207, "上传文件为空！");
            }
            // 获取上传文件的名字
            String fileName = file.getOriginalFilename();
            String fileType = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString().replace("-", "");
            // 创建文件
            File dest = new File(path + newFileName + fileType);
            // 检测目录是否存在
            if (!dest.getParentFile().exists()) {
                // 不存在就创建
                dest.getParentFile().mkdir();
            }
            // 文件写入
            file.transferTo(dest);
            // 写入成功返回数据
            Map<String, Object> dataMap = new HashMap<>(16);
            dataMap.put("src", ServletUtils.getProjectHttpUrl(request) + "/upload/" + newFileName + fileType);
            dataMap.put("title", newFileName + fileType);
            return new ResultMessage(0, "上传成功！", dataMap);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "出现异常：" + e.getMessage());
        }
    }
}
