unit untGLString;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2;

function getGLString(env: PJNIEnv): string;

implementation

function getGLString(env: PJNIEnv): string;
var
  jGLES20: jclass;
  jGlGetString: jmethodID;
  jRet: jstring;
begin
  jGLES20 := env^^.FindClass(env, 'android/opengl/GLES20');
  jGlGetString:= env^^.GetStaticMethodID(env, jGLES20, 'glGetString', '(I)Ljava/lang/String;');
  jRet:= env^^.CallStaticObjectMethodA(env, jGLES20, jGlGetString, TJNIEnv.ArgsToJValues(env, [$1F01]));
  env^^.DeleteLocalRef(env, jGLES20);
  Exit(TJNIEnv.JStringToString(env, jRet));
end;

end.

