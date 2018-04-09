unit untContext;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2;

function getContext(env: PJNIEnv): jobject;

implementation

function getContext(env: PJNIEnv): jobject;
var
  jActivityThread: jclass;
  jCurrentActivityThread: jmethodID;
  oActivityThread: jobject;
  jGetApplication: jmethodID;
  oContext: jobject;
begin
  jActivityThread:= env^^.FindClass(env, 'android/app/ActivityThread');
  jCurrentActivityThread:= env^^.GetStaticMethodID(env, jActivityThread, 'currentActivityThread', '()Landroid/app/ActivityThread;');
  oActivityThread:= env^^.CallStaticObjectMethod(env, jActivityThread, jCurrentActivityThread);
  jGetApplication:= env^^.GetMethodID(env, jActivityThread, 'getApplication', '()Landroid/app/Application;');
  oContext:= env^^.CallObjectMethod(env, oActivityThread, jGetApplication);
  env^^.DeleteLocalRef(env, jActivityThread);
  env^^.DeleteLocalRef(env, oActivityThread);
  Exit(oContext);
end;

end.

