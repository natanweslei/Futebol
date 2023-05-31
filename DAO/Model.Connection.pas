unit Model.Connection;

interface

uses
  FireDAC.DApt, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.UI.Intf,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,

  FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.Classes,

  System.IniFiles, System.SysUtils;

var
  FConnection : TFDConnection;

function Connect : TFDConnection;
procedure Disconect;

implementation

uses
  System.IOUtils;

function Connect : TFDConnection;
begin
    FConnection := TFDConnection.Create(nil);
    try
      FConnection.DriverName := 'SQLite';
      FConnection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    except on E: exception do
    end;

    FConnection.Connected := True;

    Result := FConnection;
end;

procedure Disconect;
begin
  if Assigned(FConnection) then
  begin
    if FConnection.Connected then
      FConnection.Connected := False;

    FConnection.Free;
  end;
end;


end.
