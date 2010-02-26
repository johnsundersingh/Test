<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Replication.aspx.cs" Inherits="DioWeb.Secure.Replication" Title="DioWeb :: Replication" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <div>
        <h3 class="title">
            Replication Policies
        </h3>
        <asp:ListView ID="lvReplicationPolicies" runat="server" DataSourceID="odsReplicationPolicies"
            DataKeyNames="replicationPolicyID" InsertItemPosition="LastItem" OnItemCommand="lvReplicationPolicies_ItemCommand"
            OnItemDataBound="lvReplicationPolicies_ItemDataBound" OnSelectedIndexChanged="lvReplicationPolicies_SelectedIndexChanged">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" class="table" rules="none">
                    <tr>
                        <th>
                            ID
                        </th>
                        <th>
                            Requested number of<br />
                            online copies at upload
                        </th>
                        <th>
                            Requested number of<br />
                            nearline copies at upload
                        </th>
                        <th>
                            Requested number of<br />
                            offline copies at upload
                        </th>
                        <th>
                            Number hours before<br />
                            the trigger is activated
                        </th>
                        <th>
                            Number of online copies<br />
                            when trigger is activated
                        </th>
                        <th>
                            Number on nearline copies<br />
                            when trigger is activated
                        </th>
                        <th>
                            Number on offline copies<br />
                            when trigger is activated
                        </th>
                        <th>
                            Policy expiration hours
                        </th>
                        <th colspan="4">
                        </th>
                    </tr>
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblReplicationPolicyID" runat="server" Text='<%# Eval("replicationPolicyID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblDefaultNumOnline" runat="server" Text='<%# Eval("defaultNumOnline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblDefaultNumNearline" runat="server" Text='<%# Eval("defaultNumNearline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblDefaultNumOffline" runat="server" Text='<%# Eval("defaultNumOffline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerHours" runat="server" Text='<%# Eval("lastAccessTriggerHours") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerNumOnline" runat="server" Text='<%# Eval("lastAccessTriggerNumOnline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerNumNearline" runat="server" Text='<%# Eval("lastAccessTriggerNumNearline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerNumOffline" runat="server" Text='<%# Eval("lastAccessTriggerNumOffline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblExpireHours" runat="server" Text='<%# Eval("expireHours") != null ? Eval("expireHours") : "<em>none</em>" %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Edit policy"
                            AlternateText="Edit" ImageUrl="~/Images/Icons/edit.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete policy"
                            AlternateText="Delete" ImageUrl="~/Images/Icons/folder_delete.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnDefault" runat="server" CommandName="Select" ToolTip="Set policy as default"
                            AlternateText="Default" ImageUrl="~/Images/Icons/star_empty.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnSetToFile" runat="server" CommandName="SetToFile" ToolTip="Set policy to current file"
                            AlternateText="SetToFile" ImageUrl="~/Images/Icons/down.png" />
                    </td>
                </tr>
            </ItemTemplate>
            <SelectedItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblReplicationPolicyID" runat="server" Text='<%# Eval("replicationPolicyID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblDefaultNumOnline" runat="server" Text='<%# Eval("defaultNumOnline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblDefaultNumNearline" runat="server" Text='<%# Eval("defaultNumNearline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblDefaultNumOffline" runat="server" Text='<%# Eval("defaultNumOffline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerHours" runat="server" Text='<%# Eval("lastAccessTriggerHours") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerNumOnline" runat="server" Text='<%# Eval("lastAccessTriggerNumOnline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerNumNearline" runat="server" Text='<%# Eval("lastAccessTriggerNumNearline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblLastAccessTriggerNumOffline" runat="server" Text='<%# Eval("lastAccessTriggerNumOffline") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblExpireHours" runat="server" Text='<%# Eval("expireHours") != null ? Eval("expireHours") : "<em>none</em>" %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Edit policy"
                            AlternateText="Edit" ImageUrl="~/Images/Icons/edit.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete policy"
                            AlternateText="Delete" ImageUrl="~/Images/Icons/folder_delete.png" />
                    </td>
                    <td>
                        <asp:Image ID="imgDefault" runat="server" ToolTip="Default policy" AlternateText="Default"
                            ImageUrl="~/Images/Icons/star_filled.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnSetToFile" runat="server" CommandName="SetToFile" ToolTip="Set policy to current file"
                            AlternateText="SetToFile" ImageUrl="~/Images/Icons/down.png" />
                    </td>
                </tr>
            </SelectedItemTemplate>
            <EditItemTemplate>
                <tr class="selected">
                    <td>
                        <asp:Label ID="lblReplicationPolicyID" runat="server" Text='<%# Eval("replicationPolicyID") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDefaultNumOnline" runat="server" Text='<%# Eval("defaultNumOnline") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtDefaultNumNearline" runat="server" Text='<%# Eval("defaultNumNearline") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtDefaultNumOffline" runat="server" Text='<%# Eval("defaultNumOffline") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtLastAccessTriggerHours" runat="server" Text='<%# Eval("lastAccessTriggerHours") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtLastAccessTriggerNumOnline" runat="server" Text='<%# Eval("lastAccessTriggerNumOnline") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtLastAccessTriggerNumNearline" runat="server" Text='<%# Eval("lastAccessTriggerNumNearline") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtLastAccessTriggerNumOffline" runat="server" Text='<%# Eval("lastAccessTriggerNumOffline") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtExpireHours" runat="server" Text='<%# Eval("expireHours") %>'
                            Columns="1" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Update"
                            AlternateText="Update" ImageUrl="~/Images/Icons/check.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Cancel"
                            AlternateText="Cancel" ImageUrl="~/Images/Icons/cancel.png" />
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <th>
                        Add new policy
                    </th>
                    <th>
                        <asp:TextBox ID="txtDefaultNumOnline" runat="server" Text='<%# Bind("defaultNumOnline") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtDefaultNumNearline" runat="server" Text='<%# Bind("defaultNumNearline") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtDefaultNumOffline" runat="server" Text='<%# Bind("defaultNumOffline") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtLastAccessTriggerHours" runat="server" Text='<%# Bind("lastAccessTriggerHours") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtLastAccessTriggerNumOnline" runat="server" Text='<%# Bind("lastAccessTriggerNumOnline") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtLastAccessTriggerNumNearline" runat="server" Text='<%# Bind("lastAccessTriggerNumNearline") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtLastAccessTriggerNumOffline" runat="server" Text='<%# Bind("lastAccessTriggerNumOffline") %>'
                            Columns="1" />
                    </th>
                    <th>
                        <asp:TextBox ID="txtExpireHours" runat="server" Text='<%# Bind("expireHours") %>'
                            Columns="1" />
                    </th>
                    <th>
                    </th>
                    <th>
                        <asp:ImageButton ID="btnInsert" runat="server" CommandName="Insert" ToolTip="Add new policy"
                            AlternateText="Insert" ImageUrl="~/Images/Icons/folder_add.png" />
                    </th>
                    <th>
                    </th>
                    <th>
                    </th>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="odsReplicationPolicies" runat="server" OnSelecting="odsReplicationPolicies_Selecting"
            SelectMethod="GetReplicationPolicies" TypeName="DioWeb.DioService.DiomedeStorageClient"
            DeleteMethod="DeleteReplicationPolicy" InsertMethod="CreateReplicationPolicy"
            OnDeleting="odsReplicationPolicies_Deleting" OnInserting="odsReplicationPolicies_Inserting"
            OnUpdating="odsReplicationPolicies_Updating" UpdateMethod="EditReplicationPolicy"
            OnDeleted="odsReplicationPolicies_Deleted" OnInserted="odsReplicationPolicies_Inserted"
            OnSelected="odsReplicationPolicies_Selected" OnUpdated="odsReplicationPolicies_Updated">
            <DeleteParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="replicationPolicyID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="replicationPolicy" Type="Object" />
            </UpdateParameters>
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="defaultNumOnline" Type="Int32" />
                <asp:Parameter Name="defaultNumNearline" Type="Int32" />
                <asp:Parameter Name="defaultNumOffline" Type="Int32" />
                <asp:Parameter Name="lastAccessTriggerHours" Type="Int32" />
                <asp:Parameter Name="lastAccessTriggerNumOnline" Type="Int32" />
                <asp:Parameter Name="lastAccessTriggerNumNearline" Type="Int32" />
                <asp:Parameter Name="lastAccessTriggerNumOffline" Type="Int32" />
                <asp:Parameter Name="expireHours" Type="Int32" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
    <div>
        <h3>
            FileID #<%= FileID %>: Physical Files
        </h3>
        <asp:ListView ID="lvPhysicalFiles" runat="server" DataKeyNames="physicalFileID" OnItemCommand="lvPhysicalFiles_ItemCommand"
            DataSourceID="odsPhysicalFiles">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" class="table" rules="none">
                    <tr>
                        <th>
                            ID
                        </th>
                        <th>
                            Storage Type
                        </th>
                        <th>
                            Power
                        </th>
                        <th>
                            Requested Date
                        </th>
                        <th>
                            Created Date
                        </th>
                        <th>
                            Exercised Date
                        </th>
                        <th>
                            Expiration Date
                        </th>
                        <th>
                        </th>
                    </tr>
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                    <tr>
                        <th colspan="7" align="right">
                            Replicate
                            <asp:DropDownList ID="ddlStorageTypes" runat="server" DataTextField="name" DataValueField="storageTypeID">
                            </asp:DropDownList>
                        </th>
                        <th>
                            <asp:ImageButton ID="btnReplicate" runat="server" CommandName="Replicate" ToolTip="Replicate"
                                AlternateText="Replicate" ImageUrl="~/Images/Icons/document_add.png" ImageAlign="AbsMiddle" />
                        </th>
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblPhysicalFileID" runat="server" Text='<%# Eval("physicalFileID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblStorageType" runat="server" Text='<%# base.GetStorageTypeName((int)Eval("storageTypeID")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblPower" runat="server" Text='<%# Eval("power", "{0:0.00} uW")%>' />
                    </td>
                    <td>
                        <asp:Label ID="lblRequestedDate" runat="server" Text='<%# Eval("requestedDate") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") != null ? Eval("createdDate") : "<em>none</em>" %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblExercisedDate" runat="server" Text='<%# Eval("exercisedDate") != null ? Eval("exercisedDate") : "<em>none</em>" %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblExpirationDate" runat="server" Text='<%# Eval("expirationDate") != null ? Eval("expirationDate") : "<em>none</em>" %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnUnreplicate" runat="server" CommandName="Unreplicate" ToolTip="Unreplicate"
                            AlternateText="Unreplicate" ImageUrl="~/Images/Icons/document_delete.png" ImageAlign="AbsMiddle" />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="odsPhysicalFiles" runat="server" OnSelecting="odsPhysicalFiles_Selecting"
            SelectMethod="GetPhysicalFiles" TypeName="DioWeb.DioService.DiomedeStorageClient"
            OnSelected="odsPhysicalFiles_Selected">
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:QueryStringParameter Name="fileID" QueryStringField="fid" Type="Int64" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
