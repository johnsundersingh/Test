<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="MyDiomede.aspx.cs" Inherits="DioWeb.Secure.MyDiomede" Title="DioWeb :: Account Info" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../UserControls/UserInfo.ascx" TagName="UserInfo" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/UserCreditCard.ascx" TagName="UserCreditCard" TagPrefix="uc2" %>
<%@ Register Src="../UserControls/Confirmation.ascx" TagName="Confirmation" TagPrefix="uc3" %>
<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">

    <script type="text/javascript">
        function ActiveTabChanged(sender, e) {
            $get('<%= hfTabMyDiomede.ClientID %>').value = sender.get_activeTab().get_tabIndex();
        }
    </script>

</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <asp:HiddenField ID="hfTabMyDiomede" runat="server" />
    <cc1:TabContainer ID="tabMyDiomede" runat="server" OnClientActiveTabChanged="ActiveTabChanged">
        <cc1:TabPanel runat="server" ID="pnlUserInfo">
            <HeaderTemplate>
                User Info
            </HeaderTemplate>
            <ContentTemplate>
                <div id="userinfo">
                    <h3>
                        User Information
                    </h3>
                    <h4>
                        <asp:Image ID="imgUserInfo" runat="server" ImageUrl="~/Images/Icons/user.png" ImageAlign="AbsMiddle" />
                        User info for
                        <asp:Literal ID="litUserName" runat="server"></asp:Literal>
                    </h4>
                    <uc1:UserInfo ID="ucUserInfo" runat="server" OnServiceError="ucUserInfo_ServiceError" />
                    <h4>
                        <asp:Image ID="imgDeleteUser" runat="server" ImageUrl="~/Images/Icons/user_delete.png"
                            ImageAlign="AbsMiddle" />
                        Delete user account
                    </h4>
                    <asp:ImageButton ID="btnDeleteUser" runat="server" AlternateText="DeleteUser" ToolTip="Delete current user"
                        ImageUrl="~/Images/Buttons/delete_user.png" OnClick="btnDeleteUser_Click" />
                    <br />
                    <span class="hint">WARNING! This will delete your user account and it won't be accessible
                        anymore</span>
                    <uc3:Confirmation ID="ucDeleteUserConfirmation" runat="server" TargetControlID="btnDeleteUser"
                        ConfirmText="Are you sure you want to delete current user?" />
                </div>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel runat="server" ID="pnlPaymentInfo">
            <HeaderTemplate>
                Payment Info
            </HeaderTemplate>
            <ContentTemplate>
                <div id="paymentinfo">
                    <h3>
                        Payment Information
                    </h3>
                    <h4>
                        <asp:Image ID="imgCreditCards" runat="server" ImageUrl="~/Images/Icons/credit_cards.png"
                            ImageAlign="AbsMiddle" />
                        Payment Method
                    </h4>
                    <uc2:UserCreditCard ID="ucUserCreditCard" runat="server" OnServiceError="ucUserCreditCard_ServiceError"
                        ValidationGroup="UserCreditCard" />
                    <br />
                </div>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel runat="server" ID="pnlPassword">
            <HeaderTemplate>
                Password
            </HeaderTemplate>
            <ContentTemplate>
                <div id="changepass">
                    <h3>
                        Change Your Password
                    </h3>
                    <asp:UpdatePanel ID="upnlPassword" runat="server">
                        <ContentTemplate>
                            <table border="0" cellpadding="0">
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblCurrentPassword" runat="server" AssociatedControlID="txtCurrentPassword">Password:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="txtCurrentPasswordRequired" runat="server" ControlToValidate="txtCurrentPassword"
                                            SetFocusOnError="true" ErrorMessage="Password is required." ToolTip="Password is required."
                                            ValidationGroup="ChangePassword">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="txtNewPassword">New Password:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="txtNewPasswordRequired" runat="server" ControlToValidate="txtNewPassword"
                                            ErrorMessage="New Password is required." ToolTip="New Password is required."
                                            SetFocusOnError="true" ValidationGroup="ChangePassword">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblConfirmNewPassword" runat="server" AssociatedControlID="txtConfirmNewPassword">Confirm New Password:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="txtConfirmNewPasswordRequired" runat="server" ControlToValidate="txtConfirmNewPassword"
                                            ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required."
                                            SetFocusOnError="true" ValidationGroup="ChangePassword">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="txtNewPasswordCompare" runat="server" ControlToCompare="txtNewPassword"
                                            SetFocusOnError="true" ControlToValidate="txtConfirmNewPassword" Display="Dynamic"
                                            ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangePassword"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td>
                                    </td>
                                    <td align="left">
                                        <asp:ImageButton ID="btnChangePassword" runat="server" AlternateText="ChangePassword"
                                            ToolTip="Change Password" ValidationGroup="ChangePassword" ImageUrl="~/Images/Buttons/change_password.png"
                                            OnClick="btnChangePassword_Click" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel runat="server" ID="pnlEmails">
            <HeaderTemplate>
                Emails
            </HeaderTemplate>
            <ContentTemplate>
                <h3>
                    E-mail Manager
                </h3>
                <asp:UpdatePanel ID="upnlEmails" runat="server">
                    <ContentTemplate>
                        <asp:ListView ID="lvEmails" runat="server" DataKeyNames="Email" InsertItemPosition="FirstItem"
                            OnSelectedIndexChanging="lvEmails_SelectedIndexChanging" OnItemDeleting="lvEmails_ItemDeleting"
                            OnItemInserting="lvEmails_ItemInserting">
                            <LayoutTemplate>
                                <table id="itemPlaceholderContainer" runat="server" border="0">
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btnDefault" runat="server" CommandName="Select" ToolTip="Set email as default"
                                            AlternateText="Default" ImageUrl="~/Images/Icons/star_empty.png" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btnDeleteEmail" runat="server" CommandName="Delete" ToolTip="Delete email"
                                            AlternateText="DeleteEmail" ImageUrl="~/Images/Icons/mail_delete.png" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <SelectedItemTemplate>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                                    </td>
                                    <td>
                                        <asp:Image ID="imgDefault" runat="server" ToolTip="Default email" AlternateText="Default"
                                            ImageUrl="~/Images/Icons/star_filled.png" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btnDeleteEmail" runat="server" CommandName="Delete" ToolTip="Delete email"
                                            AlternateText="DeleteEmail" ImageUrl="~/Images/Icons/mail_delete.png" />
                                    </td>
                                </tr>
                            </SelectedItemTemplate>
                            <InsertItemTemplate>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lblAddEmail" runat="server" AssociatedControlID="txtAddEmail">E-mail:</asp:Label>
                                        <asp:TextBox ID="txtAddEmail" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="txtAddEmailRequired" runat="server" ControlToValidate="txtAddEmail"
                                            SetFocusOnError="true" ErrorMessage="E-mail is required." ToolTip="E-mail is required."
                                            ValidationGroup="AddEmail">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btnAddEmail" runat="server" CommandName="Insert" ValidationGroup="AddEmail"
                                            AlternateText="AddEmail" ToolTip="Add Email" ImageUrl="~/Images/Icons/mail_add.png"
                                            ImageAlign="AbsMiddle"></asp:ImageButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:RegularExpressionValidator ID="txtAddEmailRegExp" runat="server" ControlToValidate="txtAddEmail"
                                            SetFocusOnError="true" Display="Dynamic" ErrorMessage="Please enter a valid e-mail."
                                            ValidationExpression="^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name))$"
                                            ValidationGroup="AddEmail"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </InsertItemTemplate>
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
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel runat="server" ID="pnlStorageStatistics">
            <HeaderTemplate>
                Stats
            </HeaderTemplate>
            <ContentTemplate>
                <div id="storagestatistics">
                    <h3>
                        Storage Statistics
                    </h3>
                    <table>
                        <tr>
                            <td align="right">
                                Created date:
                            </td>
                            <td align="left">
                                <asp:Literal ID="litCreatedDate" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Stored files:
                            </td>
                            <td align="left">
                                <asp:Literal ID="litStoredFiles" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Uploaded files:
                            </td>
                            <td align="left">
                                <asp:Literal ID="litUploadedFiles" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Downloaded files:
                            </td>
                            <td align="left">
                                <asp:Literal ID="litDownloadedFiles" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Deleted files:
                            </td>
                            <td align="left">
                                <asp:Literal ID="litDeletedFiles" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:ListView ID="lvStorageStatistics" runat="server" ItemPlaceholderID="phStorageTypeStatistics">
                        <LayoutTemplate>
                            <table>
                                <asp:PlaceHolder ID="phStorageTypeStatistics" runat="server"></asp:PlaceHolder>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td align="right">
                                    Storage type:
                                </td>
                                <td align="left">
                                    <asp:Literal ID="litStorageType" runat="server" Text='<%# base.GetStorageTypeName((int)Eval("storageTypeID")) %>'></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Stored physical files:
                                </td>
                                <td align="left">
                                    <asp:Literal ID="litStoredPhysicalFiles" runat="server" Text='<%# Eval("fileCount") + " (" + DioWeb.App_Classes.StringHelper.ToByteString(double.Parse(Eval("fileBytes").ToString())) + ")" %>'></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Power consumption:
                                </td>
                                <td align="left">
                                    <asp:Literal ID="litPowerConsumption" runat="server" Text='<%# String.Format("{0:0.00} microwatts", Eval("power")) %>'></asp:Literal>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <ItemSeparatorTemplate>
                            <tr>
                                <td colspan="2">
                                </td>
                            </tr>
                        </ItemSeparatorTemplate>
                    </asp:ListView>
                    <br />
                    <asp:LinkButton ID="btnUsageStatistics" runat="server" Text="Get last 7 days stats..."
                        OnClick="btnUsageStatistics_Click" />
                    <asp:GridView ID="gvUsageStatistics" runat="server" AutoGenerateColumns="False" GridLines="None"
                        AllowPaging="True" Caption="<h4>Last 7 days usage:</h4>" RowHeaderColumn="createdDate"
                        CellPadding="3">
                        <Columns>
                            <asp:BoundField DataField="createdDate" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="fileCount" HeaderText="Stored" />
                            <asp:BoundField DataField="uploadCount" HeaderText="Uploaded" />
                            <asp:BoundField DataField="downloadCount" HeaderText="Downloaded" />
                            <asp:BoundField DataField="deletedFileCount" HeaderText="Deleted" />
                        </Columns>
                    </asp:GridView>
                    <asp:ObjectDataSource ID="odsUsageStatistics" runat="server" SelectMethod="SearchFilesTotalLog"
                        TypeName="DioWeb.DioService.DiomedeStorageClient" OnSelecting="odsUsageStatistics_Selecting"
                        OnSelected="odsUsageStatistics_Selected">
                        <SelectParameters>
                            <asp:Parameter Name="sessionToken" Type="String" />
                            <asp:Parameter Name="startDate" Type="DateTime" />
                            <asp:Parameter Name="endDate" Type="DateTime" ConvertEmptyStringToNull="true" />
                            <asp:Parameter Name="offset" Type="Int64" />
                            <asp:Parameter Name="pageSize" Type="Int64" />
                            <asp:Parameter Direction="Output" Name="totalResults" Type="Int64" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </div>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="pnlLogs" runat="server">
            <HeaderTemplate>
                Logs
            </HeaderTemplate>
            <ContentTemplate>
                <h3>
                    Log Access
                </h3>
                <h4>
                    Login log</h4>
                <asp:LinkButton ID="btnLoginLog" runat="server" Text="Get login log..." OnClick="btnLoginLog_Click" />
                <asp:ListView ID="lvLoginLog" runat="server">
                    <LayoutTemplate>
                        <table>
                            <tr>
                                <td>
                                    <table id="itemPlaceholderContainer" runat="server" border="0" class="table" cellspacing="0"
                                        cellpadding="3" rules="none">
                                        <tr>
                                            <th>
                                                User ID
                                            </th>
                                            <th>
                                                Login Date
                                            </th>
                                            <th>
                                                Login IP
                                            </th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DataPager ID="dpLoginLog" runat="server">
                                        <Fields>
                                            <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblUserID" runat="server" Text='<%# Eval("userID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblLoginDate" runat="server" Text='<%# Eval("loginDate") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblLoginIP" runat="server" Text='<%# Eval("loginIP") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
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
                <asp:ObjectDataSource ID="odsLoginLog" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
                    SelectMethod="SearchLoginLog" OnSelecting="odsLoginLog_Selecting" OnSelected="odsLoginLog_Selected">
                    <SelectParameters>
                        <asp:Parameter Name="sessionToken" Type="String" />
                        <asp:Parameter Name="startDate" Type="DateTime" />
                        <asp:Parameter Name="endDate" Type="DateTime" />
                        <asp:Parameter Name="loginIP" Type="String" />
                        <asp:Parameter Name="offset" Type="Int64" />
                        <asp:Parameter Name="pageSize" Type="Int64" />
                        <asp:Parameter Direction="Output" Name="totalResults" Type="Int64" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <h4>
                    Download log</h4>
                <asp:LinkButton ID="btnDownloadLog" runat="server" Text="Get download log..." OnClick="btnDownloadLog_Click" />
                <asp:ListView ID="lvDownloadLog" runat="server">
                    <LayoutTemplate>
                        <table>
                            <tr>
                                <td>
                                    <table id="itemPlaceholderContainer" runat="server" border="0" class="table" cellspacing="0"
                                        cellpadding="3" rules="none">
                                        <tr>
                                            <th>
                                                File ID
                                            </th>
                                            <th>
                                                Start Time
                                            </th>
                                            <th>
                                                End Time
                                            </th>
                                            <th>
                                                Download Token
                                            </th>
                                            <th>
                                                Downloader IP
                                            </th>
                                            <th>
                                                Start Byte
                                            </th>
                                            <th>
                                                Byte Count
                                            </th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DataPager ID="dpLoginLog" runat="server">
                                        <Fields>
                                            <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblFileID" runat="server" Text='<%# Eval("fileID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblStartTime" runat="server" Text='<%# Eval("startTime") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblEndTime" runat="server" Text='<%# Eval("endTime") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblDownloadToken" runat="server" Text='<%# Eval("downloadToken") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblDownloaderIP" runat="server" Text='<%# Eval("downloaderIP") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblStartByte" runat="server" Text='<%# Eval("startByte") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblByteCount" runat="server" Text='<%# Eval("byteCount") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
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
                <asp:ObjectDataSource ID="odsDownloadLog" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
                    SelectMethod="SearchDownloadLog" OnSelecting="odsDownloadLog_Selecting" OnSelected="odsDownloadLog_Selected">
                    <SelectParameters>
                        <asp:Parameter Name="sessionToken" Type="String" />
                        <asp:Parameter Name="fileID" Type="Int64" />
                        <asp:Parameter Name="startDate" Type="DateTime" />
                        <asp:Parameter Name="endDate" Type="DateTime" />
                        <asp:Parameter Name="downloadToken" Type="String" />
                        <asp:Parameter Name="downloaderIP" Type="String" />
                        <asp:Parameter Name="offset" Type="Int64" />
                        <asp:Parameter Name="pageSize" Type="Int64" />
                        <asp:Parameter Direction="Output" Name="totalResults" Type="Int64" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <h4>
                    Upload log</h4>
                <asp:LinkButton ID="btnUploadLog" runat="server" Text="Get upload log..." OnClick="btnUploadLog_Click" />
                <asp:ListView ID="lvUploadLog" runat="server">
                    <LayoutTemplate>
                        <table>
                            <tr>
                                <td>
                                    <table id="itemPlaceholderContainer" runat="server" border="0" class="table" cellspacing="0"
                                        cellpadding="3" rules="none">
                                        <tr>
                                            <th>
                                                File ID
                                            </th>
                                            <th>
                                                Upload Time
                                            </th>
                                            <th>
                                                Uploader IP
                                            </th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DataPager ID="dpLoginLog" runat="server">
                                        <Fields>
                                            <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblFileID" runat="server" Text='<%# Eval("fileID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblUploadTime" runat="server" Text='<%# Eval("uploadTime") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblUploaderIP" runat="server" Text='<%# Eval("uploaderIP") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
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
                <asp:ObjectDataSource ID="odsUploadLog" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
                    SelectMethod="SearchUploadLog" OnSelecting="odsUploadLog_Selecting" OnSelected="odsUploadLog_Selected">
                    <SelectParameters>
                        <asp:Parameter Name="sessionToken" Type="String" />
                        <asp:Parameter Name="fileID" Type="Int64" />
                        <asp:Parameter Name="startDate" Type="DateTime" />
                        <asp:Parameter Name="endDate" Type="DateTime" />
                        <asp:Parameter Name="uploaderIP" Type="String" />
                        <asp:Parameter Name="offset" Type="Int64" />
                        <asp:Parameter Name="pageSize" Type="Int64" />
                        <asp:Parameter Direction="Output" Name="totalResults" Type="Int64" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="pnlBilling" runat="server">
            <HeaderTemplate>
                Billing
            </HeaderTemplate>
            <ContentTemplate>
                <h3>
                    Billing Information
                </h3>
                <h4>
                    Invoices</h4>
                <asp:LinkButton ID="btnInvoiceLog" runat="server" Text="Get invoices..." OnClick="btnInvoiceLog_Click" />
                <asp:ListView ID="lvInvoiceLog" runat="server">
                    <LayoutTemplate>
                        <table>
                            <tr>
                                <td>
                                    <table id="itemPlaceholderContainer" runat="server" border="0" class="table" cellspacing="0"
                                        cellpadding="3" rules="none">
                                        <tr>
                                            <th>
                                                Invoice Number
                                            </th>
                                            <th>
                                                Invoice Date
                                            </th>
                                            <th>
                                                Invoice Details
                                            </th>
                                            <th>
                                                Invoice Note
                                            </th>
                                            <th>
                                                Total Amount
                                            </th>
                                            <th>
                                                Is Paid
                                            </th>
                                            <th>
                                                Payment Info
                                            </th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DataPager ID="dpInvoiceLog" runat="server">
                                        <Fields>
                                            <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblInvoiceNumber" runat="server" Text='<%# Eval("invoiceNumber") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblInvoiceDate" runat="server" Text='<%# Eval("invoiceDate") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblInvoiceDetails" runat="server" Text='<%# Eval("invoiceDetails") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblInvoiceNote" runat="server" Text='<%# Eval("invoiceNote") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblTotalAmount" runat="server" Text='<%# Eval("totalAmount") %>' />
                            </td>
                            <td>
                                <asp:CheckBox ID="ckbIsPaid" runat="server" Checked='<%# Eval("isPaid") %>' Enabled="false" />
                            </td>
                            <td>
                                <asp:Label ID="lblPaymentInfo" runat="server" Text='<%# Eval("paymentInfo") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
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
                <asp:ObjectDataSource ID="odsInvoiceLog" runat="server" SelectMethod="SearchInvoiceLog"
                    TypeName="DioWeb.DioService.DiomedeStorageClient" OnSelecting="odsInvoiceLog_Selecting"
                    OnSelected="odsInvoiceLog_Selected">
                    <SelectParameters>
                        <asp:Parameter Name="sessionToken" Type="String" />
                        <asp:Parameter Name="startDate" Type="DateTime" />
                        <asp:Parameter Name="endDate" Type="DateTime" />
                        <asp:Parameter Name="invoiceStatus" Type="Object" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <%--                <h4>
                    Payments</h4>
                <asp:LinkButton ID="btnPaymentLog" runat="server" Text="Get payments..." OnClick="btnPaymentLog_Click" />
                <asp:ListView ID="lvPaymentLog" runat="server">
                    <LayoutTemplate>
                        <table>
                            <tr>
                                <td>
                                    <table id="itemPlaceholderContainer" runat="server" border="0" class="table" cellspacing="0" cellpadding="3" rules="none">
                                        <tr>
                                            <th>
                                                Currency
                                            </th>
                                            <th>
                                                Amount
                                            </th>
                                            <th>
                                                Completed Date
                                            </th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DataPager ID="dpPaymentLog" runat="server">
                                        <Fields>
                                            <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblCurrency" runat="server" Text='<%# Eval("currency") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("amount") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblCompletedDate" runat="server" Text='<%# Eval("completedDate") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
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
                <asp:ObjectDataSource ID="odsPaymentLog" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
                SelectMethod="SearchPaymentLog" OnSelecting="odsPaymentLog_Selecting" OnSelected="odsPaymentLog_Selected">
                    <SelectParameters>
                        <asp:Parameter Name="sessionToken" Type="String" />
                        <asp:Parameter Name="startDate" Type="DateTime" />
                        <asp:Parameter Name="endDate" Type="DateTime" />
                    </SelectParameters>
                </asp:ObjectDataSource>--%>
            </ContentTemplate>
        </cc1:TabPanel>
    </cc1:TabContainer>
</asp:Content>
