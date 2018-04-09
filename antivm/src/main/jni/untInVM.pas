unit untInVM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2, untContext;

function isInVM(env: PJNIEnv): Boolean;

implementation

function isInVM(env: PJNIEnv): Boolean;
var
  ctx: jobject;
  jContext: jclass;
  jGetFilesDir: jmethodID;
  oFile: jobject;
  jFile: jclass;
  jGetAbsolutePath: jmethodID;
  jPath: jstring;
  path: string;
  jGetPackageName: jmethodID;
  jPkgName: jstring;
  pkgName: string;
  notInVM: Boolean = False;
begin
  ctx := getContext(env);
  jContext:= env^^.FindClass(env, 'android/content/Context');
  jGetFilesDir:= env^^.GetMethodID(env, jContext, 'getFilesDir', '()Ljava/io/File;');
  oFile:= env^^.CallObjectMethod(env, ctx, jGetFilesDir);
  jFile := env^^.FindClass(env, 'java/io/File');
  jGetAbsolutePath:= env^^.GetMethodID(env, jFile, 'getAbsolutePath', '()Ljava/lang/String;');
  jPath:= env^^.CallObjectMethod(env, oFile, jGetAbsolutePath);
  path := TJNIEnv.JStringToString(env, jPath);

  jGetPackageName:= env^^.GetMethodID(env, jContext, 'getPackageName', '()Ljava/lang/String;');
  jPkgName:= env^^.CallObjectMethod(env, ctx, jGetPackageName);
  pkgName:= TJNIEnv.JStringToString(env, jPkgName);

  env^^.DeleteLocalRef(env, jContext);
  env^^.DeleteLocalRef(env, oFile);
  env^^.DeleteLocalRef(env, ctx);

  if (path.StartsWith('/data/data/' + pkgName)) then notInVM:= True;
  if (path.StartsWith('/data/user/0/' + pkgName)) then notInVM:= True;

  Exit(not notInVM);
end;

end.

