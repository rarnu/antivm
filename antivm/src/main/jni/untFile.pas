unit untFile;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2;

function sharedFolderExists(env: PJNIEnv): Boolean;

implementation

const
  SPLIT = {$ifdef windows}'\'{$else}'/'{$endif};

function sharedFolderExists(env: PJNIEnv): Boolean;
var
  jEnvironment: jclass;
  jGetExternalStorageDirectory: jmethodID;
  oFile: jobject;
  jFile: jclass;
  jGetAbsolutePath: jmethodID;
  jRet: jstring;
  path: string;
begin
  jEnvironment:= env^^.FindClass(env, 'android/os/Environment');
  jGetExternalStorageDirectory:= env^^.GetStaticMethodID(env, jEnvironment, 'getExternalStorageDirectory', '()Ljava/io/File;');
  oFile:= env^^.CallStaticObjectMethod(env, jEnvironment, jGetExternalStorageDirectory);
  jFile:= env^^.FindClass(env, 'java/io/File');
  jGetAbsolutePath:= env^^.GetMethodID(env, jFile, 'getAbsolutePath', '()Ljava/lang/String;');
  jRet:= env^^.CallObjectMethod(env, oFile, jGetAbsolutePath);

  env^^.DeleteLocalRef(env, oFile);
  env^^.DeleteLocalRef(env, jFile);
  env^^.DeleteLocalRef(env, jEnvironment);

  path := TJNIEnv.JStringToString(env, jRet);
  path += SPLIT + 'windows' + SPLIT + 'BstSharedFolder';
  Exit(DirectoryExists(path));
end;

end.

