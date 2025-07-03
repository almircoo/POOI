using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POOI_web300625
{
    public class Empleados
    {
        public int code {  get; set; }
        public string nombres { get; set; }
        public string apellidos { get; set; }
        public string email { get; set; }
        public int id_cargo { get; set; }
        public int id_distrito { get; set; }
        public int salario { get; set; }

        public Empleados() { }
    }
}
