<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="CargadorTime.aspx.cs" Inherits="UI.Web.CargadorTime" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.2.Web.WebForms" Namespace="DevExpress.XtraReports.Web" TagPrefix="dxxr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function onInit(s, e) {
            //viewer.OpenReport("PivotGrid");
        }
        function onEndCallback(s, e) {
            //viewer.Close();
            //viewer.OpenReport("PivotGrid");
        }

         function OnClick(s, e, catCiaCtaID) {
             Popup.Show();
         }
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
    </script>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Cargador Salarios"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="956px">
        <Items>
            <dx:LayoutGroup ColCount="10" ColSpan="1" ColumnCount="10" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Descripción Planilla" ColSpan="1" Name="Referencia">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E7" runat="server">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Inicial          " ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Final" ColSpan="1" Name="FechaFinal" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                    <DateRangeSettings MaxLength="10" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                    <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                    <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                    <BackgroundImage ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>

                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM me.[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLPaquetes" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="select paquete, paquete + '-' + descripcion descripcion 
from me.decosol.PAQUETE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
     <br />
    <asp:SqlDataSource ID="SQLBux" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="SELECT CODIGO_EMPLEADO,ANO,MES,CENTRO_COSTO,SALARIO,CARGA_SOCIAL,BONO
  FROM [PORTAL].[Time].[BUX]" >
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
         
                   &nbsp;<dx:ASPxGridView ID="GridRenta" runat="server" 
             AutoGenerateColumns="False" 
                    DataSourceID="SQLBux" 
                    ClientInstanceName="grid" KeyFieldName="CODIGO_EMPLEADO">
                    <ImagesFilterControl>
                       </ImagesFilterControl>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CODIGO_EMPLEADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ANO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MES" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2" ReadOnly="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALARIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CARGA_SOCIAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BONO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                    </Columns>
<Styles GroupButtonWidth="28">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
                    </Styles>

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

                    <Paddings Padding="1px" />

<Images SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css">
    <LoadingPanelOnStatusBar Url="~/App_Themes/SoftOrange/GridView/gvLoadingOnStatusBar.gif">
    </LoadingPanelOnStatusBar>
    <LoadingPanel Url="~/App_Themes/SoftOrange/GridView/Loading.gif">
    </LoadingPanel>
</Images>

<Settings ShowFilterRow="True" ShowFilterBar="Visible"></Settings>

<StylesEditors>
    <CalendarHeader Spacing="1px">
    </CalendarHeader>
<ProgressBar Height="29px"></ProgressBar>
</StylesEditors>

                    <SettingsEditing Mode="Inline" />
                    <SettingsBehavior ConfirmDelete="True" />
</dx:ASPxGridView>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server" FileName="CargarRenta"
                    GridViewID="GFile">
                </dx:ASPxGridViewExporter>
                </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Seleccione el archivo excel a cargar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" 
                    CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" 
                    NavigateUrl="~/Ejemplos/CargaExactus.xls" 
                    Text="Formato de ejemplo para cargar reporte Buxis" />
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxUploadControl ID="Upload" runat="server" Height="120px" ShowProgressPanel="True"
                    ShowUploadButton="True" Width="578px" OnFileUploadComplete="Upload_FileUploadComplete1">
                    <ClientSideEvents FileUploadComplete="function(s, e) {
	 if( e.isValid)
        { memo.SetText(e.callbackData);
          grid.PerformCallback();
        }

}" />
                </dx:ASPxUploadControl>
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
        <tr>
            <td>
                <dx:ASPxMemo ID="Memo" runat="server" CssFilePath="~/App_Themes/Red Wine/{0}/styles.css"
                    CssPostfix="RedWine" Height="168px" ReadOnly="True" Width="480px" ClientInstanceName="memo">
                    <ValidationSettings>
                        <ErrorImage Url="~/App_Themes/Red Wine/Editors/edtError.png" />
                        <ErrorFrameStyle ImageSpacing="4px">
                            <ErrorTextPaddings PaddingLeft="4px" />
                        </ErrorFrameStyle>
                    </ValidationSettings>
                </dx:ASPxMemo>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>



             </asp:Content>
