using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


namespace POOI_web300625
{
    public class EmpleadosADO
    {
        private string cadenaConexion = "Data Source=.; Initial Catalog = Instituto; User Id=ejnej3e3ty7271jsjsDB; Password=Hed374734u3232eg2e62dbhod2dhhdvdsye2me2; Integrated Security = True";

        private SqlDataAdapter adapter;
        private DataSet dsC,dsD,  dsE;

        public EmpleadosADO()
        {
            dsC = new DataSet();
            dsD = new DataSet();
            dsE = new DataSet();

            CargarDatosCargo();
            CargarDatosDistrito();
            CargarDatosEmpleado();
        }

        public void CargarDatosCargo()
        {
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "select codigo, descripcion, estado from Cargo";
                adapter = new SqlDataAdapter(query, conn);
                adapter.Fill(dsC,"Cargo");


            }
        }

        public void CargarDatosDistrito()
        {
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "select code, nombre_distrito from Distrito";
                adapter = new SqlDataAdapter(query, conn);
                adapter.Fill(dsD, "Distrito");


            }
        }
        // DATA VIEW CARGO
        public DataView ObtenerCargos()
        {
            DataView vista = new DataView(dsC.Tables["Cargo"]);
            vista.Sort = "descripcion asc";
            return vista;

        }
        // DATA VIEW DISTRITO
        public DataView ObtenerDistrito()
        {
            DataView vista = new DataView(dsD.Tables["Distrito"]);
            vista.Sort = "nombre_distrito desc";
            return vista;
        }

        // EMPLEADOS
        public void CargarDatosEmpleado()
        {
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "GetEmpleadosFiltrados";
                adapter = new SqlDataAdapter(query, conn);
                adapter.Fill(dsE, "Empleados");


            }
        }

        public DataView ObtenerEmpleado(string cargo, string distrito)
        {
            DataView vista = new DataView(dsE.Tables["Empleados"]);
            
            if (!string.IsNullOrEmpty(cargo) && !string.IsNullOrEmpty(distrito))
            {
                // filtra por cargo y distrito
                if (cargo!= "Todos" && distrito!="Todos")
                {
                    vista.RowFilter = $"CargoDescripcion='{cargo}' and Distrito='{distrito}'";
                }
                
                
            }
            return vista;
        }
    }
}
