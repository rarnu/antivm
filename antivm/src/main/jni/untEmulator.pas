unit untEmulator;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, untProp;

function isEmulator(): Boolean;

implementation

function isEmulatorAbsolutely(): Boolean;
begin
  if (P_PRODUCT.Contains('sdk') or
    P_PRODUCT.Contains('sdk_x86') or
    P_PRODUCT.Contains('sdk_google') or
    P_PRODUCT.Contains('Andy') or
    P_PRODUCT.Contains('Droid4X') or
    P_PRODUCT.Contains('nox') or
    P_PRODUCT.Contains('vbox86p') or
    P_PRODUCT.Contains('aries')) then Exit(True);

  if ((P_MANUFACTURER = 'Genymotion') or
    P_MANUFACTURER.Contains('Andy') or
    P_MANUFACTURER.Contains('nox') or
    P_MANUFACTURER.Contains('TiantianVM')) then Exit(True);

  if (P_BRAND.Contains('Andy')) then Exit(True);

  if (P_DEVICE.Contains('Andy') or
    P_DEVICE.Contains('Droid4X') or
    P_DEVICE.Contains('nox') or
    P_DEVICE.Contains('vbox86p') or
    P_DEVICE.Contains('aries')) then Exit(True);

  if (P_MODEL.Contains('Emulator') or
    (P_MODEL = 'google_sdk') or
    P_MODEL.Contains('Droid4X') or
    P_MODEL.Contains('TiantianVM') or
    P_MODEL.Contains('Andy') or
    (P_MODEL = 'Android SDK built for x86_64') or
    (P_MODEL = 'Android SDK built for x86')) then Exit(True);

  if ((P_HARDWARE = 'vbox86') or
    P_HARDWARE.Contains('nox') or
    P_HARDWARE.Contains('ttVM_x86')) then Exit(True);

  if (P_FINGERPRINT.Contains('generic/sdk/generic') or
    P_FINGERPRINT.Contains('generic_x86/sdk_x86/generic_x86') or
    P_FINGERPRINT.Contains('Andy') or
    P_FINGERPRINT.Contains('ttVM_Hdragon') or
    P_FINGERPRINT.Contains('generic/google_sdk/generic') or
    P_FINGERPRINT.Contains('vbox86p') or
    P_FINGERPRINT.Contains('generic/vbox86p/vbox86p')) then Exit(True);
  Exit(False);
end;

function isEmulator(): Boolean;
var
  rating: Integer = 0;
begin
  if (isEmulatorAbsolutely()) then Exit(True);

  if (P_PRODUCT.Contains('sdk') or
    P_PRODUCT.Contains('Andy') or
    P_PRODUCT.Contains('ttVM_Hdragon') or
    P_PRODUCT.Contains('google_sdk') or
    P_PRODUCT.Contains('Droid4X') or
    P_PRODUCT.Contains('nox') or
    P_PRODUCT.Contains('sdk_x86') or
    P_PRODUCT.Contains('sdk_google') or
    P_PRODUCT.Contains('vbox86p') or
    P_PRODUCT.Contains('aries')) then Inc(rating);

  if ((P_MANUFACTURER = 'unknown') or
    (P_MANUFACTURER = 'Genymotion') or
    P_MANUFACTURER.Contains('Andy') or
    P_MANUFACTURER.Contains('MIT') or
    P_MANUFACTURER.Contains('nox') or
    P_MANUFACTURER.Contains('TiantianVM')) then Inc(rating);

  if ((P_BRAND  = 'generic') or
    (P_BRAND = 'generic_x86') or
    (P_BRAND = 'TTVM') or
    P_BRAND.Contains('Andy')) then Inc(rating);

  if (P_DEVICE.Contains('generic') or
    P_DEVICE.Contains('generic_x86') or
    P_DEVICE.Contains('Andy') or
    P_DEVICE.Contains('ttVM_Hdragon') or
    P_DEVICE.Contains('Droid4X') or
    P_DEVICE.Contains('nox') or
    P_DEVICE.Contains('generic_x86_64') or
    P_DEVICE.Contains('vbox86p') or
    P_DEVICE.Contains('aries')) then Inc(rating);

  if ((P_MODEL = 'sdk') or
    P_MODEL.Contains('Emulator') or
    (P_MODEL = 'google_sdk') or
    P_MODEL.Contains('Droid4X') or
    P_MODEL.Contains('TiantianVM') or
    P_MODEL.Contains('Andy') or
    (P_MODEL = 'Android SDK built for x86_64') or
    (P_MODEL = 'Android SDK built for x86')) then Inc(rating);

  if ((P_HARDWARE = 'goldfish') or
    (P_HARDWARE = 'vbox86') or
    P_HARDWARE.Contains('nox') or
    P_HARDWARE.Contains('ttVM_x86')) then Inc(rating);

  if (P_FINGERPRINT.Contains('generic/sdk/generic') or
    P_FINGERPRINT.Contains('generic_x86/sdk_x86/generic_x86') or
    P_FINGERPRINT.Contains('Andy') or
    P_FINGERPRINT.Contains('ttVM_Hdragon') or
    P_FINGERPRINT.Contains('generic_x86_64') or
    P_FINGERPRINT.Contains('generic/google_sdk/generic') or
    P_FINGERPRINT.Contains('vbox86p') or
    P_FINGERPRINT.Contains('generic/vbox86p/vbox86p')) then Inc(rating);

  if (P_OPENGL.Contains('Bluestacks') or
    P_OPENGL.Contains('Translator')) then Inc(rating, 10);

  if (P_SHARED_FOLDER_EXISTS) then Inc(rating, 10);

  Exit(rating > 3);
end;

end.

