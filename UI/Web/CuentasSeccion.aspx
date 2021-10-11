<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="CuentasSeccion.aspx.cs" Inherits="UI.Web.CuentasSeccion" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .auto-style3 {
            width: 128px;
        }
        </style>
       <script type="text/javascript">
             var command;
             var commandcbp;



         var textSeparator = ";";
         function updateText() {
             var selectedItems = checkListBox.GetSelectedItems();
             checkComboBox.SetText(getSelectedItemsText(selectedItems));
             
         }
         function synchronizeListBoxValues(dropDown, args) {
             checkListBox.UnselectAll();
             var texts = dropDown.GetText().split(textSeparator);
             var values = getValuesByTexts(texts);
             checkListBox.SelectValues(values);
             updateText(); // for remove non-existing texts
         }
         function getSelectedItemsText(items) {
             var texts = [];
             for (var i = 0; i < items.length; i++)
                 texts.push(items[i].text);
             return texts.join(textSeparator);
         }
         function getValuesByTexts(texts) {
             var actualValues = [];
             var item;
             for (var i = 0; i < texts.length; i++) {
                 item = checkListBox.FindItemByText(texts[i]);
                 if (item != null)
                     actualValues.push(item.value);
             }
             return actualValues;
         }

        function onBeginCallback(s, e) {
            command = e.command;
        }

        function onEndCallback(s, e) {
            if (command == "") {
                s.SetText(s.cpText);
                s.cpText = null;
            }
        }

        function OnSelectedIndexChangedCallback(s, e) {
            var n = CBListaAbuelo.GetText().length;
             if (n > 4) {
                 tbnombreabuelo.SetText(CBListaAbuelo.GetText().substring(4));
             } else {
                 tbnombreabuelo.SetText("");
             }
             CBListaPadre.PerformCallback(CBListaAbuelo.GetValue());
        }

            function onTextChangedcbp(s, e) {
               // CBListaPadre.PerformCallback(CBListaPadre.GetText());
            }

            function onBeginCallbackcbp(s, e) {
                commandcbp = e.command;
            }

            function onEndCallbackcbp(s, e) {
                if (commandcbp == "") {
                    s.SetText(s.cpTextcbp);
                    s.cpTextcbp = null;
                }
            }

            function OnSelectedIndexChangedCallbackcbp(s, e) {
                var n = CBListaPadre.GetText().length;
                if (n > 4) {
                    tbnombrepadre.SetText(CBListaPadre.GetText().substring(4));
                } else {
                    tbnombrepadre.SetText("");
                }

              }



        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Asignar Sección y Acepta presupuesto"></asp:Label>
    &nbsp;<br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1149px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="10" ColSpan="1" ColumnCount="10" Caption="Defina Parametros" RowSpan="2">
                <Items>
                     <dx:LayoutItem Caption="Seleccione compañia" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="ASPxDropDownEdit1" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                       <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn"
                                           runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                          <FilteringSettings ShowSearchUI="true"/>
                                          <Border BorderStyle="None" />
                                          <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
            </dx:ASPxListBox>
            <table style="width: 100%">
                <tr>
                    <td style="padding: 4px">
                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                            <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown(); }" />
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
        </DropDownWindowTemplate>
        <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
          </dx:ASPxDropDownEdit>                            </dx:LayoutItemNestedControlContainer>
          </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
         </dx:LayoutItem>
                    <dx:LayoutItem Caption="Rango de Cuenta Inicial" ColSpan="1" Name="TXCuentaIni" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E5" runat="server">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Rango de Cuenta Final" ColSpan="1"  Name="TXCuentaFin" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E6" runat="server">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

 


                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

        <table style="width: 496px; height: 192px">
        <tr>
            <td>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

            </td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Modifique las Secciones en el siguiente cuadro: &nbsp;&nbsp;&nbsp;
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" DataSourceID="DS_Cuentas" KeyFieldName="CIA_CUENTA" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
                    <SettingsPager NumericButtonCount="30" PageSize="30">
                    </SettingsPager>
                    <SettingsEditing Mode="Batch">
                    </SettingsEditing>
                    <Settings ShowFilterRow="True" />

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CIA_CUENTA" FixedStyle="Left" ReadOnly="True" Visible="false"
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CIA" FixedStyle="Left" ReadOnly="True"
                            VisibleIndex="1">
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" FixedStyle="Left" ReadOnly="True"
                            VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" FixedStyle="Left" VisibleIndex="3"  ReadOnly="True"
                            Width="100%">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SECCION" FixedStyle="Left" VisibleIndex="4"
                            Width="100%">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn FieldName="VALIDA_PRESUP_CR" FixedStyle="Left" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5" Width="100%">
                            <PropertiesCheckEdit ValueChecked="S" ValueType="System.String" ValueUnchecked="N">
                            </PropertiesCheckEdit>
                        </dx:GridViewDataCheckColumn>

                        <dx:GridViewDataTextColumn FieldName="U_AGRUP_EEFF" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6"  ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_AGRUP_NOM_CTA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_AGRUP_TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_C_ARESEP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CIA_INTERCOM" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CMI_MAPPING" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CODCASHFLOW" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CTA_INTERCOM" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_ENTITY" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_INTERCO_NON_INTECO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_LEDGER" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_MONEDA_GRUPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_MONEDA_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_ORDEN_EEFF" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_PAIS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_SOCASO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_SOCIEDAD_GL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_TIPOVALOR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23" ReadOnly="True">
                        </dx:GridViewDataTextColumn>

                    </Columns>
                    <StylesEditors>
                        <CalendarHeader Spacing="1px">
                        </CalendarHeader>
                        <ProgressBar Height="25px">
                        </ProgressBar>
                    </StylesEditors>
                    <ImagesEditors>
                        <DropDownEditDropDown >
                            <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_RedWine" />
                        </DropDownEditDropDown>
                    </ImagesEditors>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="DS_Cuentas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CUENTACONTABLE_CB4]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCuentaini" SessionField="PCuentaini24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCuentafin" SessionField="PCuentafin24" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server" PrintSelectCheckBox="True">
                </dx:ASPxGridViewExporter>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>


     <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea actualizar los campos de Sección y de Acepta Presupuesto?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style9"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTAceptar" runat="server" OnClick="BTAceptar_Click" Text="Aceptar" Width="80px">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
        </tr>
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>


    </asp:Content>
