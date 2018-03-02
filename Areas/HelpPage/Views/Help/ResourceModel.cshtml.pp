@using System.Web.Http
@using $rootnamespace$.Areas.HelpPage.ModelDescriptions
@model ModelDescription

<link type="text/css" href="~/Areas/HelpPage/HelpPage.css" rel="stylesheet" />
<div id="body" class="help-page">
    <section class="featured">
        <div class="content-wrapper">
            <p>
                @Html.ActionLink("Back Home", "/Index")
            </p>
        </div>
    </section>
    <h1>@Model.Name</h1>
    <p>@Model.Documentation</p>
    <section class="content-wrapper main-content clear-fix">
        @Html.DisplayFor(m => Model)
    </section>
</div>
<script src="~/Scripts/jquery-3.2.1.min.js"></script>
<script>
    (function () {
        var model = {};
        $('.help-page-table tr').each(function () {
            if ($(this).find('.parameter-name').length > 0) {
                var name = $(this).find('.parameter-name').text();
                var val = $(this).find('.parameter-sample').text();
                model[name] = val;
            }
        });

        console.log(JSON.stringify(model));
    })();
</script>