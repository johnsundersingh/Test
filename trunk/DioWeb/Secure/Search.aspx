<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Search.aspx.cs" Inherits="DioWeb.Secure.Search" Async="true" Title="DioWeb :: File Manager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link href="../CSS/Search.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <div>
        <h3 class="title">
            <asp:Image ID="imgSearchFiles" runat="server" ImageUrl="~/Images/Icons/search.png"
                ImageAlign="AbsMiddle" />
            Search Files
        </h3>
        <asp:Panel ID="pnlSearchFormHeader" runat="server">
            <table>
                <tr>
                    <td align="right" class="searchrow">
                        <asp:Label ID="lblFileName" runat="server" Text="File Name:" AssociatedControlID="txtFileName"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtFileName" runat="server" Columns="60"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblAdvancedSearch" runat="server" CssClass="advancedsearch" Text="Show Advanced Search"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="left">
                        <asp:Panel ID="pnlSearchForm" runat="server" CssClass="collapsiblepanel" Height="0">
                            <table cellspacing="0">
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblFileID" runat="server" Text="File ID:" AssociatedControlID="txtFileID"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtFileID" runat="server" Columns="10"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblHashMD5" runat="server" Text="MD5 Hash:" AssociatedControlID="txtHashMD5"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtHashMD5" runat="server" Columns="60"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblHashSHA1" runat="server" Text="SHA1 Hash:" AssociatedControlID="txtHashSHA1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtHashSHA1" runat="server" Columns="60"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblMinSize" runat="server" Text="Min File Size:" AssociatedControlID="txtMinSize"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtMinSize" runat="server" Columns="10"></asp:TextBox>&nbsp;Bytes
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblMaxSize" runat="server" Text="Max File Size:" AssociatedControlID="txtMaxSize"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtMaxSize" runat="server" Columns="10"></asp:TextBox>&nbsp;Bytes
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblStartDate" runat="server" Text="Start Date:" AssociatedControlID="txtStartDate"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtStartDate" runat="server" Columns="10"></asp:TextBox>
                                    </td>
                                    <cc1:CalendarExtender ID="txtStartDateCalendarExtender" runat="server" TargetControlID="txtStartDate">
                                    </cc1:CalendarExtender>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblEndDate" runat="server" Text="End Date:" AssociatedControlID="txtEndDate"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtEndDate" runat="server" Columns="10"></asp:TextBox>
                                    </td>
                                    <cc1:CalendarExtender ID="txtEndDateCalendarExtender" runat="server" TargetControlID="txtEndDate">
                                    </cc1:CalendarExtender>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblMetaName" runat="server" Text="Metadata Name:" AssociatedControlID="txtMetaName"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtMetaName" runat="server" Columns="60"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblMetaValue" runat="server" Text="Metadata Value" AssociatedControlID="txtMetaValue"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtMetaValue" runat="server" Columns="60"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblIsDeleted" runat="server" Text="Is Deleted?:" AssociatedControlID="rblIsDeleted"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:RadioButtonList ID="rblIsDeleted" runat="server" RepeatDirection="Horizontal"
                                            RepeatLayout="Flow">
                                            <asp:ListItem Text="Yes" Value="true" />
                                            <asp:ListItem Text="No" Value="false" Selected="True" />
                                            <asp:ListItem Text="All" Value="null" />
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="searchrow">
                                        <asp:Label ID="lblIsComplete" runat="server" Text="Is Complete?:" AssociatedControlID="rblIsComplete"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:RadioButtonList ID="rblIsComplete" runat="server" RepeatDirection="Horizontal"
                                            RepeatLayout="Flow">
                                            <asp:ListItem Text="Yes" Value="true" />
                                            <asp:ListItem Text="No" Value="false" />
                                            <asp:ListItem Text="All" Value="null" Selected="True" />
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <cc1:CollapsiblePanelExtender ID="cpeSearchForm" runat="server" TargetControlID="pnlSearchForm"
                            CollapseControlID="lblAdvancedSearch" ExpandControlID="lblAdvancedSearch" Collapsed="true"
                            TextLabelID="lblAdvancedSearch" CollapsedText="Show Advanced Search" ExpandedText="Hide Advanced Search" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:ImageButton ID="btnSearch" runat="server" AlternateText="Search" ToolTip="Filter files"
                            ImageUrl="~/Images/Buttons/search.png" OnClick="btnSearch_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <div>
        <div id="pagesize">
            <asp:Label ID="lblSearchResultPageSize" runat="server" Text="Page Size" AssociatedControlID="ddlSearchResultPageSize"></asp:Label>
            <asp:DropDownList ID="ddlSearchResultPageSize" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="ddlSearchResultPageSize_SelectedIndexChanged">
                <asp:ListItem Value="25" />
                <asp:ListItem Value="75" />
                <asp:ListItem Value="150" />
            </asp:DropDownList>
        </div>
        <asp:ListView ID="lvSearchFilesResult" runat="server" DataSourceID="odsSearchFilesResult"
            DataKeyNames="fileID" ItemPlaceholderID="phFileDetails" OnItemDataBound="lvSearchFilesResult_ItemDataBound"
            OnItemCommand="lvSearchFilesResult_ItemCommand">
            <LayoutTemplate>
                <table class="table" rules="none">
                    <tr>
                        <th>
                            ID
                        </th>
                        <th align="left">
                            Filename
                        </th>
                        <th align="right">
                            Power
                        </th>
                        <th align="right">
                            File Size
                        </th>
                        <th align="right">
                            Last Modified Date
                        </th>
                        <th colspan="5">
                        </th>
                    </tr>
                    <asp:PlaceHolder ID="phFileDetails" runat="server"></asp:PlaceHolder>
                    <tr>
                        <th align="right" colspan="4">
                            <asp:Label ID="lblData" runat="server"></asp:Label>
                        </th>
                        <th colspan="6">
                        </th>
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%# GetFileID() %>
                    </td>
                    <td align="left">
                        <asp:HyperLink ID="lnkFileName" runat="server" NavigateUrl='<%# Eval("fileID", "~/Secure/Download.aspx?fid={0}") %>'><%# GetFileName(Eval("fileName").ToString(), (bool)Eval("isDeleted"), (bool)Eval("isComplete")) %></asp:HyperLink>
                    </td>
                    <td align="right">
                        <%# Eval("power", "{0:0.00} uW")%>
                    </td>
                    <td align="right">
                        <%# DioWeb.App_Classes.StringHelper.ToByteString(double.Parse(Eval("fileSize").ToString()))%>
                    </td>
                    <td align="right">
                        <%# Eval("lastModifiedDate")%>
                    </td>
                    <td>
                        <asp:ImageButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Edit" AlternateText="Edit"
                            ImageUrl="~/Images/Icons/edit.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete"
                            AlternateText="Delete" ImageUrl="~/Images/Icons/delete.png" />
                        <asp:ImageButton ID="btnUndelete" runat="server" CommandName="Undelete" ToolTip="Undelete"
                            AlternateText="Undelete" Visible="false" ImageUrl="~/Images/Icons/refresh.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnInfo" runat="server" ToolTip="Info" AlternateText="Info"
                            ImageUrl="~/Images/Icons/info.png" />
                    </td>
                    <td>
                        <asp:HyperLink ID="lnkReplication" runat="server" NavigateUrl='<%# GetReplicationURL() %>'>
                            <asp:Image ID="imgReplication" runat="server" ToolTip="Replication" AlternateText="Replication"
                                ImageUrl="~/Images/Icons/add.png" /></asp:HyperLink>
                    </td>
                    <td>
                        <asp:HyperLink ID="lnkMetadata" runat="server" NavigateUrl='<%# GetMetadataURL() %>'>
                            <asp:Image ID="imgMetadata" runat="server" ToolTip="Metadata" AlternateText="Metadata"
                                ImageUrl="~/Images/Icons/tag.png" /></asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlFileInfo" runat="server" Style="display: none;" CssClass="modalPopup">
                            <div id="fileinfoclose">
                                <asp:ImageButton ID="btnClose" runat="server" ToolTip="Close" AlternateText="Close"
                                    ImageUrl="~/Images/Icons/close.png" />
                            </div>
                            <div id="fileinfo">
                                <h3>
                                    Detailed File Info
                                </h3>
                                <table rules="none">
                                    <tr>
                                        <th align="right">
                                            Logical File ID:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblFileID" runat="server" Text='<%# Eval("fileID") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            File Name:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblFileName" runat="server" Text='<%# Eval("fileName") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            File Size:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblFileSize" runat="server" Text='<%# DioWeb.App_Classes.StringHelper.ToByteString(double.Parse(Eval("fileSize").ToString()))%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            Power Consumption:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblPower" runat="server" Text='<%# Eval("power", "{0:0.00} uW")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            Created Date:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            Last Modified Date:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblLastModifiedDate" runat="server" Text='<%# Eval("lastModifiedDate")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            Last Access Date:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblLastAccessDate" runat="server" Text='<%# Eval("lastAccessDate")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            MD5:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblHashMD5" runat="server" Text='<%# Eval("hashMD5")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            SHA1:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblHashSHA1" runat="server" Text='<%# Eval("hashSHA1")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            Is Deleted:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblIsDeleted" runat="server" Text='<%# Eval("isDeleted")%>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="right">
                                            Is Complete:
                                        </th>
                                        <td align="left">
                                            <asp:Label ID="lblIsComplete" runat="server" Text='<%# Eval("isComplete")%>' />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="mpeFileInfo" runat="server" TargetControlID="btnInfo"
                            PopupControlID="pnlFileInfo" BackgroundCssClass="modalBackground" CancelControlID="btnClose" />
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr class="selected">
                    <td>
                        <%# Eval("fileID") %>
                    </td>
                    <td align="left" class="filename">
                        <asp:TextBox ID="txtFileName" runat="server" Text='<%# Eval("fileName") %>'></asp:TextBox>
                    </td>
                    <td align="right">
                        <%# Eval("power", "{0:0.00} uW")%>
                    </td>
                    <td align="right">
                        <%# DioWeb.App_Classes.StringHelper.ToByteString(double.Parse(Eval("fileSize").ToString()))%>
                    </td>
                    <td align="right">
                        <%# Eval("lastModifiedDate")%>
                    </td>
                    <td>
                        <asp:ImageButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Update"
                            AlternateText="Update" ImageUrl="~/Images/Icons/check.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Cancel"
                            AlternateText="Cancel" ImageUrl="~/Images/Icons/cancel.png" />
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table>
                    <tr>
                        <td>
                            <h4>
                                No files were returned.</h4>
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="odsSearchFilesResult" runat="server" OnSelected="odsSearchFilesResult_Selected"
            OnSelecting="odsSearchFilesResult_Selecting" SelectMethod="SearchFiles" TypeName="DioWeb.DioService.DiomedeStorageClient"
            DeleteMethod="DeleteFile" UpdateMethod="RenameFile" OnUpdating="odsSearchFilesResult_Updating"
            OnDeleting="odsSearchFilesResult_Deleting" OnDeleted="odsSearchFilesResult_Deleted"
            OnUpdated="odsSearchFilesResult_Updated">
            <DeleteParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="fileID" Type="Int64" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="fileID" Type="Int64" />
                <asp:Parameter Name="newFileName" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="fileID" Type="Int64" />
                <asp:Parameter Name="fileName" Type="String" />
                <asp:Parameter Name="hashMD5" Type="String" />
                <asp:Parameter Name="hashSHA1" Type="String" />
                <asp:Parameter Name="minSize" Type="Int64" />
                <asp:Parameter Name="maxSize" Type="Int64" />
                <asp:Parameter Name="startDate" Type="DateTime" />
                <asp:Parameter Name="endDate" Type="DateTime" />
                <asp:Parameter Name="isDeleted" Type="Boolean" />
                <asp:Parameter Name="isComplete" Type="Boolean" />
                <asp:Parameter Name="metaName" Type="String" />
                <asp:Parameter Name="metaValue" Type="String" />
                <asp:Parameter Name="offset" Type="Int64" />
                <asp:Parameter Name="pageSize" Type="Int64" />
                <asp:Parameter Direction="Output" Name="totalResults" Type="Int64" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <asp:DataPager ID="dpSearchFilesResult" runat="server" PagedControlID="lvSearchFilesResult"
            Visible="false">
            <Fields>
                <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="False"
                    ButtonType="Image" FirstPageImageUrl="~/Images/Icons/back.png" PreviousPageImageUrl="~/Images/Icons/previous.png"
                    ButtonCssClass="pagerbutton" FirstPageText="" PreviousPageText="" RenderDisabledButtonsAsLabels="true" />
                <asp:TemplatePagerField>
                    <PagerTemplate>
                        <asp:TextBox ID="txtCurrentPage" runat="server" Text="<%# Container.TotalRowCount > 0 ? (Container.StartRowIndex / Container.PageSize) + 1 : 0 %>"
                            Columns="1" AutoPostBack="True" CssClass="pagertext" OnTextChanged="txtCurrentPage_OnTextChanged"></asp:TextBox>
                        of
                        <asp:Label ID="lblTotalPages" runat="server" Text="<%# Math.Ceiling ((double)Container.TotalRowCount / Container.PageSize) %>" />
                    </PagerTemplate>
                </asp:TemplatePagerField>
                <asp:NextPreviousPagerField ShowLastPageButton="True" ShowPreviousPageButton="False"
                    ButtonType="Image" NextPageImageUrl="~/Images/Icons/next.png" LastPageImageUrl="~/Images/Icons/forward.png"
                    ButtonCssClass="pagerbutton" LastPageText="" NextPageText="" RenderDisabledButtonsAsLabels="true" />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>
