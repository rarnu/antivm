unit untProp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process;

const
  KEY_PRODUCT = 'ro.product.name';
  KEY_MANUFACTURER = 'ro.product.manufacturer';
  KEY_DEVICE = 'ro.product.device';
  KEY_MODEL = 'ro.product.model';
  KEY_HARDWARE = 'ro.hardware';
  KEY_FINGERPRINT = 'ro.build.fingerprint';
  KEY_BRAND = 'ro.product.brand';
  KEY_TAGS = 'ro.build.tags';

var
  propList: TStringList;

implementation

procedure loadProp();
var
  outstr: string = '';
  i: Integer;
begin
  // TODO: not work under android O above, need change
  RunCommand('getprop', [], outstr, [poWaitOnExit, poUsePipes]);
  outstr:= outstr.Replace(']: [', '=', [rfIgnoreCase, rfReplaceAll]);
  propList.Text:= outstr;
  for i := 0 to propList.Count - 1 do propList[i] := propList[i].Trim(['[', ']']);
end;

initialization
  propList := TStringList.Create;
  loadProp();

finalization
  propList.Free;

end.

