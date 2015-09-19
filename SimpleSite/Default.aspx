<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SimpleSite._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server"></title>
    <link rel="icon" type="image/png" href="images/favicon.png" />
    <link href="CSS/Blissgig.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div class="bgBody">
	<div class="Titlebar" >
		<img class="IconTitle" src="images/logo.png" id="articleIcon" runat="server" />
		<div class="ArticleTitle" id="articleTitle" runat="server" />
		<div class="ArticleDate" id="articleDate" runat="server" />
	</div>
	<div class="ArticleBody" id="articleBody" runat="server"/>
	<div class="Articles" id="articles" runat="server"/>
</div>
</body>
</html>
