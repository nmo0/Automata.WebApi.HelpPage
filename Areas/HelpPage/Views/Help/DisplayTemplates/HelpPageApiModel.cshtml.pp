@using System.Web.Http
@using System.Web.Http.Description
@using $rootnamespace$.Areas.HelpPage.Models
@using $rootnamespace$.Areas.HelpPage.ModelDescriptions
@model HelpPageApiModel

@{
    ApiDescription description = Model.ApiDescription;
}
<style>
</style>
<h1>@description.HttpMethod.Method @description.RelativePath</h1>
<div>
	@if(description.Documentation != null){
		<p>@Html.Raw(@description.Documentation.Replace("\\n", "<br/>").Replace("[", "<").Replace("]", ">"))</p>
	}

    <h2>Api Information</h2>
    <script>
        var copy = function (content) {
            //var clipBoardContent = "";
            //clipBoardContent += content;
            //window.clipboardData.setData("Text", clipBoardContent);
            var oInput = document.createElement('input');
            oInput.value = content;
            document.body.appendChild(oInput);
            oInput.select(); // 选择对象
            document.execCommand("Copy"); // 执行浏览器复制命令
            oInput.style.display = 'none';
        }
    </script>
    <table class="help-page-table">
        <thead>
            <tr>
                <th>Environment</th>
                <th>Url</th>
                <th>Copy</th>
            </tr>
        </thead>
        <tbody>
            <tr class="important">
                <td>Test</td>
                <td>{your Test environment site}/@description.RelativePath</td>
                <th><a href="javascript:copy('{your Test environment site}/@description.RelativePath')">Click To Copy</a></th>
            </tr>
            <tr class="important">
                <td>UAT</td>
                <td>{your UAT environment site}/@description.RelativePath</td>
                <th><a href="javascript:copy('{your UAT environment site}/@description.RelativePath')">Click To Copy</a></th>
            </tr>
            <tr class="important">
                <td>PRO</td>
                <td>{your PRO environment site}/@description.RelativePath</td>
                <th><a href="javascript:copy('{your PRO environment site}/@description.RelativePath')">Click To Copy</a></th>
            </tr>
        </tbody>
    </table>

    <h2>Request Information</h2>

    @*<h3>URI Parameters</h3>
        @Html.DisplayFor(m => m.UriParameters, "Parameters")*@

    <h3>Body Parameters</h3>

    <p>Model.RequestDocumentation</p>

    @if (Model.RequestBodyParameters != null)
    {
        @*@Html.DisplayFor(m => m.RequestModelDescription.ModelType, "ModelDescriptionLink", new { modelDescription = Model.RequestModelDescription })*@
        if (Model.RequestBodyParameters != null)
        {
            @Html.DisplayFor(m => m.RequestBodyParameters, "Parameters")
        }
    }
    else
    {
        <p>None.</p>
    }

    @if (Model.SampleRequests.Count > 0)
    {
        <h3>Request Formats</h3>
        @Html.DisplayFor(m => m.SampleRequests, "Samples")
    }
    
    <br/>

    <h2>Response Information</h2>

    @*<h3>Resource Description</h3>*@

    <p>@description.ResponseDescription.Documentation</p>

    @if (Model.ResourceDescription != null)
    {
        @*@Html.DisplayFor(m => m.ResourceDescription.ModelType, "ModelDescriptionLink", new { modelDescription = Model.ResourceDescription })*@
        if (Model.ResourceProperties != null)
        {
            @Html.DisplayFor(m => m.ResourceProperties, "Parameters")
        }
    }
    else
    {
        <p>None.</p>
    }

    @if (Model.SampleResponses.Count > 0)
    {
        <h3>Response Formats</h3>
        @Html.DisplayFor(m => m.SampleResponses, "Samples")
    }




</div>