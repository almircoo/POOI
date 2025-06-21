using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace POOI_T2_ALMIRCO
{
    public class EmpleadosADO
    {
        private string cadenaconexion = "Data Source = .; Initial Catalog=NEGOCIOS; Integrated Security=True; User ID=sa; Password=TuPassword";

        public List<Empleados> ObtenerDatos()

        {

            List<Empleados> empleados = new List<Empleados>();



            using (SqlConnection conn = new SqlConnection(cadenaconexion))

            {

                string query = "sp_ListarEmpleadosConCargo";

                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())

                {

                    Empleados nuevo = new Empleados()
                    {
                        IdEmpleado = (int)reader["IdEmpleado"],
                        ApeEmpleado = reader["ApeEmpleado"].ToString(),
                        NomEmpleado = reader["NomEmpleado"].ToString(),
                        DirEmpleado = reader["DirEmpleado"].ToString(),
                        Cargo = reader["Cargo"].ToString()
                    };
                    empleados.Add(nuevo);

                }
                return empleados;

            }
        }

        //metodo para insertar datos
        public bool InsertarEmpleado(Empleados emp)
        {
            using (SqlConnection conn = new SqlConnection(cadenaconexion))
            {
                string query = "INSERT INTO Empleados (ApeEmpleado, NomEmpleado, DirEmpleado, idCargo) VALUES (@Ape, @Nom, @Dir, @IdCargo)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Ape", emp.ApeEmpleado);
                    cmd.Parameters.AddWithValue("@Nom", emp.NomEmpleado);
                    cmd.Parameters.AddWithValue("@Dir", emp.DirEmpleado);
                    cmd.Parameters.AddWithValue("@IdCargo", emp.IdCargo);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            
        }

        public bool ActualizarEmpleado(Empleados emp)
        {
            using (SqlConnection conn = new SqlConnection(cadenaconexion))
            {
                string query = @"UPDATE Empleados 
                         SET ApeEmpleado = @Ape, 
                             NomEmpleado = @Nom, 
                             DirEmpleado = @Dir, 
                             idCargo = @IdCargo 
                         WHERE IdEmpleado = @IdEmpleado";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Ape", emp.ApeEmpleado);
                    cmd.Parameters.AddWithValue("@Nom", emp.NomEmpleado);
                    cmd.Parameters.AddWithValue("@Dir", emp.DirEmpleado);
                    cmd.Parameters.AddWithValue("@IdCargo", emp.IdCargo);
                    cmd.Parameters.AddWithValue("@IdEmpleado", emp.IdEmpleado);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        // clase para elimianr por codigo
        public void EliminarEmpleado(int idEmpleado)
        {
            using (SqlConnection conn = new SqlConnection(cadenaconexion))
            {
                // Basic DELETE statement
                string query = "DELETE FROM Empleados WHERE IdEmpleado = @IdEmpleado";
                using (SqlCommand command = new SqlCommand(query, conn))
                {
                    command.Parameters.AddWithValue("@IdEmpleado", idEmpleado);
                    conn.Open();
                    command.ExecuteNonQuery();

                }
            }
        }

    }
}