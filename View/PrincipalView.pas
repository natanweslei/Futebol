unit PrincipalView;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,
  FMX.Types,
  FMX.Controls,
  FMX.Graphics,
  FMX.Forms,
  FMX.Dialogs,
  FMX.TabControl,
  FMX.ActnList,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.ListBox,
  FMX.Layouts,
  FMX.Edit,
  FMX.MediaLibrary.Actions,
  FMX.StdActns,
  FireDAC.Comp.Client,
  uScriptController,
  uDadosJogadorController,
  u99Permissions;

type
  TFormPrincipal = class(TForm)
    TabControl: TTabControl;
    tbListaJogadores: TTabItem;
    rectFundoAba1: TRectangle;
    rectToolbar1: TRectangle;
    tbFotoJogador: TTabItem;
    TabItem3: TTabItem;
    rectToolbar3: TRectangle;
    Label7: TLabel;
    lvTarefas: TListView;
    TabItem4: TTabItem;
    Rectangle1: TRectangle;
    Label8: TLabel;
    lbTarefa: TListBox;
    ListBoxItem1: TListBoxItem;
    Image8: TImage;
    Label10: TLabel;
    Line1: TLine;
    ListBoxItem2: TListBoxItem;
    Image9: TImage;
    Label11: TLabel;
    Line2: TLine;
    ListBoxItem3: TListBoxItem;
    Image10: TImage;
    Label13: TLabel;
    Line3: TLine;
    rectToolbar: TRectangle;
    eNome: TEdit;
    lvJogadores: TListView;
    bAdicionaJogador: TSpeedButton;
    bFotoJogador: TSpeedButton;
    imgFoto: TImage;
    layFoto: TLayout;
    imgLibrary: TImage;
    ActionList1: TActionList;
    ActFoto: TChangeTabAction;
    ActLibrary: TTakePhotoFromLibraryAction;
    ActCamera: TTakePhotoFromCameraAction;
    bCancelarFoto: TSpeedButton;
    actListaJogadores: TChangeTabAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bAdicionaJogadorClick(Sender: TObject);
    procedure bFotoJogadorClick(Sender: TObject);
    procedure bCancelarFotoClick(Sender: TObject);
    procedure ActLibraryDidFinishTaking(AImage: TBitmap);
    procedure imgFotoClick(Sender: TObject);
    procedure imgLibraryClick(Sender: TObject);
  private
    FPermissao: T99Permissions;
    FScriptController: TScriptController;
    FDadosJogadorController: TDadosJogadorController;
    procedure AtualizarListaJogadores;
    procedure AdicionarNaLista(AJogadorId: Integer; ANome: String; AFoto: TBitmap);
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.fmx}
//{$R *.LgXhdpiPh.fmx ANDROID}
//{$R *.iPhone4in.fmx IOS}

uses
  uConexao, DadosJogadorView, uAmbienteController, Data.DB;

procedure TFormPrincipal.bAdicionaJogadorClick(Sender: TObject);
begin
  if Trim(eNome.Text) = EmptyStr then
    Exit;

  FDadosJogadorController.DadosJogadorModel.Acao := TAcao.taincluir;
  FDadosJogadorController.DadosJogadorModel.Nome := eNome.Text;
//  FDadosJogadorController.DadosJogadorModel.Foto := image1.Bitmap;

  if FDadosJogadorController.Salvar then
    eNome.Text := EmptyStr;

  AtualizarListaJogadores;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  try
    TConexao.GetInstancia;
    FScriptController := TScriptController.Create;
    FDadosJogadorController := TDadosJogadorController.Create;
    FScriptController.CriarTabela;
  except on E: Exception do
    ShowMessage(E.Message);
  end;

  FPermissao := T99Permissions.Create;
end;

procedure TFormPrincipal.FormDestroy(Sender: TObject);
begin
  FPermissao.Free;
  FDadosJogadorController.Free;
  FScriptController.Free;
  TConexao.GetInstancia.Destroy;
end;

procedure TFormPrincipal.AtualizarListaJogadores;
var
  LFoto: TBitmap;
  LFotoStream: TStream;
  LListaJogadores: TFDQuery;
begin
  lvJogadores.BeginUpdate;
  lvJogadores.Items.Clear;

  LListaJogadores := FDadosJogadorController.ListarDadosJogadores;
  while not LListaJogadores.Eof do
  begin
    LFoto := nil;

//    if LListaJogadores.FieldByName('FOTO').AsString <> '' then
//    begin
//      LFotoStream := LListaJogadores.CreateBlobStream(LListaJogadores.FieldByName('FOTO'), TBlobStreamMode.bmRead);
//      LFoto := TBitmap.Create;
//      LFoto.LoadFromStream(LFotoStream);
//      LFotoStream.DisposeOf;
//    end;

    AdicionarNaLista(
      LListaJogadores.FieldByName('JOGADOR_ID').AsInteger,
      LListaJogadores.FieldByName('NOME').AsString,
      LFoto
    );
    LListaJogadores.Next;
  end;

  lvJogadores.EndUpdate;
end;

procedure TFormPrincipal.AdicionarNaLista(AJogadorId: Integer; ANome: String; AFoto: TBitmap);
var
  LItem: TListViewItem;
begin
  LItem := lvJogadores.Items.Add;
  LItem.Height := 70;
  LItem.Tag := AJogadorId;


//  if AFoto <> nil then
//  begin
//    TListItemImage(LItem.Objects.FindDrawable('imgFotoJogador')).Bitmap := AFoto;
//    TListItemImage(LItem.Objects.FindDrawable('imgFotoJogador')).OwnsBitmap := True;
//  end;

  TListItemText(LItem.Objects.FindDrawable('itemJogador')).Text := AJogadorId.ToString + ' - ' + ANome;
end;

procedure TFormPrincipal.ActLibraryDidFinishTaking(AImage: TBitmap);
begin
//  image1.Bitmap := AImage;
//  FDadosJogadorController.DadosJogadorModel.Foto.Create;
//  FDadosJogadorController.DadosJogadorModel.Foto := AImage;

  actListaJogadores.Execute;
end;

procedure TFormPrincipal.bCancelarFotoClick(Sender: TObject);
begin
  actListaJogadores.Execute;
end;

procedure TFormPrincipal.bFotoJogadorClick(Sender: TObject);
begin
  ActFoto.Execute;
end;

procedure TFormPrincipal.imgFotoClick(Sender: TObject);
begin
  FPermissao.Camera(ActCamera);
end;

procedure TFormPrincipal.imgLibraryClick(Sender: TObject);
begin
  FPermissao.PhotoLibrary(ActLibrary);
end;

end.
