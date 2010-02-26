<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.ascx.cs" Inherits="DioWeb.UserControls.UserInfo" %>
<%@ Register Src="Confirmation.ascx" TagName="Confirmation" TagPrefix="dio" %>
<asp:ListView ID="lvUserInfo" runat="server" DataSourceID="odsUserInfo" OnItemUpdating="lvUserInfo_ItemUpdating">
    <LayoutTemplate>
        <table id="itemPlaceholderContainer" runat="server" border="0" rules="none">
            <tr id="itemPlaceholder" runat="server">
            </tr>
        </table>
    </LayoutTemplate>
    <ItemTemplate>
        <tr>
            <td align="right">
                Account type:
            </td>
            <td align="left">
                <asp:Label ID="lblAccountType" runat="server" Text='<%# Eval("accountType") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                First name:
            </td>
            <td align="left">
                <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("firstName") != string.Empty ? Eval("firstName") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Last name:
            </td>
            <td align="left">
                <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("lastName") != string.Empty ? Eval("lastName") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Company name:
            </td>
            <td align="left">
                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("companyName") != string.Empty ? Eval("companyName") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Web site URL:
            </td>
            <td align="left">
                <asp:Label ID="lblWebsiteUrl" runat="server" Text='<%# Eval("websiteUrl") != string.Empty ? Eval("websiteUrl") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Phone:
            </td>
            <td align="left">
                <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("phone") != string.Empty ? Eval("phone") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Created date:
            </td>
            <td align="left">
                <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") %>' />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td align="left">
                <asp:ImageButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Edit user information"
                    AlternateText="Edit" ImageUrl="~/Images/Icons/edit.png" />
                <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete user information"
                    AlternateText="Delete" ImageUrl="~/Images/Icons/delete.png" />
            </td>
            <td>
                <dio:Confirmation ID="ucDeleteUserInfoConfirmation" runat="server" TargetControlID="btnDelete"
                    ConfirmText="Are you sure you want to delete all user information?" />
            </td>
        </tr>
        <%--          
            <asp:Label ID="minMonthlyFeeLabel" runat="server" Text='<%# Eval("minMonthlyFee") %>' />
            <asp:Label ID="monthlySupportFeeLabel" runat="server" Text='<%# Eval("monthlySupportFee") %>' />
            <asp:Label ID="paymentMethodLabel" runat="server" Text='<%# Eval("paymentMethod") %>' />
            <asp:Label ID="paymentDateLabel" runat="server" Text='<%# Eval("paymentDate") %>' />
            --%>
    </ItemTemplate>
    <EditItemTemplate>
        <tr>
            <td align="right">
                Account type:
            </td>
            <td align="left">
                <asp:Label ID="lblAccountType" runat="server" Text='<%# Eval("accountType") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                First name:
            </td>
            <td align="left">
                <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Eval("firstName") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Last name:
            </td>
            <td align="left">
                <asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("lastName") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Company name:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Eval("companyName") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Web site URL:
            </td>
            <td align="left">
                <asp:TextBox ID="txtWebsiteUrl" runat="server" Text='<%# Eval("websiteUrl") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Phone:
            </td>
            <td align="left">
                <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("phone") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Created date:
            </td>
            <td align="left">
                <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") %>' />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td align="left">
                <asp:ImageButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Update"
                    AlternateText="Update" ImageUrl="~/Images/Icons/check.png" />
                <asp:ImageButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Cancel"
                    AlternateText="Cancel" ImageUrl="~/Images/Icons/cancel.png" />
            </td>
        </tr>
        <%--          
            <asp:Label ID="minMonthlyFeeLabel" runat="server" Text='<%# Eval("minMonthlyFee") %>' />
            <asp:Label ID="monthlySupportFeeLabel" runat="server" Text='<%# Eval("monthlySupportFee") %>' />
            <asp:Label ID="paymentMethodLabel" runat="server" Text='<%# Eval("paymentMethod") %>' />
            <asp:Label ID="paymentDateLabel" runat="server" Text='<%# Eval("paymentDate") %>' />
            --%>
    </EditItemTemplate>
    <EmptyDataTemplate>
        <table>
            <tr>
                <td>
                    No data was returned.
                </td>
            </tr>
        </table>
    </EmptyDataTemplate>
</asp:ListView>
<asp:ObjectDataSource ID="odsUserInfo" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
    SelectMethod="GetUserInfo" OnSelecting="odsUserInfo_Selecting" UpdateMethod="SetUserInfo"
    OnUpdating="odsUserInfo_Updating" DeleteMethod="DeleteUserInfo" OnDeleting="odsUserInfo_Deleting"
    OnDeleted="odsUserInfo_Deleted" OnSelected="odsUserInfo_Selected" OnUpdated="odsUserInfo_Updated">
    <DeleteParameters>
        <asp:Parameter Name="sessionToken" Type="String" />
        <asp:Parameter Name="userInfoType" Type="Object" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="sessionToken" Type="String" />
        <asp:Parameter Name="userInfo" Type="Object" />
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="sessionToken" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
