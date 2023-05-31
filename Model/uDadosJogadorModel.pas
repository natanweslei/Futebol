unit uDadosJogadorModel;

interface

uses
  System.Classes, uAmbienteController, FireDAC.Comp.Client, FMX.Graphics;

type
  TDadosJogadorModel = class
  private
    FJOGADOR_ID: Integer;
    FNome: string;
    FFoto: TBitmap;
    FAcao: TAcao;
    procedure SetJOGADOR_ID(const AJOGADOR_ID: Integer);
    procedure SetNome(const ANome: string);
    procedure SetFoto(const AFoto: TBitmap);
    procedure SetAcao(const AACao: TAcao);
  public
    constructor Create;
    destructor Destroy;override;
    property JOGADOR_ID: Integer read FJOGADOR_ID write SetJOGADOR_ID;
    property Nome: string read FNome write SetNome;
    property Foto: TBitmap read FFoto write SetFoto;
    property Acao: TAcao read FAcao write SetAcao;

    function Salvar(ADadosJogadorModel: TDadosJogadorModel): Boolean;
    function ListarDadosJogadores: TFDQuery;
  end;

implementation

uses
  uDadosJogadorDAO;

constructor TDadosJogadorModel.Create;
begin
  inherited;
  FFoto := TBitmap.Create;
end;

destructor TDadosJogadorModel.Destroy;
begin
  FFoto.Free;
  inherited;
end;


procedure TDadosJogadorModel.SetAcao(const AACao: TAcao);
begin
  FAcao := AACao;
end;

procedure TDadosJogadorModel.SetJOGADOR_ID(const AJOGADOR_ID: Integer);
begin
  FJOGADOR_ID := AJOGADOR_ID;
end;

procedure TDadosJogadorModel.SetNome(const ANome: string);
begin
  FNome := ANome;
end;

procedure TDadosJogadorModel.SetFoto(const AFoto: TBitmap);
begin
  FFoto.Assign(AFoto);
end;

function TDadosJogadorModel.Salvar(ADadosJogadorModel: TDadosJogadorModel): Boolean;
var
  LDadosJogadorDAO: TDadosJogadorDAO;
begin
  Result := False;

  LDadosJogadorDAO := TDadosJogadorDAO.Create;
  try
    case FAcao of
      taIncluir: Result := LDadosJogadorDAO.IncluirDadosJogador(ADadosJogadorModel);
      taAlterar: Result := LDadosJogadorDAO.AlterarDadosJogador(ADadosJogadorModel);
      taExcluir: Result := LDadosJogadorDAO.ExcluirDadosJogador(ADadosJogadorModel);
    end;
  finally
    LDadosJogadorDAO.Free;
  end;
end;

function TDadosJogadorModel.ListarDadosJogadores: TFDQuery;
var
  LDadosJogadorDAO: TDadosJogadorDAO;
begin
  LDadosJogadorDAO := TDadosJogadorDAO.Create;
  try
    Result := LDadosJogadorDAO.ListarDadosJogadores;
  finally
    LDadosJogadorDAO.Free;
  end;
end;

end.
