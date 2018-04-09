unit untHook;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, BaseUnix;

function isHooked(): Boolean;

implementation

function isHookedByPackageName(): Boolean;
var
  outstr: string = '';
  xposedInstalled: Boolean;
  substrateInstalled: Boolean;
begin
  RunCommand('pm', ['path', 'de.robv.android.xposed.installer'], outstr, [poWaitOnExit, poUsePipes]);
  xposedInstalled:= outstr.Trim.EndsWith('.apk');
  RunCommand('pm', ['path', 'com.saurik.substrate'], outstr, [poWaitOnExit, poUsePipes]);
  substrateInstalled:= outstr.Trim.EndsWith('.apk');
  Exit(xposedInstalled or substrateInstalled);
end;

function isHookedByJar(): Boolean;
var
  mapFile: string;
  sl: TStringList;
  isHooked: Boolean = False;
begin
  mapFile:= Format('/proc/%d/maps', [FpGetpid]);
  sl := TStringList.Create;
  try
    sl.LoadFromFile(mapFile);
    if (sl.Text.Contains('com.saurik.substrate')) then isHooked:= True;
    if (sl.Text.Contains('XposedBridge.jar')) then isHooked:= True;
  except
  end;
  sl.Free;
  Exit(isHooked);
end;

function isHooked(): Boolean;
begin
  Exit(isHookedByPackageName() or isHookedByJar());
end;

end.

