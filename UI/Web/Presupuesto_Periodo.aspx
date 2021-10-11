﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Periodo.aspx.cs" Inherits="UI.Web.Presupuesto_Periodo" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Presupuesto Periodos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="80px" Theme="SoftOrange" Width="411px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
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
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLPeriodo" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ANO, PERIODO, ESTADO_PRESUPUESTO, ESTADO_FORECAST
  FROM [PORTAL].[Presupuesto].[PERIODOS]
  order by 1" DeleteCommand="DELETE [PORTAL].[Presupuesto].[PAIS]
WHERE COD_PAIS = @COD_PAIS" InsertCommand="INSERT INTO [PORTAL].[Presupuesto].[PERIODOS]
           (ANO, PERIODO, ESTADO_PRESUPUESTO, ESTADO_FORECAST)
     VALUES (@ANO, @PERIODO, @ESTADO_PRESUPUESTO, @ESTADO_FORECAST)" UpdateCommand="Update [PORTAL].[Presupuesto].[PERIODOS]
set PERIODO = @PERIODO, ESTADO_PRESUPUESTO = @ESTADO_PRESUPUESTO, ESTADO_FORECAST = @ESTADO_FORECAST
WHERE  ANO= @ANO">
        <DeleteParameters>
            <asp:Parameter Name="COD_PAIS" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ANO" />
            <asp:Parameter Name="PERIODO" />
            <asp:Parameter Name="ESTADO_PRESUPUESTO" />
            <asp:Parameter Name="ESTADO_FORECAST" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PERIODO" />
            <asp:Parameter Name="ESTADO_PRESUPUESTO" />
            <asp:Parameter Name="ESTADO_FORECAST" />
            <asp:Parameter Name="ANO" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView2" FileName="Rubros_Contables" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLPeriodo" KeyFieldName="ANO" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ANO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PERIODO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO_PRESUPUESTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                <PropertiesCheckEdit ValueChecked="A" ValueType="System.String" ValueUnchecked="C">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO_FORECAST" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                <PropertiesCheckEdit ValueChecked="A" ValueType="System.String" ValueUnchecked="C">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
