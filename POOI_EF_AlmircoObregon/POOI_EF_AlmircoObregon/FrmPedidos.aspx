<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmPedidos.aspx.cs" Inherits="POOI_EF_AlmircoObregon.FrmPedidos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Reporte de Pedidos por Empleado y Año</h2>

            <table>
                <tr>
                    <td>
                        <asp:Label ID="txtLabel" runat="server" Text="Buscar por Año:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAnio" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar Pedidos" OnClick="btnBuscar_Click" ForeColor="Black"/>
                    </td>
                </tr>
            </table>
            

            <asp:Label ID="lblMensaje" runat="server" ForeColor="#00FF99"></asp:Label>
            <asp:Label ID="lblError" runat="server" ForeColor="#FF6666"></asp:Label>
            <table>
                <tr>
                    <td>
                        <h3>Resultados</h3>
                        <asp:GridView ID="gvResultados" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
