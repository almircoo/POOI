using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POOI_T2_JESUSALMIRCO
{
    public class Alumnos
    {
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public int Edad { get; set; }
        public String Correo { get; set; }
        public string Carrera { get; set; }

        public Alumnos(string codigo, string nombre, string apellido, int edad, string correo, string carrera)
        {
            Codigo = codigo;
            Nombre = nombre;
            Apellido = apellido;
            Edad = edad;
            Correo = correo;
            Carrera = carrera;
        }

        // constructor sin parametros
        //public Alumnos() { }
    }
}