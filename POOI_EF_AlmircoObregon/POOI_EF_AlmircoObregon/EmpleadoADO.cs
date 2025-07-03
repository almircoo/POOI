using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace POOI_EF_AlmircoObregon
{
    public class EmpleadoADO
    {
        private string cadenaConexion = "Data Source=.; Initial Catalog = Negocios2024; User Id=idskdhsamsdayewDB; Password=He9232hdD2jeuTDLKEY; Integrated Security = True";
        public List<Empleado> ListarEmpleadosPedidosPorAnio(int anio)
        {
            List<Empleado> lista = new List<Empleado>();
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "usp_listar_empleados_pedidos_por_anio";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Anio", anio);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    lista.Add(new Empleado()
                    {
                        IdEmpleado = Convert.ToInt32(reader["IdEmpleado"]),
                        NombreCompletoEmpleado = reader["NombreCompletoEmpleado"].ToString(),
                        CantidadPedidos = Convert.ToInt32(reader["CantidadPedidos"])
                    });
                }
            }
            return lista;
        }
    }
}