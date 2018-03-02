@using System.Collections.Generic
@using System.Collections.ObjectModel
@using System.Web.Http.Description
@using System.Threading
@using $rootnamespace$.Areas.HelpPage.ModelDescriptions
@model IList<ParameterDescription>

@if (Model.Count > 0)
{
    <table class="help-page-table">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Type</th>
                <th>Sample</th>
                <th>Additional information</th>
            </tr>
        </thead>
        <tbody>
            @foreach (ParameterDescription parameter in Model)
            {
                ModelDescription modelDescription = parameter.TypeDescription;
                <tr class="@(parameter.Obsolete ? "through" : "")">
                    <td class="parameter-name">@parameter.Name</td>
                    <td class="parameter-documentation">
                        @if (!String.IsNullOrEmpty(parameter.Documentation))
                        {
                         <p>@Html.Raw(parameter.Documentation.Replace("\\n", "<br/>").Replace("[", "<").Replace("]", ">"))</p>
                        }
                    </td>
                    <td class="parameter-type">
                      @Html.DisplayFor(m => modelDescription.ModelType, "ModelDescriptionLink", new { modelDescription = modelDescription })
                    </td>
                    <td class="parameter-sample">@parameter.Sample</td>
                    <td class="parameter-annotations">
                        @if (parameter.Annotations.Count > 0)
                        {
                            foreach (var annotation in parameter.Annotations)
                            {
                                <p>@annotation.Documentation</p>
                            }
                        }
                        else
                        {
                            <p>None.</p>
                        }
                    </td>
                </tr>
            }
        </tbody>
    </table>
}
else
{
    <p>None.</p>
}

