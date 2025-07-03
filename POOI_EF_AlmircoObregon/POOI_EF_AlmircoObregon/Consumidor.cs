using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POOI_EF_AlmircoObregon
{
    public class Consumidor
    {
        public string IdCons { get; set; }
        public string NomCons { get; set; }
        public string ApeCons { get; set; }
        public string EmailCons { get; set; }
        public string IdPais { get; set; }
        public string NombrePais { get; set; } // Para mostrar en la lista
        public string FonoCons { get; set; }

        public Consumidor() { }
    }
}