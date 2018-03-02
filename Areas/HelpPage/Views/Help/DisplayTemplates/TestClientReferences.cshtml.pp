﻿@using System.Text.RegularExpressions
<link href="~/Content/themes/base/jquery.ui.all.css" rel="stylesheet" />
<link href="~/Areas/HelpPage/TestClient.css" rel="stylesheet" />
<link type="text/css" href="~/Areas/HelpPage/HelpPage.css" rel="stylesheet" />
@* Automatically grabs the installed version of JQuery/JQueryUI/KnockoutJS *@
@{var filePattern = @"(jquery-[0-9]+.[0-9]+.[0-9]+.js|jquery-ui-[0-9]+.[0-9]+.[0-9]+.js|knockout-[0-9]+.[0-9]+.[0-9]+.js)";}
@foreach (var item in Directory.GetFiles(Server.MapPath(@"~/Scripts")).Where(f => Regex.IsMatch(f, filePattern)))
{
    <script src="~/Scripts/@Path.GetFileName(item)"></script>
}
<script src="~/Scripts/WebApiTestClient.js" defer="defer"></script>