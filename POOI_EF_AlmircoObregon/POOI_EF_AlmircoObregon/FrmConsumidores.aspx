<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmConsumidores.aspx.cs" Inherits="POOI_EF_AlmircoObregon.FrmConsumidores" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Gestión de Consumidores</h2>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="ID Consumidor:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtIdCons" runat="server" BorderStyle="Solid" Width="150px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Nombres:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtNomCons" runat="server" BorderStyle="Solid" Width="150px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Apellidos:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtApeCons" runat="server" BorderStyle="Solid" Width="150px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Correo:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmailCons" runat="server" BorderStyle="Solid" Width="150px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Pais:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPais" runat="server" DataTextField="NombrePais" DataValueField="IdPais"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Telefono:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFonoCons" runat="server" BorderStyle="Solid" Width="150px"></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click"  />
                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" OnClick="btnActualizar_Click"  />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click"  />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="#00FF99"></asp:Label>
                        <asp:Label ID="lblError" runat="server" ForeColor="#FF6666"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="gvConsumidores" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
