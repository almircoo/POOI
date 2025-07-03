using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POO_Repaso
{
    public class Empleados:Persona
    {
        public int code { get; set; }
        public decimal salario { get; set; }

        public Empleados() { }
    }
}