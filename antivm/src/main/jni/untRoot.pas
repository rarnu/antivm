unit untRoot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, untProp;

function isRooted(): Boolean;

implementation

function isDeviceDebugable(): Boolean;
var
  tags: string;
begin
  tags:= propList.Values[KEY_TAGS];
  Exit(tags.Contains('test-keys'));
end;

function isSuperuserExists(): Boolean;
const
  SUPATH = '/system/app/Superuser.apk';
begin
  Exit(FileExists(SUPATH));
end;

function isSuExists(): Boolean;
const
  ARRPATH: array[0..4] of string = ('/system/bin/', '/system/xbin/', '/system/sbin/', '/sbin/', '/vendor/bin/');
var
  exists: Boolean = False;
  s: string;
begin
  for s in ARRPATH do begin
    if (FileExists(s + 'su')) then begin
      exists:= True;
      Break;
    end;
  end;
  Exit(exists);
end;

function isRooted(): Boolean;
begin
  if (isDeviceDebugable()) then Exit(True);
  if (isSuperuserExists()) then Exit(True);
  if (isSuExists()) then Exit(True);
  Exit(False);
end;

end.

