using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace POOI_web300625
{
    public partial class FrmEmpleados : System.Web.UI.Page
    {
        EmpleadosADO EMP = new EmpleadosADO();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDLL_Cargos();
                CargarDLL_Distrito();
                CargarGridView_Empleados("",""); // craga la vista en vacios
            }
        }

        public void CargarDLL_Cargos()
        {
            DataView vista = EMP.ObtenerCargos();
            ddlcargo.DataSource = vista;
            ddlcargo.DataTextField = "descripcion";
            ddlcargo.DataValueField = "codigo";
            ddlcargo.DataBind(); // agrega los datos al dropdown

        }

        public void CargarDLL_Distrito()
        {
            DataView vista = EMP.ObtenerDistrito();
            ddldistrito.DataSource = vista;
            ddldistrito.DataTextField = "nombre_distrito";
            ddldistrito.DataValueField = "code";
            ddldistrito.DataBind(); // agrega los datos al dropdown

        }

        public void CargarGridView_Empleados(string cargo, string distrito)
        {
            DataView vista = EMP.ObtenerEmpleado(cargo, distrito);
            gvEmpleado.DataSource = vista;
            gvEmpleado.DataBind(); // agrega los datos al gridview
        }

        protected void btnfiltrar_Click(object sender, EventArgs e)
        {
            string cargo, distrito;

            cargo = ddlcargo.SelectedItem.ToString();
            distrito = ddldistrito.SelectedItem.ToString();
            CargarGridView_Empleados(cargo, distrito);
        }
    }
}
