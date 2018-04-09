unit untEmulator;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2, untProp, untGLString, untFile;

function isEmulator(env: PJNIEnv): Boolean;

implementation

function isEmulatorAbsolutely(): Boolean;
var
  product, manufacturer, brand, device, model, hardware, fingerprint: string;
begin
  product:= propList.Values[KEY_PRODUCT];
  if (product.Contains('sdk') or
    product.Contains('sdk_x86') or
    product.Contains('sdk_google') or
    product.Contains('Andy') or
    product.Contains('Droid4X') or
    product.Contains('nox') or
    product.Contains('vbox86p') or
    product.Contains('aries')) then Exit(True);
  manufacturer:= propList.Values[KEY_MANUFACTURER];
  if ((manufacturer = 'Genymotion') or
    manufacturer.Contains('Andy') or
    manufacturer.Contains('nox') or
    manufacturer.Contains('TiantianVM')) then Exit(True);
  brand:= propList.Values[KEY_BRAND];
  if (brand.Contains('Andy')) then Exit(True);
  device:=  propList.Values[KEY_DEVICE];
  if (device.Contains('Andy') or
    device.Contains('Droid4X') or
    device.Contains('nox') or
    device.Contains('vbox86p') or
    device.Contains('aries')) then Exit(True);
  model:= propList.Values[KEY_MODEL];
  if (model.Contains('Emulator') or
    (model = 'google_sdk') or
    model.Contains('Droid4X') or
    model.Contains('TiantianVM') or
    model.Contains('Andy') or
    (model = 'Android SDK built for x86_64') or
    (model = 'Android SDK built for x86')) then Exit(True);
  hardware:= propList.Values[KEY_HARDWARE];
  if ((hardware = 'vbox86') or
    hardware.Contains('nox') or
    hardware.Contains('ttVM_x86')) then Exit(True);
  fingerprint:= propList.Values[KEY_FINGERPRINT];
  if (fingerprint.Contains('generic/sdk/generic') or
    fingerprint.Contains('generic_x86/sdk_x86/generic_x86') or
    fingerprint.Contains('Andy') or
    fingerprint.Contains('ttVM_Hdragon') or
    fingerprint.Contains('generic/google_sdk/generic') or
    fingerprint.Contains('vbox86p') or
    fingerprint.Contains('generic/vbox86p/vbox86p')) then Exit(True);
  Exit(False);
end;

function isEmulator(env: PJNIEnv): Boolean;
var
  rating: Integer = 0;
  product, manufacturer, brand, device, model, hardware, fingerprint, opengl: string;
  sharedExists: Boolean;
begin
  if (isEmulatorAbsolutely()) then Exit(True);
  product:= propList.Values[KEY_PRODUCT];
  if (product.Contains('sdk') or
    product.Contains('Andy') or
    product.Contains('ttVM_Hdragon') or
    product.Contains('google_sdk') or
    product.Contains('Droid4X') or
    product.Contains('nox') or
    product.Contains('sdk_x86') or
    product.Contains('sdk_google') or
    product.Contains('vbox86p') or
    product.Contains('aries')) then Inc(rating);

  manufacturer := propList.Values[KEY_MANUFACTURER];
  if ((manufacturer = 'unknown') or
    (manufacturer = 'Genymotion') or
    manufacturer.Contains('Andy') or
    manufacturer.Contains('MIT') or
    manufacturer.Contains('nox') or
    manufacturer.Contains('TiantianVM')) then Inc(rating);

  brand:= propList.Values[KEY_BRAND];
  if ((brand  = 'generic') or
    (brand = 'generic_x86') or
    (brand = 'TTVM') or
    brand.Contains('Andy')) then Inc(rating);

  device:= propList.Values[KEY_DEVICE];
  if (device.Contains('generic') or
    device.Contains('generic_x86') or
    device.Contains('Andy') or
    device.Contains('ttVM_Hdragon') or
    device.Contains('Droid4X') or
    device.Contains('nox') or
    device.Contains('generic_x86_64') or
    device.Contains('vbox86p') or
    device.Contains('aries')) then Inc(rating);

  model:= propList.Values[KEY_MODEL];
  if ((model = 'sdk') or
    model.Contains('Emulator') or
    (model = 'google_sdk') or
    model.Contains('Droid4X') or
    model.Contains('TiantianVM') or
    model.Contains('Andy') or
    (model = 'Android SDK built for x86_64') or
    (model = 'Android SDK built for x86')) then Inc(rating);

  hardware:= propList.Values[KEY_HARDWARE];
  if ((hardware = 'goldfish') or
    (hardware = 'vbox86') or
    hardware.Contains('nox') or
    hardware.Contains('ttVM_x86')) then Inc(rating);

  fingerprint:= propList.Values[KEY_FINGERPRINT];
  if (fingerprint.Contains('generic/sdk/generic') or
    fingerprint.Contains('generic_x86/sdk_x86/generic_x86') or
    fingerprint.Contains('Andy') or
    fingerprint.Contains('ttVM_Hdragon') or
    fingerprint.Contains('generic_x86_64') or
    fingerprint.Contains('generic/google_sdk/generic') or
    fingerprint.Contains('vbox86p') or
    fingerprint.Contains('generic/vbox86p/vbox86p')) then Inc(rating);

  opengl:= getGLString(env);
  if (opengl.Contains('Bluestacks') or
    opengl.Contains('Translator')) then Inc(rating, 10);

  sharedExists := sharedFolderExists(env);
  if (sharedExists) then Inc(rating, 10);

  Exit(rating > 3);
end;

end.

