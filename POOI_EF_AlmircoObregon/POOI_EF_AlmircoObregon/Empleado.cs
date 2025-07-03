using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POOI_EF_AlmircoObregon
{
    public class Empleado
    {
        public int IdEmpleado { get; set; }
        public string NombreCompletoEmpleado { get; set; }
        public int CantidadPedidos { get; set; }

        public Empleado() { }

    }
}