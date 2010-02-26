<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Settings.aspx.cs" Inherits="DioWeb.Secure.Settings" Title="DioWeb :: Settings" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <h3 class="title">
        <asp:Image ID="imgSettings" runat="server" ImageUrl="~/Images/Icons/settings.png"
            ImageAlign="AbsMiddle" />
        Settings
    </h3>
    <div>
        <asp:Label ID="lblPageSize" runat="server" Text="Number of files"></asp:Label>
        <asp:TextBox ID="txtPageSize" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="txtPageSizeRequiredFieldValidator" runat="server"
            ControlToValidate="txtPageSize">*</asp:RequiredFieldValidator>
        <br />
        <span class="hint">Limit the number of files to retrieve from your account</span>
        <br />
        <asp:CompareValidator ID="txtPageSizeCompareValidator" runat="server" ErrorMessage="Invalid page size value."
            ControlToValidate="txtPageSize" Type="Integer" Operator="GreaterThan" ValueToCompare="0"></asp:CompareValidator>
    </div>
    <br />
    <div>
        <asp:Label ID="lblOffset" runat="server" Text="Starting from"></asp:Label>
        <asp:TextBox ID="txtOffset" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="txtOffsetRequiredFieldValidator" runat="server" ControlToValidate="txtOffset">*</asp:RequiredFieldValidator>
        <br />
        <span class="hint">Return files beginning at the given offset</span>
        <br />
        <asp:CompareValidator ID="txtOffsetCompareValidator" runat="server" ErrorMessage="Invalid offset value."
            ControlToValidate="txtOffset" Type="Integer" Operator="GreaterThanEqual" ValueToCompare="0"></asp:CompareValidator>
    </div>
    <br />
    <div>
        <asp:ImageButton ID="btnSaveSettings" runat="server" AlternateText="Save" ToolTip="Save settings"
            ImageUrl="~/Images/Buttons/save.png" OnClick="btnSaveSettings_Click" />
    </div>
</asp:Content>
