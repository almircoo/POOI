using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace POO_Repaso
{
    public partial class FrmEmpleado : System.Web.UI.Page
    {
        EmpleadoADO EMP = new EmpleadoADO();
        string rutaArchivo;
        protected void Page_Load(object sender, EventArgs e)
        {
           rutaArchivo= @"C:\Cibertec\empleados.json";
        }

        protected void btnBD_Click(object sender, EventArgs e)
        {
            var empleados = EMP.ObtenerListaBD();
            EMP.GuardarAchivo(rutaArchivo, empleados);
            gvBD.DataSource = empleados;

            gvBD.DataBind();
        }

        protected void btnJson_Click(object sender, EventArgs e)
        {
            var empleados = EMP.LeerArchivo(rutaArchivo);
            gvJson.DataSource = empleados;

            gvJson.DataBind();
        }

        protected void bntinsertar_Click(object sender, EventArgs e)
        {
            Empleados emp = new Empleados()
            {
                code = int.Parse(txtcodigo.Text),
                nombres = txtnombres.Text,
                apellidos = txtapellidos.Text,
                email = txtcorreo.Text,
                salario = decimal.Parse(txtsueldo.Text)

            };

            EMP.InsertarEmpleado(emp);
            gvBD.DataSource = EMP.ObtenerListaBD();
            gvBD.DataBind();

        }

        protected void btnactualizar_Click(object sender, EventArgs e)
        {
            Empleados emp = new Empleados()
            {
                code = int.Parse(txtcodigo.Text),
                nombres = txtnombres.Text,
                apellidos = txtapellidos.Text,
                email = txtcorreo.Text,

            };

            EMP.InsertarEmpleado(emp);
            gvBD.DataSource = EMP.ObtenerListaBD();
            gvBD.DataBind();
        }

        protected void btneliminar_Click(object sender, EventArgs e)
        {
            int codigo = int.Parse(txtcodigo.Text);

            EMP.EliminarUsuario(codigo);

            gvBD.DataSource = EMP.ObtenerListaBD();

            gvBD.DataBind();
        }
    }
}