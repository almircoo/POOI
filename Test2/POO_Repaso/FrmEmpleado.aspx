<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmEmpleado.aspx.cs" Inherits="POO_Repaso.FrmEmpleado" %>

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

                   <asp:Button ID="btnBD" runat="server" Text="Cargar datos SQL y Guardar JSON" OnClick="btnBD_Click" />

                 </td>

                 <td>

                   <asp:Button ID="btnJson" runat="server" Text="Leer datos del JSON" OnClick="btnJson_Click" />

                 </td>

               </tr>

               <tr>

                 <td align="center">

                   <asp:GridView ID="gvBD" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">

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

                 <td align="center">

                   <asp:GridView ID="gvJson" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">

                     <AlternatingRowStyle BackColor="PaleGoldenrod" />

                     <FooterStyle BackColor="Tan" />

                     <HeaderStyle BackColor="Tan" Font-Bold="True" />

                     <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />

                     <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />

                     <SortedAscendingCellStyle BackColor="#FAFAE7" />

                     <SortedAscendingHeaderStyle BackColor="#DAC09E" />

                     <SortedDescendingCellStyle BackColor="#E1DB9C" />

                     <SortedDescendingHeaderStyle BackColor="#C2A47B" />

                   </asp:GridView>

                 </td>

               </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="llbmensaje" runat="server" Text="."></asp:Label>
                    </td>
                </tr>
                <Table>

                     <tr>

                       <td>



                         <asp:Label ID="Label1" runat="server" Text="Código:"></asp:Label> 

                       </td>

                       <td>

                         <asp:TextBox ID="txtcodigo" runat="server" BorderStyle="Solid"></asp:TextBox>

                       </td>

                     </tr>

                     <tr>

                         <td>



                           <asp:Label ID="Label2" runat="server" Text="Nombres:"></asp:Label>

                         </td>

                         <td>

                            <asp:TextBox ID="txtnombres" runat="server" BorderStyle="Solid"></asp:TextBox>

                         </td>

                       </tr>
                     <tr>

                     <td>



                       <asp:Label ID="Label4" runat="server" Text="Apellidos:"></asp:Label> 

                     </td>

                       <td>



                         <asp:TextBox ID="txtapellidos" runat="server" BorderStyle="Solid"></asp:TextBox>

                       </td>

                   </tr>

                        <tr>

                         <td>



                           <asp:Label ID="Label3" runat="server" Text="Correo: "></asp:Label> 

                         </td>

                          <td>

                            <asp:TextBox ID="txtcorreo" runat="server" BorderStyle="Solid"></asp:TextBox>

                          </td>

                       </tr>

                         

                               <tr>

                         <td>



                           <asp:Label ID="Label5" runat="server" Text="Sueldo:"></asp:Label> 

                         </td>

                         <td>

                           <asp:TextBox ID="txtsueldo" runat="server" BorderStyle="Solid"></asp:TextBox>

                         </td>

                       </tr>

                       </Table>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="bntinsertar" runat="server" Text="Inserta" OnClick="bntinsertar_Click" /> <asp:Button ID="btnactualizar" runat="server" Text="Actualizar" OnClick="btnactualizar_Click" /><asp:Button ID="btneliminar" runat="server" Text="Elimnar" OnClick="btneliminar_Click" />
                    </td>
                </tr>
                
                    

             </table>
        </div>
    </form>
</body>
</html>
