using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace POOI_EF_AlmircoObregon
{
    public partial class FrmPedidos : System.Web.UI.Page
    {
        EmpleadoADO EP = new EmpleadoADO();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            lblError.Text = "";
            
            try
            {
                int anio = Convert.ToInt32(txtAnio.Text.Trim());
                gvResultados.DataSource = EP.ListarEmpleadosPedidosPorAnio(anio);
                gvResultados.DataBind();

                if (gvResultados.Rows.Count == 0)
                {
                    lblMensaje.Text = "No se encontraron pedidos para el año " + anio + ".";
                }
            }
            catch (FormatException)
            {
                lblError.Text = "Por favor, ingrese un año válido (número entero de 4 dígitos).";
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al buscar pedidos: " + ex.Message;
            }
            
        }
    }
}