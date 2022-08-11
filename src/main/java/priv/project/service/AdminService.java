package priv.project.service;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.AdminMapper;
import priv.project.pojo.Admin;

import java.util.List;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 管理员表业务层
 */
@Service
@AllArgsConstructor
public class AdminService extends ServiceImpl<AdminMapper, Admin> {

    private AdminMapper adminMapper;

    /**
     * 验证登录
     * @param admin
     * @return
     */
    public Admin getInfoByLogin(Admin admin) {
        // 加密密码
        String newPwd = SecureUtil.md5(admin.getPassword());
        // 构建查询条件
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("password", newPwd);
        queryWrapper.eq("user_name", admin.getUserName());
        // 调用查询方法
        return adminMapper.selectOne(queryWrapper);
    }

    /**
     * 分页查询数据
     * @param page
     * @param limit
     * @param admin
     * @return
     */
    public IPage<Admin> getPageList(Integer page, Integer limit, Admin admin) {
        // 构建查询对象
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<Admin>();
        queryWrapper.like(!StrUtil.isBlankOrUndefined(admin.getLoginName()), "login_name", admin.getLoginName());
        queryWrapper.like(!StrUtil.isBlankOrUndefined(admin.getUserName()), "user_name", admin.getUserName());
        queryWrapper.orderByDesc("create_date");
        // 创建分页对象
        IPage<Admin> pageBean = new Page<Admin>(page, limit);
        // 调用查询方法
        return adminMapper.selectPage(pageBean, queryWrapper);
    }

    /**
     * 删除多条或单条
     * @param ids
     * @return
     */
    public boolean deleteInfo(String ids) {
        List<String> idList = StrUtil.split(ids, ',', true, true);
        return this.removeByIds(idList);
    }

    /**
     * 修改管理员信息
     * @param selectResult
     * @return
     */
    public Integer updateInfo(Admin selectResult) {
        // 调用更新方法
        return adminMapper.updateById(selectResult);
    }
}
