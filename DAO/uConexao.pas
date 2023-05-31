unit uConexao;

interface

uses
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLiteWrapper,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TConexao = class
  private
    FConexao: TFDConnection;
    const BANCO_DADOS = 'banco.db';
    class var FInstancia: TConexao;
    constructor Create;
    procedure CriarArquivoBanco;
  public
    destructor Destroy; override;
    function CriarQuery: TFDQuery;
    class function GetInstancia: TConexao;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils;

constructor TConexao.Create;
begin
  FInstancia := nil;

  FConexao := TFDConnection.Create(nil);

  try
    FConexao.Connected := False;
    FConexao.LoginPrompt := False;
    FConexao.DriverName := 'SQLITE';
    FConexao.Params.Values['OpenMode'] := 'ReadWrite';

//    CriarArquivoBanco;

    {$IFDEF MSWINDOWS}
      FConexao.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\' + BANCO_DADOS;
    {$ELSE}
      FConexao.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, BANCO_DADOS);
    {$ENDIF}

    FConexao.Open;
  except
    raise Exception.Create('Falha ao acessar banco de dados!');
  end;
end;

destructor TConexao.Destroy;
begin
  FConexao.Free;
  inherited;
end;

procedure TConexao.CriarArquivoBanco;
var
  LDiretorio: String;
begin
  {$IFDEF MSWINDOWS}
    LDiretorio := System.SysUtils.GetCurrentDir;
  {$ELSE}
    LDiretorio := TPath.GetDocumentsPath;
  {$ENDIF}

  ForceDirectories(LDiretorio);

  if not FileExists(LDiretorio + '\' + BANCO_DADOS) then
     FileCreate(LDiretorio + '\' + BANCO_DADOS);
end;

function TConexao.CriarQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConexao;
end;

class function TConexao.GetInstancia: TConexao;
begin
  if FInstancia = nil then
    FInstancia := TConexao.Create;

  Result := FInstancia;
end;

end.