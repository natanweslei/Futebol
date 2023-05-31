program FutebolApplication;

uses
  System.StartUpCopy,
  FMX.Forms,
  uConexao in 'DAO\uConexao.pas',
  uDadosJogadorDAO in 'DAO\uDadosJogadorDAO.pas',
  uScriptDAO in 'DAO\uScriptDAO.pas',
  uDadosJogadorController in 'Controller\uDadosJogadorController.pas',
  uScriptController in 'Controller\uScriptController.pas',
  uDadosJogadorModel in 'Model\uDadosJogadorModel.pas',
  uScriptModel in 'Model\uScriptModel.pas',
  DadosJogadorView in 'View\DadosJogadorView.pas' {FormDadosJogador},
  PrincipalView in 'View\PrincipalView.pas' {FormPrincipal},
  uAmbienteController in 'Controller\uAmbienteController.pas',
  u99Permissions in 'Model\u99Permissions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
