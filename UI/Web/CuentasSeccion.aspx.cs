﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Collections;

namespace UI.Web
{
    public partial class CuentasSeccion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                Session["CBCia24"] = "";
                Session["PCuentaini24"] = "";
                Session["PCuentafin24"] = "";

                    }

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {


            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxDropDownEdit CBCiaOri = itemCiaOri.GetNestedControl() as ASPxDropDownEdit;


            LayoutItem itemCuentaIni = Lform.FindItemOrGroupByName("TXCuentaIni") as LayoutItem;
            ASPxTextBox txCuentaIni = itemCuentaIni.GetNestedControl() as ASPxTextBox;

            LayoutItem itemCuentaFin = Lform.FindItemOrGroupByName("TXCuentaFin") as LayoutItem;
            ASPxTextBox txCuentaFin = itemCuentaFin.GetNestedControl() as ASPxTextBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBCiaOri != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["CBCia24"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "";
                    Session["PCuentaini24"] = txCuentaIni.Value != null ? txCuentaIni.Value.ToString() : "";
                    Session["PCuentafin24"] = txCuentaFin.Value != null ? txCuentaFin.Value.ToString() : "";

                    DS_Cuentas.DataBind();
                 //   Buscar();
                }
                else
                {
                    Session["CBCia24"] = "X";
                }
            }

        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

           // DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotCompra.OptionsView.HideAllTotals();
            //System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteOrdenCompra.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotCompra.OptionsView.ShowAllTotals();
            Exportador.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {

            //ASPxPivotGridExp1.ExportToXlsx("DetalleCtaExp.xlsx");
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

        }

        protected void ExportExcel2_Click(object sender, EventArgs e)
        {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp2.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

        }

        protected void WriteToResponse(string fileName, bool saveAsFile, string fileFormat, System.IO.MemoryStream stream)
        {
            if (Page == null || Page.Response == null) return;
            string disposition = saveAsFile ? "attachment" : "inline";
            Response.Clear();
            Response.Buffer = false;
            Response.AppendHeader("Content-Type", string.Format("application/{0}", fileFormat));
            Response.AppendHeader("Content-Transfer-Encoding", "binary");
            Response.AppendHeader("Content-Disposition", string.Format("{0}; filename={1}", disposition, fileName));
            Response.BinaryWrite(stream.ToArray());
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();

        }

        /// <summary>
        /// 
        /// </summary>
        private void Buscar()
        {
            string Vmenu;
            LayoutItem itemCBcentro = Lform.FindItemOrGroupByName("CBCentro") as LayoutItem;
            ASPxComboBox CBcentro = itemCBcentro.GetNestedControl() as ASPxComboBox;
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);

            SqlDataReader MIDataReader;
            int Cerr = 0;
            string Merr = "OK";
            int RowIndice;
            try
            {

                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();
                //Oracle.DataAccess.Client.OracleCommand ComandoConsulta = new Oracle.DataAccess.Client.OracleCommand();

                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = "select CUENTA_CONTABLE from " + Session["CBCia24"] + ".centro_cuenta WhERE estado = 'A' and CENTRO_COSTO = '" + CBcentro.Value.ToString().ToUpper() + "'";
                ComandoConsulta.Connection = dbSQL;

                GPermisos.Selection.UnselectAll();

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        //var myString = rdr.GetString(0); //The 0 stands for "the 0'th column", so the first column of the result.
                                                         // Do somthing with this rows string, for example to put them in to a list
                        Vmenu = rdr.GetString(0); 
                        RowIndice = GPermisos.FindVisibleIndexByKeyValue(Vmenu);
                        GPermisos.Selection.SelectRow(RowIndice);
                    }
                }


//                MIDataReader = ComandoConsulta.ExecuteReader();
                // aspxboxlist.Text = "0"
                // GFlow.DataBind()
