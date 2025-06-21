<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmAlumnos.aspx.cs" Inherits="POOI_T2_JESUSALMIRCO.FrmAlumnos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Código:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtcodigo" runat="server" BorderStyle="Solid" Width="52px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Nombres:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtnombres" runat="server" BorderStyle="Solid" Width="243px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Apellidos:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="textapellidos" runat="server" BorderStyle="Solid" Width="243px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Edad:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtedad" runat="server" BorderStyle="Solid" TextMode="Number" Width="48px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Correo:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtcorreo" runat="server" BorderStyle="Solid" Width="238px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Carrera:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtcarrera" runat="server" BorderStyle="Solid" Width="240px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">

                        <asp:Label ID="lblmensaje" runat="server" Text="." ForeColor="#006666"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnagregaralumno" runat="server" Text="Agregar Alumno" OnClick="btnagregaralumno_Click"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnverAlumnos" runat="server" Text="Ver Alumnos" OnClick="btnverAlumnos_Click" /><asp:Button ID="btnguardar" runat="server" Text="Serializar a JSON" OnClick="btnserializar_Click"  /><asp:Button ID="btneliminar" runat="server" Text="Eliminar Archivo" OnClick="btneliminar_Click"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="gvalumnos" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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
