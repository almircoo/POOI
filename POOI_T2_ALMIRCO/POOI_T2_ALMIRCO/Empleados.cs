using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POOI_T2_ALMIRCO
{
    public class Empleados
    {
        public int IdEmpleado { get; set; }
        public string ApeEmpleado { get; set; }
        public string NomEmpleado { get; set; }
        public string DirEmpleado { get; set; }
        public string Cargo { get; set; }
        public int IdCargo { get; set; }

        public Empleados() { }// metodo sin parametros


    }
}