<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmEmpleados.aspx.cs" Inherits="POOI_web300625.FrmEmpleados" %>

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

      <asp:Label ID="Label1" runat="server" Text="Cargo:"></asp:Label>

    </td>

    <td>

      <asp:DropDownList ID="ddlcargo" runat="server" Height="16px" Width="188px"></asp:DropDownList>

    </td>

  </tr>

  <tr>

    <td>

      <asp:Label ID="Label2" runat="server" Text="Distrito:"></asp:Label>

    </td>

    <td>

      <asp:DropDownList ID="ddldistrito" Height="16px" Width="188px" runat="server"></asp:DropDownList>

    </td>

  </tr>

  <tr>

    <td colspan="2">



      <asp:Button ID="btnfiltrar" runat="server" Text="Filtrar" OnClick="btnfiltrar_Click" Width="73px" />

    </td>

  </tr>

  <tr>

    <td colspan="2">

      <asp:GridView ID="gvEmpleado" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">

        <AlternatingRowStyle BackColor="White" />

        <FooterStyle BackColor="#CCCC99" />

        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />

        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />

        <RowStyle BackColor="#F7F7DE" />

        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />

        <SortedAscendingCellStyle BackColor="#FBFBF2" />

        <SortedAscendingHeaderStyle BackColor="#848384" />

        <SortedDescendingCellStyle BackColor="#EAEAD3" />

        <SortedDescendingHeaderStyle BackColor="#575357" />

      </asp:GridView>

    </td>

  </tr>

</table>
        </div>
    </form>
</body>
</html>
