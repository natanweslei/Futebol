unit uDadosJogadorDAO;

interface

uses
  uConexao, uDadosJogadorModel, FireDAC.Comp.Client;

type
  TDadosJogadorDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;
    function ListarDadosJogadores: TFDQuery;
    function IncluirDadosJogador(ADadosJogadorModel: TDadosJogadorModel): Boolean;
    function AlterarDadosJogador(ADadosJogadorModel: TDadosJogadorModel): Boolean;
    function ExcluirDadosJogador(ADadosJogadorModel: TDadosJogadorModel): Boolean;
  end;

implementation

uses
  System.SysUtils;

constructor TDadosJogadorDAO.Create;
begin
   FConexao := TConexao.GetInstancia;
end;

function TDadosJogadorDAO.IncluirDadosJogador(ADadosJogadorModel: TDadosJogadorModel): Boolean;
var
  LQuery: TFDQuery;
begin
  Result := False;

  LQuery := FConexao.CriarQuery;
  try
    LQuery.SQL.Add('INSERT INTO JOGADORES(');
    LQuery.SQL.Add('  NOME');
//    LQuery.SQL.Add('  FOTO');
    LQuery.SQL.Add(')');
    LQuery.SQL.Add('VALUES(');
    LQuery.SQL.Add('  :NOME');
//    LQuery.SQL.Add('  :FOTO');
    LQuery.SQL.Add(')');

    LQuery.ParamByName('NOME').AsString := ADadosJogadorModel.Nome;
//    LQuery.ParamByName('FOTO').Assign(ADadosJogadorModel.Foto);

    Try
      LQuery.ExecSQL;
      Result := True;
    Except on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    End;
  finally
    LQuery.Free;
  end;
end;

function TDadosJogadorDAO.AlterarDadosJogador(ADadosJogadorModel: TDadosJogadorModel): Boolean;
var
  LQuery: TFDQuery;
begin
  Result := False;

  LQuery := FConexao.CriarQuery;
  try
    LQuery.SQL.Add('UPDATE JOGADORES SET');
    LQuery.SQL.Add('  NOME = :NOME,');
    LQuery.SQL.Add('  FOTO = :FOTO');
    LQuery.SQL.Add('WHERE JOGADOR_ID = :JOGADOR_ID');

    LQuery.ParamByName('NOME').AsString := ADadosJogadorModel.NOME;
    LQuery.ParamByName('FOTO').Assign(ADadosJogadorModel.FOTO);
    LQuery.ParamByName('JOGADOR_ID').AsInteger := ADadosJogadorModel.JOGADOR_ID;

    Try
      LQuery.ExecSQL;
      Result := True;
    Except on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    End;
  finally
    LQuery.Free;
  end;
end;

function TDadosJogadorDAO.ExcluirDadosJogador(ADadosJogadorModel: TDadosJogadorModel): Boolean;
var
  LQuery: TFDQuery;
begin
  Result := False;

  LQuery := FConexao.CriarQuery;
  try
    LQuery.SQL.Add('DELETE FROM JOGADORES');
    LQuery.SQL.Add('WHERE JOGADOR_ID = :JOGADOR_ID');

    LQuery.ParamByName('JOGADOR_ID').AsInteger := ADadosJogadorModel.JOGADOR_ID;

    Try
      LQuery.ExecSQL;
      Result := True;
    Except on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    End;
  finally
    LQuery.Free;
  end;
end;

function TDadosJogadorDAO.ListarDadosJogadores: TFDQuery;
begin
  Result := FConexao.CriarQuery;
  Result.SQL.Add('SELECT * FROM JOGADORES');
  Result.Open;
end;

end.
