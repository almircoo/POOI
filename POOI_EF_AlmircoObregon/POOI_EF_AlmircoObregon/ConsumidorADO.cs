using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;



namespace POOI_EF_AlmircoObregon
{
    public class ConsumidorADO
    {
        private string cadenaConexion = "Data Source=.; Initial Catalog = Negocios2024; User Id=idskdhsamsdayewDB; Password=He9232hdD2jeuTDLKEY; Integrated Security = True";

        // Listar Consumidores
        public List<Consumidor> ListarConsumidores()
        {
            List<Consumidor> lista = new List<Consumidor>();
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "usp_listar_consumidor";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    lista.Add(new Consumidor()
                    {
                        IdCons = reader["idcons"].ToString(),
                        NomCons = reader["nomcons"].ToString(),
                        ApeCons = reader["apecons"].ToString(),
                        EmailCons = reader["emailcons"].ToString(),
                        IdPais = reader["idpais"].ToString(),
                        NombrePais = reader["NombrePais"].ToString(),
                        FonoCons = reader["fonocons"].ToString()
                    });
                }
            }
            return lista;
        }

        // Listar Países
        public List<Paises> ListarPaises()
        {
            List<Paises> lista = new List<Paises>();
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "usp_listar_paises";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    lista.Add(new Paises()
                    {
                        IdPais = reader["Idpais"].ToString(),
                        NombrePais = reader["NombrePais"].ToString()
                    });
                }
            }
            return lista;
        }

        // Agregar Consumidor
        public void AgregarConsumidor(Consumidor reg)
        {
            
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "usp_agrega_consumidor";
                
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@idcons", reg.IdCons);
                cmd.Parameters.AddWithValue("@nomcons", reg.NomCons);
                cmd.Parameters.AddWithValue("@apecons", reg.ApeCons);
                cmd.Parameters.AddWithValue("@emailcons", reg.EmailCons);
                cmd.Parameters.AddWithValue("@idpais", reg.IdPais);
                cmd.Parameters.AddWithValue("@fonocons", reg.FonoCons);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
            
        }

        // Actualizar Consumidor
        public void ActualizarConsumidor(Consumidor reg)
        {
            
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "usp_actualizar_consumidor";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@idcons", reg.IdCons);
                cmd.Parameters.AddWithValue("@nomcons", reg.NomCons);
                cmd.Parameters.AddWithValue("@apecons", reg.ApeCons);
                cmd.Parameters.AddWithValue("@emailcons", reg.EmailCons);
                cmd.Parameters.AddWithValue("@idpais", reg.IdPais);
                cmd.Parameters.AddWithValue("@fonocons", reg.FonoCons);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
            
        }

        // Eliminar Consumidor
        public void EliminarConsumidor(string idCons)
        {
            
            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                string query = "usp_eliminar_consumidor";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@idcons", idCons);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
            
        }

    }
}