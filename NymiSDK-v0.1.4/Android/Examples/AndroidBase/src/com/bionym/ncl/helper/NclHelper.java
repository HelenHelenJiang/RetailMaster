package com.bionym.ncl.helper;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.bionym.ncl.Ncl;
import com.bionym.ncl.NclEventCreatedSk;
import com.bionym.ncl.NclEventSk;
import com.bionym.ncl.NclEventVk;
import com.bionym.ncl.NclProvision;

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface.OnDismissListener;
import android.util.Log;

// ISSUES:
// getSavedProvisions() returns only one provision. At least the name and the functionality should match
// may need a function to remove a saved provision
public class NclHelper {
	public static Activity mActivity;

	/**
	 * Initialize Nymi Communication Library (NCL) for communicating with <a href="http://developers.getnymi.com/sdk/emulator.html">Nymulator</a>
	 * @param activity the running {@link android.app.Activity}
	 * @param ip IP address of the computer running Nymulator. For testing from an Android emulator, the IP should be 10.0.2.2.
	 * @param port the port that Nymulator listen, this should be 9098
	 */
	public static void initialize(Activity activity, String ip, int port) {
		mActivity = activity;
		Ncl.InitiateLibrary(activity, ip, port);
	}
	
	/**
	 * Initialize Nymi Communication Library (NCL) for communicating with Nymi devices
	 * @param activity the running {@link android.app.Activity}
	 */
	public static void initialize(Activity activity) {
		mActivity = activity;
		Ncl.InitiateLibrary(activity);
		NymiSharedPreferences.initialize(activity);
	}

	public static void ProvisionNewNymi(Activity act, OnDismissListener dismisser) {
		
		ProvisioningDialog mDialog=new ProvisioningDialog(act);
		mDialog.setAction(NclHelperAction.PROVISION,-1,  null);
		mDialog.setOnDismissListener(dismisser);
		mDialog.show();

	}

	public static void createSK(Activity act, OnDismissListener dismisser) {
		ProvisioningDialog mDialog=new ProvisioningDialog(act);
		mDialog.setAction(NclHelperAction.CREATESK,-1,  null);
		mDialog.setOnDismissListener(dismisser);
		mDialog.show();
	}

	public static void getKey(Activity act, OnDismissListener dismisser) {
		ProvisioningDialog mDialog=new ProvisioningDialog(act);
		mDialog.setAction(NclHelperAction.GET_KEY, -1, null);
		mDialog.setOnDismissListener(dismisser);
		mDialog.show();
		
	}

	/**
	 * Load provisions that have been created
	 * @return
	 */
	public static NclProvision getProvisions() {
		return loadProvision();
	}
	
	/**
	 * Load the saved provision
	 * @return the saved provision
	 */
	protected static NclProvision loadProvision() {
		// final SharedPreferences prefs =
		// this.getSharedPreferences("com.bionyum.skeleton_code",
		// Context.MODE_PRIVATE);

		String str = NymiSharedPreferences.getFromPref(Constants.Provisions);// prefs.getString("provisions", // "NULL");
		if (!str.equals(Constants.Nothing)) { 
			return getSavedProvisions(str);
		}
		return null;
	}

