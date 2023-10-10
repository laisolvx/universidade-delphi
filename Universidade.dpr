
//Gerar exe
program Universidade;

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  uUniversidade in 'uUniversidade.pas' {Universidade},
  uTelaPadrao01 in 'C:\DELPHI-LIB\Grupo Recursos 2010\Formulario\uTelaPadrao01.pas' {FTelaPadrao01};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfUniversidade, fUniversidade);
  fUniversidade.MyParentApplication := nil;
  fUniversidade.MyParentForm        := nil;
  fUniversidade.MyParentPanel       := nil;
  fUniversidade.VPuNomeUsuario      := 'Reinaldo';
  fUniversidade.vPuCSProvedor       := 'Provider=SQLOLEDB.1;Password=rec235net896sim;Persist Security Info=True;User ID=matrix;Initial Catalog=Recursos_Matrix;Data Source=grprodev,1433';

  fUniversidade.Proc_Conexao;

  Application.Run;
end.


//Gerar dll
library Universidade;

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  uUniversidade in 'uUniversidade.pas' {fUniversidade},
  uTelaPadrao01 in 'C:\DELPHI-LIB\Grupo Recursos 2010\Formulario\uTelaPadrao01.pas' {FTelaPadrao01};

procedure ProvaChild(ParentApplication: TApplication; ParentForm: TForm; Fundo: TPanel; UsuarioLogado: String; CSProvedor: String); export; stdcall;
var
  fUniversidade: TfUniversidade;
  DllProc: Pointer; { Called whenever DLL entry point is called }
begin
  Application:=ParentApplication;

  fUniversidade := TfUniversidade.Create(ParentForm);

  fUniversidade.MyParentApplication := ParentApplication;
  fUniversidade.MyParentForm        := ParentForm;
  fUniversidade.MyParentPanel       := Fundo;
  fUniversidade.VPuNomeUsuario      := UsuarioLogado;
  fUniversidade.vPuCSProvedor       := CSProvedor;

  windows.SetParent(fUniversidade.Handle, ParentForm.Handle);

  fUniversidade.Proc_Conexao;

  fUniversidade.Show;
end;

procedure DLLUnloadProc(Reason: Integer); register;
begin
  if Reason = DLL_PROCESS_DETACH then
     Application := DllApplication;
end;

exports
  ProvaChild;

begin
  DllApplication:=Application;
  DLLProc := @DLLUnloadProc;
end.

