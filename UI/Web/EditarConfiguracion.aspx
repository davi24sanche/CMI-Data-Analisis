﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="EditarConfiguracion.aspx.cs" Inherits="UI.Web.EditarConfiguracion" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var passwordMinLength = 6;
        function GetPasswordRating(password) {
            var result = 0;
            if (password) {
                result++;
                if (password.length >= passwordMinLength) {
                    if (/[a-z]/.test(password))
                        result++;
                    if (/[A-Z]/.test(password))
                        result++;
                    if (/\d/.test(password))
                        result++;
                    if (!(/^[a-z0-9]+$/i.test(password)))
                        result++;
                }
            }
            return result;
        }
        function OnPasswordTextBoxInit(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassChanged(s, e) {
            ApplyCurrentPasswordRating();
        }
        function ApplyCurrentPasswordRating() {
            var password = passwordTextBox.GetText();
            var passwordRating = GetPasswordRating(password);
            ApplyPasswordRating(passwordRating);
        }
        function ApplyPasswordRating(value) {
            ratingControl.SetValue(value);
            switch (value) {
                case 0:
                    ratingLabel.SetValue("Password safety");
                    break;
                case 1:
                    ratingLabel.SetValue("Too simple");
                    break;
                case 2:
                    ratingLabel.SetValue("Not safe");
                    break;
                case 3:
                    ratingLabel.SetValue("Normal");
                    break;
                case 4:
                    ratingLabel.SetValue("Safe");
                    break;
                case 5:
                    ratingLabel.SetValue("Very safe");
                    break;
                default:
                    ratingLabel.SetValue("Password safety");
            }
        }
        function GetErrorText(editor) {
            if (editor === passwordTextBox) {
                if (ratingControl.GetValue() === 1)
                    return "The password is too simple";
            } else if (editor === confirmPasswordTextBox) {
                if (passwordTextBox.GetText() !== confirmPasswordTextBox.GetText())
                    return "The password you entered do not match";
            }
            return "";
        }
        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }
        }
        function onControlsInitialized(s, e) {
            FormLayout.AdjustControl();
            var controls = ASPxClientControl.GetControlCollection().GetControlsByPredicate(function (c) {
                return c.GetParentControl() === FormLayout;
            });
            for (var i = 0; i < controls.length; i++) {
                var valEvt = controls[i].Validation;
                if (valEvt)
                    valEvt.AddHandler(onValidation);
            }
        }
        function onValidation(s, e) {
            setTimeout(function () { FormLayout.AdjustControl(); }, 0);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2">
        <Paddings PaddingBottom="30" PaddingTop="10" />

        <Items>
            <dx:LayoutGroup Caption="Editar Configuración" GroupBoxDecoration="Box" ColumnCount="1">

                <Items>

                    <dx:LayoutItem Caption="ID" Name="LiID">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxHiddenField ID="IdConfiguracion" runat="server">
                                </dx:ASPxHiddenField>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Empresa" Name="LiEmpresa">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbEmpresas" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Tipo" Name="LiTipo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbTipo" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                    <Items>
                                        <dx:ListEditItem Text="Débito" Value="S" Selected="True" />
                                        <dx:ListEditItem Text="Crédito" Value="H" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Concepto" Name="LiConcepto">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbConcepto" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Centro Costo" Name="LiCentroCosto">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCentroCosto" runat="server" NullText="Centro de Costo" Width="100%" CssClass="maxWidth" MaxLength="20">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Nuevo Centro Costo" Name="LiNuevoCentroCosto">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNuevoCentroCosto" runat="server" NullText="Centro de Costo" Width="100%" CssClass="maxWidth" MaxLength="20">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cuenta Contable" Name="LiCuentaContable">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCuentaContable" runat="server" NullText="Cuenta Contable" Width="100%" CssClass="maxWidth" MaxLength="20">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Nueva Cuenta Contable" Name="LiNuevoCuentaContable">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNuevaCuentaContable" runat="server" NullText="Cuenta Contable" Width="100%" CssClass="maxWidth" MaxLength="20">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" Width="32px" OnClick="Lform_E3_Click">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                                <dx:ASPxButton ID="btnCancelar" runat="server" Height="32px" Width="32px" AutoPostBack="False" OnClick="btnCancelar_Click" EnableClientSideAPI="True">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Menu/Cerrar_Sesion_Hover.png" Repeat="NoRepeat" VerticalPosition="center" />
                                    <ClientSideEvents Click="function(s,e){ document.location.href='ConfiguracionCuentaCentro.aspx'; }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/SaveAll_32x32.png">
                        </TabImage>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
       
        </Items>
    </dx:ASPxFormLayout>

    <dx:ASPxPopupControl ID="PError" runat="server" Height="130px" Width="363px" HeaderText="Error"  ClientInstanceName="PError" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" Text="Ocurrió un error en el registro, por favor volver a intentar." style="margin-left: 7px" Width="300px">
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

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PError.Hide(); }" />
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

    <dx:ASPxPopupControl ID="PAdvertencia" runat="server" Height="130px" Width="363px" HeaderText="Error"  ClientInstanceName="PAdvertencia" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Ya existe una configuración con la misma empresa, tipo y concepto." style="margin-left: 7px" Width="300px">
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

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PAdvertencia.Hide(); }" />
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