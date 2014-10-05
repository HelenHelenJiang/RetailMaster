package com.bionym.ncl.helper;

import android.content.Context;
import android.content.SharedPreferences;

public class NymiSharedPreferences {
	static SharedPreferences sP;
	
	public static void initialize(Context act){
		sP = act.getSharedPreferences(
                "893y9832ydhu3hd923d", act.MODE_PRIVATE);
	}
	
	public static void addToPref(String key, String value){
		SharedPreferences.Editor prefsEditor = sP.edit();
        prefsEditor.putString(key,value);
        prefsEditor.commit();
	}
	
	public static String getFromPref(String key){
		 return sP.getString(key, Constants.Nothing);
	}
	
	public static void addToPref(String key, Boolean value){
		SharedPreferences.Editor prefsEditor = sP.edit();
        prefsEditor.putBoolean(key,value);
        prefsEditor.commit();
	}
	
	public static Boolean getBooleanFromPref(String key, Boolean defa){
		 return sP.getBoolean(key,defa);
	}

}
