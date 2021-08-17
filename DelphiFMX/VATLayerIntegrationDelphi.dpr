program VATLayerIntegrationDelphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {FormVATLayerDelphi};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormVATLayerDelphi, FormVATLayerDelphi);
  Application.Run;
end.
