layui.use(['layer'], function() {

    var layer = layui.layer;

    // 响应上一页按钮
    $("#prev").click(function() {
        let current = parseInt($(this).attr("data-current"));
        let pages = parseInt($(this).attr("data-pages"));
        if(current == 1) {
            layer.msg("已经是第一页啦!!", {
                offset: 't',
                icon: '5',
                shade: .2,
                time: 1500
            });
            return;
        }
        let hrefPath = window.location.href;
        if(hrefPath.indexOf("page=") > 0) {
            hrefPath = hrefPath.replace("page="+current, "page=" + parseInt(current - 1));
            window.location.href = hrefPath;
        } else {
            if(hrefPath.indexOf("?") > 0) {
                hrefPath += "&page=" + parseInt(current - 1);
                window.location.href = hrefPath;
            } else {
                hrefPath += "?page=" + parseInt(current - 1);
                window.location.href = hrefPath;
            }
        }
    })

    // 响应下一页按钮
    $("#next").click(function() {
        let current = parseInt($(this).attr("data-current"));
        let pages = parseInt($(this).attr("data-pages"));
        if(current == pages) {
            layer.msg("已经是最后一页啦!!", {
                offset: 't',
                icon: '5',
                shade: .2,
                time: 1500
            });
            return;
        }
        let hrefPath = window.location.href;
        if(hrefPath.indexOf("page=") > 0) {
            hrefPath = hrefPath.replace("page=" + current, "page=" + parseInt(current + 1));
            window.location.href = hrefPath;
        } else {
            if(hrefPath.indexOf("?") > 0) {
                hrefPath += "&page=" + parseInt(current + 1);
                window.location.href = hrefPath;
            } else {
                hrefPath += "?page=" + parseInt(current + 1);
                window.location.href = hrefPath;
            }
        }
    })

    // 响应页码按钮
    $(".pageBtn").click(function() {
        let current = parseInt($(this).attr("data-current"));
        let num = parseInt($(this).attr("data-num"));
        if(current == num) {
            return;
        }
        let hrefPath = window.location.href;
        if(hrefPath.indexOf("page=") > 0) {
            hrefPath = hrefPath.replace("page=" + current, "page=" + num);
            window.location.href = hrefPath;
        } else {
            if(hrefPath.indexOf("?") > 0) {
                hrefPath += "&page=" + num;
                window.location.href = hrefPath;
            } else {
                hrefPath += "?page=" + num;
                window.location.href = hrefPath;
            }
        }
    })
})