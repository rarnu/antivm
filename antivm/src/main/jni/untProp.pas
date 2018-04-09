unit untProp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JNI2, untGLString, untFile, untContext;

procedure loadProp(env: PJNIEnv);

var
  P_PRODUCT: string = '';
  P_MANUFACTURER: string = '';
  P_BRAND: string = '';
  P_DEVICE: string = '';
  P_MODEL: string = '';
  P_HARDWARE: string = '';
  P_FINGERPRINT: string = '';
  P_TAGS: string = '';
  P_OPENGL: string = '';
  P_SHARED_FOLDER_EXISTS: Boolean = False;
  P_DATAPATH: string = '';
  P_PKGNAME: string = '';

implementation

procedure loadProp(env: PJNIEnv);
var
  jBuild: jclass;
  jf: jfieldID;

  ctx: jobject;
  jContext: jclass;
  jGetFilesDir: jmethodID;
  oFile: jobject;
  jFile: jclass;
  jGetAbsolutePath: jmethodID;
  jPath: jstring;
  jGetPackageName: jmethodID;
  jPkgName: jstring;

begin
  P_OPENGL:= getGLString(env);
  P_SHARED_FOLDER_EXISTS:= sharedFolderExists(env);
  jBuild:= env^^.FindClass(env, 'android/os/Build');
  jf:= env^^.GetStaticFieldID(env, jBuild, 'PRODUCT', 'Ljava/lang/String;');
  P_PRODUCT := TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'MANUFACTURER', 'Ljava/lang/String;');
  P_MANUFACTURER:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'BRAND', 'Ljava/lang/String;');
  P_BRAND:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'DEVICE', 'Ljava/lang/String;');
  P_DEVICE:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'MODEL', 'Ljava/lang/String;');
  P_MODEL:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'HARDWARE', 'Ljava/lang/String;');
  P_HARDWARE:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'FINGERPRINT', 'Ljava/lang/String;');
  P_FINGERPRINT:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  jf := env^^.GetStaticFieldID(env, jBuild, 'TAGS', 'Ljava/lang/String;');
  P_TAGS:= TJNIEnv.JStringToString(env, env^^.GetStaticObjectField(env, jBuild, jf));
  env^^.DeleteLocalRef(env, jBuild);

  ctx := getContext(env);
  jContext:= env^^.FindClass(env, 'android/content/Context');
  jGetFilesDir:= env^^.GetMethodID(env, jContext, 'getFilesDir', '()Ljava/io/File;');
  oFile:= env^^.CallObjectMethod(env, ctx, jGetFilesDir);
  jFile := env^^.FindClass(env, 'java/io/File');
  jGetAbsolutePath:= env^^.GetMethodID(env, jFile, 'getAbsolutePath', '()Ljava/lang/String;');
  jPath:= env^^.CallObjectMethod(env, oFile, jGetAbsolutePath);
  P_DATAPATH := TJNIEnv.JStringToString(env, jPath);

  jGetPackageName:= env^^.GetMethodID(env, jContext, 'getPackageName', '()Ljava/lang/String;');
  jPkgName:= env^^.CallObjectMethod(env, ctx, jGetPackageName);
  P_PKGNAME:= TJNIEnv.JStringToString(env, jPkgName);

  env^^.DeleteLocalRef(env, jContext);
  env^^.DeleteLocalRef(env, oFile);
  env^^.DeleteLocalRef(env, ctx);
end;

end.

