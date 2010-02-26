<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadProgress.aspx.cs"
    Inherits="DioWeb.Secure.UploadProgress" %>

<%@ Register Assembly="FileUploadLibrary" Namespace="darrenjohnstone.net.FileUpload"
    TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DioWeb :: Upload Progress</title>
    <meta http-equiv="refresh" content="5">
    <style type="text/css">
        .upProgressContainer
        {
            padding-top: 5px;
            padding-bottom: 5px;
        }
        .upOuterBar
        {
            width: 570px;
            height: 32px;
            border: solid 1px #8a8a8a;
            background-color: transparent;
            overflow: hidden;
        }
        .upInnerBar
        {
            width: 0;
            height: 32px;
            background-color: #cccccc;
            position: relative;
        }
        .upLabel
        {
            width: 100%;
            background-color: transparent;
            color: #000000;
            text-align: center;
            z-index: 9999;
            position: relative;
            top: -32px;
            font-family: Arial;
            font-size: 9pt;
            font-weight: bold;
        }
    </style>
    <base target="_blank" />
</head>
<body>
    <form id="formUploadProgress" runat="server" target="_blank">
    <div class="upProgressContainer">
        <div class="upOuterBar">
            <asp:Panel runat="server" ID="upProgressBar" CssClass="upInnerBar">
            </asp:Panel>
            <div id="upLabel" class="upLabel">
                <asp:Label runat="server" ID="lblStatus" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
