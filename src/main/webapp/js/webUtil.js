function checkLogin(user) {
    if(!user || user == 'null' || user == '') {
        layer.msg('请先登录！', {
            shade: .3
            , icon: 5
            , time: 1800
        });
        return false;
    } else {
        return true
    }
}