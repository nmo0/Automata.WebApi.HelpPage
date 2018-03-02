@using System.Web.Http
@using System.Web.Http.Controllers
@using System.Web.Http.Description
@using System.Collections.ObjectModel
@using $rootnamespace$.Areas.HelpPage.Models
@using System.Web.Http.Controllers
@using System.Web.Http.Description
@using Automata.WebApi.HelpPage
@model Collection<ApiDescription>

@{
    ViewBag.Title = "Niohome Business2.0 Apis";

    // Group APIs by controller
    ILookup<HttpControllerDescriptor, ApiDescription> apiGroups = Model.OrderBy(m =>
    {
        var attribute = m.ActionDescriptor.ControllerDescriptor.ControllerType.GetCustomAttributes(true);

        var order = 99999;

        foreach (var item in attribute)
        {
            if (item is ApiDisplayAttribute)
            {
                var attr = ((ApiDisplayAttribute)item);
                order = attr.Order;

                //标新的要置顶
                if (attr.IsNew)
                {
                    order = 0;
                }
            }
        }

        return order;
    }).ToList().ToLookup(api => api.ActionDescriptor.ControllerDescriptor);
}
<style>
    .btn-title{    
        border-bottom: 1px solid #DDDDDD;
        border-left: 20px solid #CCCCCC;
        margin: 0px 0px 3px 0px;
        padding: 10px 0px 10px 10px;
    }
    .btn-title:hover{    
        border-bottom: 1px solid #00c14b;
        border-left: 20px solid #00c14b;
    }

    .high-light{
        color: red;
        font-weight: 800;
        font-size: 150%;
        /*display:inline-block;
        width: 125px;*/
    }

    .high-light.blue{
        color:blue;
    }
</style>
<link type="text/css" href="~/Areas/HelpPage/HelpPage.css" rel="stylesheet" />
<header class="help-page">
    <div class="content-wrapper">
        <div class="float-left">
            <h1>@ViewBag.Title</h1>
        </div>
    </div>
</header>
<div id="body" class="help-page">
    <section class="featured">
        <div class="content-wrapper">
            <h2>Introduction</h2>
            <p>
                Niohome Biz1.0提供了工作流所需的业务数据接口。
            </p>
            <p>
                注意：api编号是通过计算接口URL的ASCII编码值的总和得出的。
            </p>
        </div>
    </section>
    <section class="content-wrapper main-content clear-fix">
        @foreach (var group in apiGroups)
        {
            @Html.DisplayFor(m => group, "ApiGroup")
        }
    </section>
</div>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script>
    (function () {
        var titles = document.querySelectorAll('.btn-title');
        for (var i = 0; i < titles.length; i++) {
            var title = titles[i];
            (function (t) {
                t.onclick = function () {
                    //console.log(t);//
                    var next = t.nextElementSibling;
                    if (next.style.display === 'none') {
                        next.style.display = 'block';
                        this.querySelector('span').innerHTML = '-'
                    } else {
                        next.style.display = 'none';
                        this.querySelector('span').innerHTML = '+'
                    }
                }
            })(title);
        }

        //获取url中的参数
        var getUrlParam = function(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return unescape(r[2]); return null; //返回参数值
        }

        var key = getUrlParam('key');
        if (key) {
            var keys = key.split(',');
            $('p.btn-title').hide();
            for (var i = 0; i < keys.length; i++) {
                var item = keys[i];
                //$('tr[data-controller]').hide();

                $('.help-page-table').each(function () {
                    if ($(this).find('tr[data-controller="' + item + '"]').length > 0) {
                        $(this).prev('p.btn-title').show();
                        $(this).show();
                    }
                });
            }
        }

        $('.btn-title').each(function () {
            var text = $(this).html();
            if (/(#\w+#){1}/.test(text)) {
                $(this).html(text.replace(/(#\w+#){1}/g, '<span class="high-light">$1</span>'));
            }else if (/(@@\w+@@){1}/.test(text)) {
                $(this).html(text.replace(/(@@\w+@@){1}/g, '<span class="high-light blue">$1</span>'));
            } else {
                $(this).find('span').after('<span class="high-light"></span>');
            }
        });
    })();
</script>
