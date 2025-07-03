using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace POOI_EF_AlmircoObregon
{
    public partial class FrmConsumidores : System.Web.UI.Page
    {
        ConsumidorADO AC = new ConsumidorADO();

        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPaises();
                CargarConsumidores();
            }
        }
       
        //carga todos los datos al dropdown del DB- procedure
        private void CargarPaises()
        {
            ddlPais.DataSource = AC.ListarPaises();
            ddlPais.DataBind();
            ddlPais.Items.Insert(0, new ListItem("Paises", ""));
        }
        // craga todos los datos de consumidores
        private void CargarConsumidores()
        {
            gvConsumidores.DataSource = AC.ListarConsumidores();
            gvConsumidores.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            lblError.Text = "";
            try
            {
                Consumidor nuevoConsumidor = new Consumidor
                {
                    IdCons = txtIdCons.Text.Trim(),
                    NomCons = txtNomCons.Text.Trim(),
                    ApeCons = txtApeCons.Text.Trim(),
                    EmailCons = txtEmailCons.Text.Trim(),
                    IdPais = ddlPais.SelectedValue,
                    FonoCons = txtFonoCons.Text.Trim()
                };

                AC.AgregarConsumidor(nuevoConsumidor);
                lblMensaje.Text = "Consumidor agregado exitosamente.";
                LimpiarCampos();
                CargarConsumidores();

            }
            catch (InvalidOperationException bizEx)
            {
                lblError.Text = bizEx.Message;
                LimpiarCampos();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al agregar consumidor: " + ex.Message;
                LimpiarCampos();
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            lblError.Text = "";
            try
            {
                Consumidor consumidorActualizado = new Consumidor
                {
                    IdCons = txtIdCons.Text.Trim(),
                    NomCons = txtNomCons.Text.Trim(),
                    ApeCons = txtApeCons.Text.Trim(),
                    EmailCons = txtEmailCons.Text.Trim(),
                    IdPais = ddlPais.SelectedValue,
                    FonoCons = txtFonoCons.Text.Trim()
                };

                AC.ActualizarConsumidor(consumidorActualizado);
                lblMensaje.Text = "Consumidor actualizado exitosamente.";

                LimpiarCampos();
                CargarConsumidores();
            }
            catch (InvalidOperationException bixEx)
            {
                lblError.Text = bixEx.Message;
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al actualizar consumidor: " + ex.Message;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            lblError.Text = "";
            try
            {
                string idConsEliminar = txtIdCons.Text.Trim();
                if (string.IsNullOrEmpty(idConsEliminar))
                {
                    lblError.Text = "Ingrese el ID del consumidor a eliminar.";
                    return;
                }
                AC.EliminarConsumidor(idConsEliminar);

                lblMensaje.Text = "Consumidor eliminado exitosamente.";
                LimpiarCampos();
                CargarConsumidores();
            }
            catch (InvalidOperationException bixEx)
            {
                lblError.Text = bixEx.Message;
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al eliminar consumidor: " + ex.Message;
            }
        }

        // limpiar los campos
        private void LimpiarCampos()
        {
            txtIdCons.Text = "";
            txtNomCons.Text = "";
            txtApeCons.Text = "";
            txtEmailCons.Text = "";
            ddlPais.SelectedIndex = 0;
            txtFonoCons.Text = "";
        }

    }
}