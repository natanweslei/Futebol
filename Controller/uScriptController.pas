unit uScriptController;

interface

uses
  uScriptModel;

type
  TScriptController = class
    private
      FScriptModel: TScriptModel;
    public
      constructor Create;
      destructor Destroy; override;
      procedure CriarTabela;
  end;

implementation

constructor TScriptController.Create;
begin
  FScriptModel := TScriptModel.Create;
end;

destructor TScriptController.Destroy;
begin
  FScriptModel.Free;
  inherited;
end;

procedure TScriptController.CriarTabela;
begin
  FScriptModel.CriarTabela;
end;

end.
