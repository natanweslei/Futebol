unit uAmbienteController;

interface

uses
  uConexao, System.SysUtils, uScriptModel;

type
  TAcao = (taIndefinido, taIncluir, taAlterar, taExcluir);

type
  TAmbienteControl = class
  private
    FConexao : TConexao;
    FScriptModel: TScriptModel;
    class var FInstance: TAmbienteControl;
  public
    constructor Create();
    destructor Destroy; override;
//    procedure CarregarEmpresa(ACodigoEmpresa: Integer);
    class function GetInstance: TAmbienteControl;
    property Conexao: TConexao read FConexao write FConexao;
    property ScriptModel: TScriptModel read FScriptModel write FScriptModel;
  end;

implementation

constructor TAmbienteControl.Create;
begin
  FConexao := TConexao.Create;
  ScriptModel := TScriptModel.Create;
end;

destructor TAmbienteControl.Destroy;
begin
  FScriptModel.Free;
  FConexao.Free;
  inherited;
end;

class function TAmbienteControl.GetInstance: TAmbienteControl;
begin
  if not Assigned(Self.FInstance) then
    Self.FInstance := TAmbienteControl.Create;
  Result := Self.FInstance;
end;

end.
