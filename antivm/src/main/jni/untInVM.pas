unit untInVM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2, untProp;

function isInVM(env: PJNIEnv): Boolean;

implementation

function isInVM(env: PJNIEnv): Boolean;
var
  notInVM: Boolean = False;
begin
  if (P_DATAPATH.StartsWith('/data/data/' + P_PKGNAME)) then notInVM:= True;
  if (P_DATAPATH.StartsWith('/data/user/0/' + P_PKGNAME)) then notInVM:= True;
  Exit(not notInVM);
end;

end.

