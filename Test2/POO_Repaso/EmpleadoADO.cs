using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Newtonsoft.Json;

namespace POO_Repaso
{
    public class EmpleadoADO
    {
        private string cadenaConexion = "Data Source=.; Initial Catalog = Instituto; User Id=idskdhsamsdayewDB; Password=He9232hdD2jeuTDLKEY; Integrated Security = True";

        public List<Empleados> ObtenerListaBD()

        {

            List<Empleados> empleados = new List<Empleados>();

            try
            {

                using (SqlConnection conn = new SqlConnection(cadenaConexion))

                {

                    string query = "select code, nombres, apellidos, email, salario from Empleados";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {

                        Empleados nuevo = new Empleados()
                        {

                            code = (int)reader["code"],
                            nombres = reader["nombres"].ToString(),
                            apellidos = reader["apellidos"].ToString(),
                            email = reader["email"].ToString(),
                            salario = (decimal)reader["salario"]

                        };

                        empleados.Add(nuevo);

                    }
                }

            }
            catch (Exception e)

            {
                Console.WriteLine("Error" + e.Message);
            }
            return empleados;

        }


        public void GuardarAchivo(string rutaArchivo, List<Empleados> empleados)
        {
            string json = JsonConvert.SerializeObject(empleados, Formatting.Indented);
            File.WriteAllText(rutaArchivo, json);

        }

        public List<Empleados> LeerArchivo(string rutaArchivo)
        {
            string json = File.ReadAllText(rutaArchivo);
            return JsonConvert.DeserializeObject<List<Empleados>>(json);

        }

        // insertar empelados
        public void InsertarEmpleado(Empleados e)
        {
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {

                string query = "insert into Empleados(nombres, apellidos, email, salario) values (@nombres, @apellidos, @email, @salario)";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@nombres", e.nombres);
                cmd.Parameters.AddWithValue("@apellidos", e.apellidos);
                cmd.Parameters.AddWithValue("@email", e.email);
                cmd.Parameters.AddWithValue("@salario", e.salario);

                conn.Open();

                cmd.ExecuteNonQuery();

            }
        }

        public void ActualizarEmpleado (Empleados empleado)
        {
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                // SQL UPDATE statement
                // WHERE clause is crucial to specify which record to update using its unique 'code'
                string query = "UPDATE Empleados SET nombres = @nombres, apellidos = @apellidos, email = @email, salario = @salario WHERE code = @code";

                SqlCommand cmd = new SqlCommand(query, conn);

                // Add parameters for the updated values
                cmd.Parameters.AddWithValue("@nombres", empleado.nombres);
                cmd.Parameters.AddWithValue("@apellidos", empleado.apellidos);
                cmd.Parameters.AddWithValue("@email", empleado.email);
                cmd.Parameters.AddWithValue("@salario", empleado.salario);
                // Add the parameter for the WHERE clause (to identify the employee)
                cmd.Parameters.AddWithValue("@code", empleado.code);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery(); // ExecuteNonQuery returns the number of rows affected

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine($"Empleado con código {empleado.code} actualizado exitosamente. Filas afectadas: {rowsAffected}");
                    }
                    else
                    {
                        Console.WriteLine($"No se encontró ningún empleado con el código {empleado.code} para actualizar.");
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine($"Error SQL al actualizar empleado: {ex.Message}");
                    Console.WriteLine($"SQL Error Code: {ex.Number}");
                    throw; // Re-throw for higher-level handling
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error general al actualizar empleado: {ex.Message}");
                    throw; // Re-throw
                }
            }
        }

        public void EliminarUsuario(int codigoEmpleado)
        {

            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                // SQL DELETE statement
                // WHERE clause is absolutely critical to specify which record to delete
                string query = "DELETE FROM Empleados WHERE code = @code";

                SqlCommand cmd = new SqlCommand(query, conn);

                // Add the parameter for the WHERE clause (to identify the employee to delete)
                cmd.Parameters.AddWithValue("@code", codigoEmpleado);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery(); // ExecuteNonQuery returns the number of rows affected

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine($"Empleado con código {codigoEmpleado} eliminado exitosamente. Filas afectadas: {rowsAffected}");
                    }
                    else
                    {
                        Console.WriteLine($"No se encontró ningún empleado con el código {codigoEmpleado} para eliminar.");
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine($"Error SQL al eliminar empleado: {ex.Message}");
                    Console.WriteLine($"SQL Error Code: {ex.Number}");
                    throw; // Re-throw for higher-level handling
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error general al eliminar empleado: {ex.Message}");
                    throw; // Re-throw
                }
            }
        }
    }
}