	private static NclProvision getSavedProvisions(String str) {
		JSONObject jObj = null;
		JSONArray jArray = null;

		JSONObject jPro = null;
		JSONArray jKey = new JSONArray();
		JSONArray jId = new JSONArray();
		try {
			jObj = new JSONObject(str);
			jArray = jObj.getJSONArray("provisions");
		}
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int len = jArray.length();

		for (int i = 0; i < len; i++) {
			try {
				jPro = jArray.getJSONObject(i);
				jKey = jPro.getJSONArray("key");
				jId = jPro.getJSONArray("id");
			}
			catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			NclProvision p = new NclProvision();
			for (int a = 0; a < NclProvision.NCL_PROVISION_KEY_SIZE; a++) {
				try {
					p.key[a] = (char) jKey.getInt(a);
					p.id[a] = (char) jId.getInt(a);
				}
				catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return (p);
		}
		
		return null;
	}

	public static char[] getId() {
		return loadId();
	}

	/**
	 * 
	 * @return the ID of the saved provision if any, otherwise, null is returned
	 */
	private static char[] loadId() {
		String str = NymiSharedPreferences.getFromPref("SK_ID");// prefs.getString("provisions", // "NULL");

		if (!str.equals(Constants.Nothing)) { return getSavedID(str); }
		return null;
	}

	private static char[] getSavedID(String str) {
		try {
			JSONArray jArray=new JSONArray(str);
			NclEventSk sk=new NclEventSk();
			for (int i=0; i<jArray.length(); i++){
				sk.id[i]=(char) jArray.getInt(i);
			}
			return sk.id;
		}
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	/**
	 * Discover all nearby Nymi devices. This method will launch a dialog, detect all nearby Nymi devices in the current thread, and shows the result in the dialog.
	 * @param dismissListener the OnDIsmissListener that will be invoked when the dialog is dismissed
	 * @return the launched dialog
	 */
	public static Dialog discoverAllNymis(OnDismissListener dismissListener) {
		ProvisioningDialog mDialog=new ProvisioningDialog(mActivity);
		if (mDialog.setAction(NclHelperAction.DISCOVER_ALL_NYMIS, -1,  null)) {
			mDialog.setOnDismissListener(dismissListener);
			mDialog.show();
			
			return mDialog;
		}
		return null;
	}

	/**
	 * Remove all provisions
	 */
	public static void clearProvisions() {
		NymiSharedPreferences.addToPref(Constants.Provisions, "");
	}

	/**
	 * Save the given provision
	 * @param provision the provision to save
	 */
	public static void saveProvision(NclProvision provision) {
		JSONObject jObj = new JSONObject();
		JSONArray jArray = new JSONArray();

		JSONObject jPro = new JSONObject();
		JSONArray jKey = new JSONArray();
		JSONArray jId = new JSONArray();

		for (int a = 0; a < NclProvision.NCL_PROVISION_KEY_SIZE; a++) {
			jKey.put(provision.key[a]);
			jId.put(provision.id[a]);
		}
		try {
			jPro.putOpt("key", jKey);
			jPro.putOpt("id", jId);
			jArray.put(jPro);
		}
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			jObj.put("provisions", jArray);
			Log.d("Java Code", jObj.toString());
		}
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		NymiSharedPreferences.addToPref(Constants.Provisions, jObj.toString());
	}

	public static void SelectFind(ArrayList<NclProvision> provisions, OnDismissListener dismisser) {
		ProvisioningDialog mDialog=new ProvisioningDialog(mActivity);
		if (mDialog.setAction(NclHelperAction.FIND_SELECT_NYMI, -1, provisions)) {
			mDialog.setOnDismissListener(dismisser);
			mDialog.show();
		}
	}
	
	public static String SomeWhatReadable(char[] arr) {
		String str="";
		for(char c: arr){
			str+=((int)c) + " ";
		}
		return str;
	}

	public static void GetSk(int nymiHandle, ArrayList<NclEventCreatedSk> symmetricKeys, OnDismissListener dismisser) {
		ProvisioningDialog mDialog=new ProvisioningDialog(mActivity);
		mDialog.setAction(NclHelperAction.GET_SK_SELECT_NYMI, nymiHandle, symmetricKeys);
		mDialog.setOnDismissListener(dismisser);
		mDialog.show();
	}

	public static void Sign(int nymiHandle, ArrayList<NclEventVk> sigKeys, OnDismissListener dismisser) {
		ProvisioningDialog mDialog=new ProvisioningDialog(mActivity);
		mDialog.setAction(NclHelperAction.SIGN_SELECT_NYMI, nymiHandle, sigKeys);
		mDialog.setOnDismissListener(dismisser);
		mDialog.show();		
	}
}
