@using System.Web.Http
@using System.Web.Http.Controllers
@using System.Web.Http.Description
@using $rootnamespace$.Areas.HelpPage
@using $rootnamespace$.Areas.HelpPage.Models
@using Automata.WebApi.HelpPage
@model IGrouping<HttpControllerDescriptor, ApiDescription>

@{
    var controllerDocumentation = ViewBag.DocumentationProvider != null ?
        ViewBag.DocumentationProvider.GetDocumentation(Model.Key) :
        null;

    var controller = Model.First();

    var hasNew = false;
    var hasHot = false;

    Action isNew = () =>
    {
        var attribute = controller.ActionDescriptor.ControllerDescriptor.ControllerType.GetCustomAttributes(true);

        foreach (var item in attribute)
        {
            if (item is ApiDisplayAttribute)
            {
                hasNew = ((ApiDisplayAttribute)item).IsNew;
                hasHot = ((ApiDisplayAttribute)item).IsHot;
            }
        }
    };

    isNew();

    var iconStr = "";
    var newStr = "<img src='/Content/images/5-120601152050-51.gif'/>";
    var hotStr = "<img src='/Content/images/5-120601154100.gif'/>";
    if (hasNew)
    {
        iconStr += newStr;
    }
    if (hasHot)
    {
        iconStr += hotStr;
    }
}

@*<h2 id="@Model.Key.ControllerName">@Model.Key.ControllerName</h2>*@
@if (!String.IsNullOrEmpty(controllerDocumentation))
{
    <p class="btn-title"><span>+</span> @controllerDocumentation @Html.Raw(iconStr)</p>
}
else
{
    <p class="btn-title">
        <span>+</span> @controller.ActionDescriptor.ControllerDescriptor.ControllerName @Html.Raw(iconStr)</p>
}
<table class="help-page-table" style="display:none;">
    @*<thead>
        <tr><th>API</th><th>Description</th></tr>
    </thead>*@
    <tbody>
    @{
        var apiCode = new Dictionary<string, string>();
    }
    @foreach (var api in Model)
    {
        <tr data-controller="@api.ActionDescriptor.ControllerDescriptor.ControllerName">
        @{
            var idArray = api.ID.ToLower().ToCharArray().Select(m => (int)m).ToArray();

            var regexResult = System.Text.RegularExpressions.Regex.Matches(api.ActionDescriptor.ControllerDescriptor.ControllerName, "[A-Z]");
            var prefix = string.Empty;
            var count = 0;
            foreach (System.Text.RegularExpressions.Match item in regexResult)
            {
                if (count < 2)
                {
                    prefix += item.Value;
                }
                count++;
            }

            var id = "WF-" + prefix + "-" + idArray.Sum().ToString().PadLeft(6, '0');

            if (apiCode.ContainsKey(id))
            {
                id = "WF" + prefix + "-" + (idArray.Sum() + 1).ToString().PadLeft(6, '0');
                if (apiCode.ContainsKey(id))
                {
                    //throw new Exception(api.ID + " 接口编号计算重复，请重命名接口名称");
                }
            }
            apiCode.Add(id, api.ID);


            iconStr = string.Empty;

            var attribute = api.ActionDescriptor.GetCustomAttributes<object>(true);

            foreach (var item in attribute)
            {
                if (item is ApiDisplayAttribute)
                {
                    hasNew = ((ApiDisplayAttribute)item).IsNew;
                    if (hasNew)
                    {
                        iconStr += newStr;
                    }
                    hasNew = ((ApiDisplayAttribute)item).IsHot;
                    if (hasNew)
                    {
                        iconStr += hotStr;
                    }
                }
            }
        }
            <td class="api-no">api code <span class="api-id">@id</span></td>
            <td class="api-name"><a href="@Url.Action("Api", "Help", new { apiId = api.GetFriendlyId() })">@api.HttpMethod.Method @api.RelativePath</a> @Html.Raw(iconStr)</td>
            <td class="api-documentation">
            @if (api.Documentation != null)
            {
                <p>@Html.Raw(api.Documentation.Replace("\\n", "<br/>").Replace("[", "<").Replace("]", ">"))</p>
            }
            else
            {
                <p>No documentation available.</p>
            }
            </td>
        </tr>
    }
    </tbody>
</table>