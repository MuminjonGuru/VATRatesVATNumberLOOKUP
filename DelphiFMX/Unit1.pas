unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.Controls.Presentation, FMX.Edit, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.StdCtrls, FMX.Objects, System.JSON, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo;

type
  TFormVATLayerDelphi = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    EdtAccKey: TEdit;
    EdtFormat: TEdit;
    EdtVatNumber: TEdit;
    RctData: TRectangle;
    LblValidVAT: TLabel;
    LblValidFormat: TLabel;
    LblQuery: TLabel;
    LblCountryCode: TLabel;
    LblVATNumber: TLabel;
    LblCompany: TLabel;
    LblAddress: TLabel;
    EdtValidVat: TEdit;
    EdtValidFormat: TEdit;
    EdtQuery: TEdit;
    EdtCountryCode: TEdit;
    EdtResVATNumber: TEdit;
    EdtCompany: TEdit;
    EdtAddress: TEdit;
    BtnSendRequest: TButton;
    RctSpecificVATRate: TRectangle;
    LblGETVATRate: TLabel;
    ChkBUseClientIPAddress: TCheckBox;
    BtnGETSpecificVATRate: TButton;
    Memo1: TMemo;
    procedure BtnSendRequestClick(Sender: TObject);
    procedure BtnGETSpecificVATRateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVATLayerDelphi: TFormVATLayerDelphi;

implementation

{$R *.fmx}

procedure TFormVATLayerDelphi.BtnGETSpecificVATRateClick(Sender: TObject);
begin
  RESTClient1.ResetToDefaults;
  RESTClient1.Accept := 'application/json';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient1.BaseURL := 'http://www.apilayer.net/api/rate';

  RESTResponse1.ContentType := 'application/json';

  // debug only
  var UseClientIP := '0';
  if ChkBUseClientIPAddress.IsChecked then
    UseClientIP := '1';


  RESTRequest1.Resource := Format('?access_key=%s&use_client_ip=%s&format=%s',
    [EdtAccKey.Text, UseClientIP, EdtFormat.Text]);

  RESTRequest1.Execute;

  Memo1.Text := RESTResponse1.Content;
end;

procedure TFormVATLayerDelphi.BtnSendRequestClick(Sender: TObject);
begin
  RESTClient1.ResetToDefaults;
  RESTClient1.Accept := 'application/json';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient1.BaseURL := 'http://www.apilayer.net/api/validate';

  RESTResponse1.ContentType := 'application/json';

  RESTRequest1.Resource := Format('?access_key=%s&vat_number=%s&format=%s',
    [EdtAccKey.Text, EdtVatNumber.Text, EdtFormat.Text]);

  RESTRequest1.Execute;

  var JSONValue := TJSONObject.ParseJSONValue(RESTResponse1.Content);
  try
    if JSONValue is TJSONObject then
    begin
      EdtValidVat.Text := JSONValue.GetValue<String>('valid');
      EdtValidFormat.Text := JSONValue.GetValue<String>('format_valid');
      EdtQuery.Text := JSONValue.GetValue<String>('query');
      EdtCountryCode.Text := JSONValue.GetValue<String>('country_code');
      EdtResVATNumber.Text := JSONValue.GetValue<String>('vat_number');
      EdtCompany.Text := JSONValue.GetValue<String>('company_name');
      EdtAddress.Text := JSONValue.GetValue<String>('company_address');
    end;
  finally
    JSONValue.Free;
  end;

end;

end.
