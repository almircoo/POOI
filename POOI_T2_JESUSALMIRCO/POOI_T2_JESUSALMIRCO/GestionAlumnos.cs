using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json; 
using System.IO;

namespace POOI_T2_JESUSALMIRCO
{
    public class GestionAlumnos
    {
        private string ruta;

        public GestionAlumnos(string rutaArchivo)
        {
            ruta = rutaArchivo;
        }

        private List<Alumnos> listaAlumnos = new List<Alumnos>();

        public List<Alumnos> CargarAlumnos()
        {
            if (File.Exists(ruta))
            {
                try
                {
                    string json = File.ReadAllText(ruta);
                    listaAlumnos = JsonConvert.DeserializeObject<List<Alumnos>>(json);
                    if (listaAlumnos == null) // 
                    {
                        listaAlumnos = new List<Alumnos>();
                    }
                }
                catch (JsonSerializationException ex)
                {
                    // 
                    //lblmensaje.Text = "Error deserializando JSON: {ex}";
                    listaAlumnos = new List<Alumnos>(); // inicia con lista vacia
                }
                catch (Exception ex)
                {
                    //Console.WriteLine($"Error al leer archivo: {ex.Message}");
                    listaAlumnos = new List<Alumnos>();
                }
            }
            else
            {
                listaAlumnos = new List<Alumnos>(); // si el arvchivo no existe inicia vacio
            }
            return listaAlumnos;
        }

        public void SerializarAlumnos(List<Alumnos> alumnosToSerialize)
        {
            try
            {
                string json = JsonConvert.SerializeObject(alumnosToSerialize, Formatting.Indented);
                File.WriteAllText(ruta, json);
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al serializar los datos: {ex.Message}");
            }
        }

        public List<Alumnos> ListarAlumnos()
        {
            return CargarAlumnos(); 
        }

        // verifica si se repite codiog de alumnos al agregar alumnos
        public bool AgregarAlumno(Alumnos nuevoAlumno)
        {
            listaAlumnos = CargarAlumnos(); 

            if (listaAlumnos.Any(a => a.Codigo.Equals(nuevoAlumno.Codigo, StringComparison.OrdinalIgnoreCase)))
            {
                return false; 
            }
            else
            {
                listaAlumnos.Add(nuevoAlumno);
                SerializarAlumnos(listaAlumnos); 
                return true; 
            }
        }

        public bool EliminarAlumno(string codigo)
        {
            listaAlumnos = CargarAlumnos(); 

            int initialCount = listaAlumnos.Count;
            listaAlumnos.RemoveAll(a => a.Codigo.Equals(codigo, StringComparison.OrdinalIgnoreCase));

            if (listaAlumnos.Count < initialCount)
            {
                SerializarAlumnos(listaAlumnos); 
                return true; 
            }
            return false; 
        }
    }
}