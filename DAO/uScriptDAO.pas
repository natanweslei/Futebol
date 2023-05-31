unit uScriptDAO;

interface

uses
  uConexao;

type
  TScriptDAO = class
  private
    FConexao: TConexao;
    procedure CriarTabelaJogadores;
  public
    constructor Create;
    procedure CriarTabela;
  end;

implementation

uses
  FireDAC.Comp.Client,
  System.SysUtils;

constructor TScriptDAO.Create;
begin
  inherited;
  FConexao := TConexao.GetInstancia;
end;

procedure TScriptDAO.CriarTabela;
begin
  CriarTabelaJogadores;
end;

procedure TScriptDAO.CriarTabelaJogadores;
var
  LQuery: TFDQuery;
begin
  LQuery := FConexao.CriarQuery;
  try
    LQuery.SQL.Add('CREATE TABLE IF NOT EXISTS JOGADORES (');
	  LQuery.SQL.Add('  JOGADOR_ID INTEGER PRIMARY KEY AUTOINCREMENT,');
	  LQuery.SQL.Add('  NOME TEXT,');
	  LQuery.SQL.Add('  FOTO BLOB');
    LQuery.SQL.Add(');');

    try
      LQuery.ExecSQL;
    Except
      raise;
    end;
  finally
    LQuery.Free;
  end;
end;

end.
