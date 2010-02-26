<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Upload.aspx.cs" Inherits="DioWeb.Secure.Upload" Title="DioWeb :: Upload" %>

<%@ Register Assembly="FileUploadLibrary" Namespace="darrenjohnstone.net.FileUpload"
    TagPrefix="cc1" %>
<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <cc1:DJUploadController ID="DJUploadController" runat="server" ShowCancelButton="false"
        ScriptPath="../FileUploadControl/Scripts" ImagePath="../FileUploadControl/Images"
        CSSPath="../FileUploadControl/Styles" />
    <h3 class="title">
        <asp:Image ID="imgUpload" runat="server" ImageUrl="~/Images/Icons/upload.png" ImageAlign="AbsMiddle" />
        File Upload
    </h3>
    <div>
        <cc1:DJAccessibleProgressBar ID="DJAccessibleProgrssBar" runat="server" />
        <cc1:DJFileUpload ID="DJFileUploadDioWeb" runat="server" ShowAddButton="true" RequiredField="true" />
        <br />
        <asp:ImageButton ID="btnUploadFiles" runat="server" ImageUrl="~/Images/Buttons/upload.png" />
    </div>
    <br />
    <div>
        <asp:Literal runat="server" ID="litResults">
        </asp:Literal>
    </div>
</asp:Content>