//                GPermisos.Selection.UnselectAll();

                //if (MIDataReader != null)
                //{
                //    while (MIDataReader.Read)
                //    {
                //        Vmenu = MIDataReader.GetValue(0).ToString;
                //        RowIndice = GPermisos.FindVisibleIndexByKeyValue(Vmenu);

                //        GPermisos.Selection.SelectRow(RowIndice);
                //    }
                //    MIDataReader.Close();
                //}
                ComandoConsulta = null/* TODO Change to default(_) if this is not a reference type */;
            }

            // GFlow.Selection.SelectAll()


            catch (Exception ex)
            {
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
        }



        private void Guardar()
        {
            string PUSuario = "";
            int Cerr = 0;
            string Merr = "OK";
            int ii = 0;
            string PActivar = "S";

            try
            {
                List<object> plist;
                ArrayList totalVals = new ArrayList();
                // plist = GPermisos.GetSelectedFieldValues(New String() {"ID_MENU"})
                plist = GPermisos.GetSelectedFieldValues("CUENTA_CONTABLE");


                //EjecutarSelectVista("Delete COM_USUARIOS_PERMISOS where USUARIO = '" + CBUsuarios.Value.ToString.ToUpper + "'");
                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
                ASPxComboBox CBCia = itemCiaOri.GetNestedControl() as ASPxComboBox;


                LayoutItem itemCBcentro = Lform.FindItemOrGroupByName("CBCentro") as LayoutItem;
                ASPxComboBox CBcentro = itemCBcentro.GetNestedControl() as ASPxComboBox;

                //  EjecutarborrarMenu(CBUsuarios.Value.ToString().ToUpper());

                foreach (string item in plist)
                    EjecutaActualizaAso(CBCia.Value.ToString().ToUpper(), item, CBcentro.Value.ToString().ToUpper(), PActivar);
                //EjecutarSelectVista("INSERT INTO COM_USUARIOS_PERMISOS (USUARIO, ID_MENU) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + item + "')");
                //EjecutarSelectVista("INSERT INTO COM_USUARIOS (USUARIO, NOMBRE, ORACLE) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + CBUsuarios.Value.ToString.ToUpper + "','S')");

                plist = GetUnselectedFieldValues(GPermisos, "CUENTA_CONTABLE");
                PActivar = "N";
                foreach (string item in plist)
                    EjecutaActualizaAso(CBCia.Value.ToString().ToUpper(), item, CBcentro.Value.ToString().ToUpper(), PActivar);

            }
            catch (Exception ex)
            {
            }
        }

        protected List<object> GetUnselectedFieldValues(ASPxGridView gridInstance, params string[] FieldNames)
        {
            List<object> list = new List<object>();
            for (int i = 0; i < gridInstance.VisibleRowCount; i++)
            {
                if (!gridInstance.Selection.IsRowSelected(i))
                {
                    list.Add(gridInstance.GetRowValues(i, FieldNames));
                }
            }
            return list;
        }


        private void EjecutarborrarMenu (string PUSUARIO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.PORTAL_DELETE_PERMISOS", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUSUARIO", PUSUARIO);

                conn.Open();
                command.ExecuteNonQuery();
            }


        }


        private void EjecutaActualizaAso(string PCia, string PCuenta, string PCentro, string PActivar)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.[PORTAL_ADD_CENTROS_CUENTAS]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCia);
                command.Parameters.AddWithValue("@PCUENTA_CONTABLE", PCuenta);
                command.Parameters.AddWithValue("@PCENTROS_COSTOS", PCentro);
                command.Parameters.AddWithValue("@PACTIVAR", PActivar);


                conn.Open();
                command.ExecuteNonQuery();
            }


        }

        protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            //CurrentCiactaID = e.Parameter;
            //DetailsApply();
        }


        protected void Lform_E2_Click(object sender, EventArgs e)
        {
            Guardar();
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            //Guardar();
        }



        private void EjecutarCrearCentroCosto(string PUSUARIO, string PCIA, string PCENTRO1, string PCENTRO1_DESC, string PCENTRO2, string PCENTRO2_DESC, string PCENTRO3, string PCENTRO3_DESC, out string PERR, out string PMERR, string PsocentroCuentas)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_ADD_CENTROS_COSTOS]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                command.Parameters.AddWithValue("@PCIA", PCIA);
                command.Parameters.AddWithValue("@Pcentro1", PCENTRO1);
                command.Parameters.AddWithValue("@Pcentro1_desc", PCENTRO1_DESC);
                command.Parameters.AddWithValue("@Pcentro2", PCENTRO2);
                command.Parameters.AddWithValue("@Pcentro2_desc", PCENTRO2_DESC);
                command.Parameters.AddWithValue("@Pcentro3", PCENTRO3);
                command.Parameters.AddWithValue("@Pcentro3_desc", PCENTRO3_DESC);
                command.Parameters.AddWithValue("@PAsocuentas", PsocentroCuentas);

                command.Parameters.Add("@PErr", SqlDbType.Char, 10);
                command.Parameters["@PErr"].Direction = ParameterDirection.Output;




                //                command.Parameters.AddWithValue("@PErr", vErr);


                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;


//                command.Parameters.AddWithValue("@PMerr", VMerr);



                conn.Open();
                command.ExecuteNonQuery();


                vErr = (string)command.Parameters["@PErr"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }

            PERR = vErr;
            PMERR = VMerr;


        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
          /*  string PERR = "0";
            string PMerr = "ok";
            string PUser;
            string PCC1 = CBListaAbuelo.Text.Substring(0, 3);
            string PCC2 = CBListaPadre.Text.Substring(0, 3);
            string PCC3 = tbcentrocostohijo.Text;
            PUser = "sa";

            EjecutarCrearCentroCosto(PUser, Session["CBCia24"].ToString(), PCC1, tbnombreabuelo.Text, PCC2, tbnombrepadre.Text, PCC3, tbnombrehijo.Text, out PERR, out PMerr, CHAsocentroCuentas.Value.ToString());

            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                CBListaAbuelo.Text = null;
                tbnombreabuelo.Text = null;
                CBListaPadre.Text = null;
                tbnombrepadre.Text = null;
                tbcentrocostohijo.Text = null;
                tbnombrehijo.Text = null;

            }

    */

        }

        protected void ASPxCheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void Lform_E2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            Guardar();
        }


    }
}