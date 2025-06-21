using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;

namespace POOI_T2_JESUSALMIRCO
{
    public partial class FrmAlumnos : System.Web.UI.Page
    {

        private GestionAlumnos gestionAlumnos;
        string archivo = @"C:\\DB_SQL_Cibertec\alumnos.json";
        

        protected void Page_Load(object sender, EventArgs e)
        {
           
            //archivoJson = "C:\\DB_SQL_Cibertec\alumnos.json";
        }

        protected void btnagregaralumno_Click(object sender, EventArgs e)
        {
            //List<Usuario> usuarios = Leerusuarios();
            gestionAlumnos = new GestionAlumnos(archivo);

            Alumnos nuevo = new Alumnos(
                txtcodigo.Text,
                txtnombres.Text,
                textapellidos.Text,
                int.Parse(txtedad.Text),
                txtcorreo.Text,
                txtcarrera.Text
             );

            if (gestionAlumnos.AgregarAlumno(nuevo))
            {
                lblmensaje.Text = "Alumno agregado exitosamente.";
                LimpiarCampos();
                CargarDatosEnDataGridView(); 
            }
            else
            {
                lblmensaje.Text = "Error: El código de alumno ya existe.";
            }
        }


        private void CargarDatosEnDataGridView()
        {
            gestionAlumnos = new GestionAlumnos(archivo);
            try
            {
                List<Alumnos> alumnos = gestionAlumnos.ListarAlumnos();
                gvalumnos.DataSource = null; 
                gvalumnos.DataSource = alumnos;
                gvalumnos.DataBind();

                lblmensaje.Text = "Datos de alumnos cargados correctamente.";
            }
            catch (Exception ex)
            {
                lblmensaje.Text = $"Error al cargar datos: {ex.Message}";
            }
        }

        protected void btnserializar_Click(object sender, EventArgs e)
        {
            gestionAlumnos = new GestionAlumnos(archivo);
            try
            {
                gestionAlumnos.SerializarAlumnos(gestionAlumnos.ListarAlumnos());
                lblmensaje.Text = $"Datos almacenados correctamente en {archivo}.";
            }
            catch (Exception ex)
            {
                lblmensaje.Text = $"Error al serializar los datos: {ex.Message}";
            }
        }

        protected void btnverAlumnos_Click(object sender, EventArgs e)
        {
            gestionAlumnos = new GestionAlumnos(archivo);
            CargarDatosEnDataGridView();
        }

        protected void btneliminar_Click(object sender, EventArgs e)
        { 

            gestionAlumnos = new GestionAlumnos(archivo);
            if (File.Exists(archivo))
            {
                File.Delete(archivo);
                lblmensaje.Text = "Archivo eliminado!";
                gvalumnos.DataSource = null;
                gvalumnos.DataBind();
            }
        }

        private void LimpiarCampos()
        {
            txtcodigo.Text = "";
            txtnombres.Text = "";
            textapellidos.Text = "";
            txtedad.Text = "";
            txtcorreo.Text = "";
            txtcarrera.Text = "";
            lblmensaje.Text = ""; 
        }
    }
}