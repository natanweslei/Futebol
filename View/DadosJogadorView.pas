unit DadosJogadorView;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.ListBox,
  FMX.Edit,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  uDadosJogadorController;

type
  TExecuteOnClose = procedure of Object;

  TFormDadosJogador = class(TForm)
    rectToolbar2: TRectangle;
    lblTitulo: TLabel;
    Image5: TImage;
    btnSalvar: TSpeedButton;
    Image1: TImage;
    btnVoltar: TSpeedButton;
    eNome: TEdit;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    FDadosJogadorController: TDadosJogadorController;
  end;


implementation

{$R *.fmx}

uses
  uAmbienteController;

procedure TFormDadosJogador.btnSalvarClick(Sender: TObject);
begin
  if Trim(eNome.Text) = EmptyStr then
    Exit;

  FDadosJogadorController.DadosJogadorModel.Acao := TAcao.taincluir;
  FDadosJogadorController.DadosJogadorModel.Nome := eNome.Text;
  FDadosJogadorController.Salvar;

//  FDadosJogadorController.li
end;

procedure TFormDadosJogador.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDadosJogador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormDadosJogador.FormCreate(Sender: TObject);
begin
  FDadosJogadorController := TDadosJogadorController.Create;
end;

procedure TFormDadosJogador.FormDestroy(Sender: TObject);
begin
  FDadosJogadorController.Free;
end;

end.
