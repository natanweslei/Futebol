unit uScriptModel;

interface

type
  TScriptModel = class
  public
    procedure CriarTabela;
  end;

implementation

uses
  uScriptDAO;

procedure TScriptModel.CriarTabela;
var
  LScriptDAO: TScriptDAO;
begin
  LScriptDAO := TScriptDAO.Create;
  try
    LScriptDAO.CriarTabela;
  finally
    LScriptDAO.Free;
  end;
end;

end.
