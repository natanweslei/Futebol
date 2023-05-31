unit uDadosJogadorController;

interface

uses
  uDadosJogadorModel, FireDAC.Comp.Client;

type
  TDadosJogadorController = class
    private
      FDadosJogadorModel: TDadosJogadorModel;
    public
      constructor Create;
      destructor Destroy; override;

      function Salvar: Boolean;
      function ListarDadosJogadores: TFDQuery;

      property DadosJogadorModel: TDadosJogadorModel read FDadosJogadorModel write FDadosJogadorModel;
  end;

implementation

constructor TDadosJogadorController.Create;
begin
  inherited;
  FDadosJogadorModel := TDadosJogadorModel.Create;
end;

destructor TDadosJogadorController.Destroy;
begin
  FDadosJogadorModel.Free;
  inherited;
end;

function TDadosJogadorController.Salvar: Boolean;
begin
  Result := FDadosJogadorModel.Salvar(FDadosJogadorModel);
end;

function TDadosJogadorController.ListarDadosJogadores: TFDQuery;
begin
  Result := FDadosJogadorModel.ListarDadosJogadores;
end;

end.
