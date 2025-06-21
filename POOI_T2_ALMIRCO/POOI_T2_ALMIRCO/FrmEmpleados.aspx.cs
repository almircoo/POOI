using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace POOI_T2_ALMIRCO
{
    public partial class FrmEmpleados : System.Web.UI.Page
    {
        EmpleadosADO AE = new EmpleadosADO();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCargos();
            }
        }

        protected void btnempleados_Click(object sender, EventArgs e)
        {
            gvempleados.DataSource = AE.ObtenerDatos();
            gvempleados.DataBind();

        }

        protected void btneliminar_Click(object sender, EventArgs e)
        {
            int IdEmpelado;
            IdEmpelado = int.Parse(textIdEmpleado.Text);
            AE.EliminarEmpleado(IdEmpelado);
            gvempleados.DataSource = AE.ObtenerDatos();
            gvempleados.DataBind();
        }

        protected void btnagregarEmpleado_Click(object sender, EventArgs e)
        {
            Empleados nuevoEmpleado = new Empleados()
            {
               
                NomEmpleado = txtnombres.Text,
                ApeEmpleado = txtapellido.Text,
                DirEmpleado = txtdireccion.Text,
                IdCargo = int.Parse(ddlCargo.SelectedValue)
            };
            bool resultado = AE.InsertarEmpleado(nuevoEmpleado);

            if (resultado) 
            {
                lblmensaje.Text = "Empleado agregado correctamente.";
                lblmensaje.ForeColor = System.Drawing.Color.Green;

                // Limpia campos
                LimpiarCampos();

                // Actualiza el GridView
                CargarEmpleados();
            }
            else
            {
                lblmensaje.Text = "Error al agregar el empleado.";
                lblmensaje.ForeColor = System.Drawing.Color.Red;
            }

        }

        private void CargarCargos()
        {
            string cadena = "Data Source = .; Initial Catalog=NEGOCIOS; Integrated Security=True; User ID=sa; Password=Heysol12";

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("SELECT idcargo, desCargo FROM Cargos", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                ddlCargo.DataSource = dr;
                ddlCargo.DataValueField = "idcargo"; // Valor que se guarda
                ddlCargo.DataTextField = "desCargo"; // Texto visible
                ddlCargo.DataBind();

                ddlCargo.Items.Insert(0, new ListItem("-- Seleccione un cargo --", ""));
            }
        }

        private void CargarEmpleados()
        {
            try
            {
                List<Empleados> listaEmpleados = AE.ObtenerDatos();
                gvempleados.DataSource = listaEmpleados;
                gvempleados.DataBind();
            }
            catch (Exception ex)
            {
                lblmensaje.Text = "Error al cargar empleados: " + ex.Message;
                lblmensaje.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void LimpiarCampos()
        {
            txtidempleado.Text = "";
            txtnombres.Text = "";
            txtapellido.Text = "";
            txtdireccion.Text = "";
            ddlCargo.SelectedIndex = 0;
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtidempleado.Text))
            {
                lblmensaje.Text = "Debe seleccionar un empleado para actualizar.";
                return;
            }

            Empleados emp = new Empleados()
            {
                IdEmpleado = int.Parse(txtidempleado.Text),
                ApeEmpleado = txtapellido.Text,
                NomEmpleado = txtnombres.Text,
                DirEmpleado = txtdireccion.Text,
                IdCargo = int.Parse(ddlCargo.SelectedValue)
            };

            EmpleadosADO ado = new EmpleadosADO();
            bool resultado = ado.ActualizarEmpleado(emp);

            if (resultado)
            {
                lblmensaje.Text = "Empleado actualizado correctamente.";
                CargarEmpleados();
            }
            else
            {
                lblmensaje.Text = "Error al actualizar empleado.";
            }
        }

        protected void gvempleados_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvempleados.SelectedRow;

            txtidempleado.Text = row.Cells[1].Text;
            txtapellido.Text = row.Cells[2].Text;
            txtnombres.Text = row.Cells[3].Text;
            txtdireccion.Text = row.Cells[4].Text;

            // Buscar y seleccionar el cargo
            string cargoNombre = row.Cells[5].Text;

            ddlCargo.ClearSelection();
            ListItem item = ddlCargo.Items.FindByText(cargoNombre);
            if (item != null)
                item.Selected = true;
        }
    }
}