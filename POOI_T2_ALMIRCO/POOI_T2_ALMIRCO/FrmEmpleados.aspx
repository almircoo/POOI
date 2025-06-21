<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmEmpleados.aspx.cs" Inherits="POOI_T2_ALMIRCO.FrmEmpleados" %>

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
                        <asp:Label ID="Label2" runat="server" Text="Id Empleado:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtidempleado" runat="server" BorderStyle="Solid" Width="100px" CausesValidation="True" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Nombres:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtnombres" runat="server" BorderStyle="Solid" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Apellido:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtapellido" runat="server" BorderStyle="Solid" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Dirección:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtdireccion" runat="server" BorderStyle="Solid" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Cargo:"></asp:Label>
                    </td>
                    <td>
                        
                        <asp:DropDownList ID="ddlCargo" runat="server" CssClass="form-input">
                            <asp:ListItem Value="">-- Seleccione un cargo --</asp:ListItem>
                            <%--<asp:ListItem Value="Gerente">Gerente</asp:ListItem>
                            <asp:ListItem Value="Supervisor">Supervisor</asp:ListItem>
                            <asp:ListItem Value="Vendedor">Vendedor</asp:ListItem>
                            <asp:ListItem Value="Administrativo">Administrativo</asp:ListItem>
                            <asp:ListItem Value="Contador">Contador</asp:ListItem>--%>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCargo" runat="server" 
                            ControlToValidate="ddlCargo" 
                            InitialValue=""
                            ErrorMessage="*" 
                            ForeColor="Red" 
                            ValidationGroup="Agregar">
                        </asp:RequiredFieldValidator>
                        <%--<asp:TextBox ID="txtcargo" runat="server" BorderStyle="Solid" Width="200px"></asp:TextBox>--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">

                        <asp:Label ID="lblmensaje" runat="server" Text="." ForeColor="#006666"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnagregarEmpleado" runat="server" Text="Agregar Empleado" BackColor="#00FF99" BorderColor="#00FF99" Font-Bold="True" Font-Size="Medium" OnClick="btnagregarEmpleado_Click" ForeColor="White" Width="149px" />
                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar Empleado"
                            BackColor="#FFA500" BorderColor="#FFA500" Font-Bold="True"
                            ForeColor="White" Width="149px" OnClick="btnActualizar_Click" 
                         />
                    </td>
                </tr>
            </table>
        </div>

        <div>
             <table>
                <tr>
                    <td>
                        <asp:Button ID="btnempleados" runat="server" Text="Mostrar Empleados" BackColor="#00FF99" BorderColor="#00FF99" Font-Bold="True" Font-Size="Medium" OnClick="btnempleados_Click" ForeColor="White" Width="197px" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">

                        <asp:GridView ID="gvempleados" runat="server" AutoGenerateSelectButton="true" OnSelectedIndexChanged="gvempleados_SelectedIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#7C6F57" />
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#E3EAEB" />
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F8FAFA" />
                            <SortedAscendingHeaderStyle BackColor="#246B61" />
                            <SortedDescendingCellStyle BackColor="#D4DFE1" />
                            <SortedDescendingHeaderStyle BackColor="#15524A" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Codigo: "></asp:Label>
                        <asp:TextBox ID="textIdEmpleado" runat="server"></asp:TextBox>


                       <asp:Button ID="btneliminar" runat="server" Text="Eliminar" BackColor="#FF6666" BorderColor="#FF6666" Font-Bold="True" Font-Overline="False" Font-Size="Medium" OnClick="btneliminar_Click" />
                    </td>
                </tr>

            </table>
        </div>
    </form>
</body>
</html>
