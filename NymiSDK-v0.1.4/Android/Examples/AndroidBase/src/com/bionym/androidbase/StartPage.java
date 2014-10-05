package com.bionym.androidbase;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.bionym.ncl.helper.*;
import com.bionym.ncl.*;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnDismissListener;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class StartPage extends Activity {

	Button btnInit;
	Button btnDiscover, btnAgree, btnProvision, btnFind, btnSave, btnRevoke, btnStartEcg, btnStopEcg, btnValidate, btnDetect;
	Button btnDisconnect, btnFinish;
	Button btnStartAccel, btnStopAccel, btnStartGyro, btnStopGyro, btnStartGesture, btnStopGesture;
	Button btnCreateSKP, btnSign, btnCrkGSKP, btnGS, btnVerify, btnCrkSig, btnGetSK, btnPrg;
	Button btnRssi, btnFirmware, btnStatus, btnNotify;
	Button btnStopScan, btnMirror;

	public static int nymiHandle = -1;
	public static ArrayList<NclProvision> provisions = new ArrayList<NclProvision>();
	public static char[] vkid;
	public static char[] vk;
	public static char[] sig;
	public static char[] globalVk;
	public static char[] globalVkid;
	public static char[] globalSig;
	public static char[] message = "TESTING".toCharArray();

	NclEventType last_event;
	NclCallback cb;
	
	public static ArrayList<NclEventCreatedSk> symmetricKeys = new ArrayList<NclEventCreatedSk>();
	public static ArrayList<NclEventVk> sigKeys = new ArrayList<NclEventVk>();

	public static char[] partnerPublicKey = new char[] { 0x71, 0x88, 0xee, 0xb, 0xf4, 0xd2, 0xe1, 0x74, 0xca, 0x5e, 0x29, 0x50, 0xe7, 0xaa, 0x24, 0x7d, 0x8a, 0xe8, 0xf0, 0x76, 0x95, 0x5, 0xea, 0x9d,
			0xf1, 0xc6, 0xd1, 0xa6, 0x10, 0x55, 0xdb, 0x2, 0xed, 0x60, 0x1c, 0xa0, 0x7c, 0xa4, 0x9e, 0x52, 0xf8, 0x0, 0xa5, 0xec, 0xf9, 0xac, 0x54, 0xfa, 0xac, 0xff, 0x4f, 0x44, 0x19, 0x8f, 0xb8,
			0x7e, 0x45, 0xaf, 0xf1, 0x8d, 0x9b, 0xc, 0xaf, 0x2d };
	public static char[] partnerPrivateKey = new char[] { 0x3a, 0x41, 0x26, 0x1a, 0xcf, 0xe1, 0xe0, 0x31, 0xf4, 0xa1, 0x8b, 0x24, 0x85, 0xa4, 0x97, 0xdc, 0x31, 0xab, 0x75, 0xc1, 0x3a, 0xc, 0x2, 0xa8,
			0x4f, 0x52, 0xa1, 0xec, 0xa6, 0x71, 0xe2, 0x61 };
	public static char[] bionymSignature = new char[] { 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x0, 0x0, 0x0, 0x0,
			0x0, 0x0, 0x0, 0x4, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x5, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x6, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x7, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x8 };

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);

		setContentView(R.layout.activity_start_page);

		loadProvisions();

		btnInit = (Button) findViewById(R.id.btnInit);
		btnDiscover = (Button) findViewById(R.id.btnDiscover);
		btnAgree = (Button) findViewById(R.id.btnAgree);
		btnProvision = (Button) findViewById(R.id.btnProvision);
		btnFind = (Button) findViewById(R.id.btnFind);
		btnDetect = (Button) findViewById(R.id.btnDetect);
		btnValidate = (Button) findViewById(R.id.btnValidate);
		btnSave = (Button) findViewById(R.id.btnSave);
		btnRevoke = (Button) findViewById(R.id.btnRevoke);
		btnRssi = (Button) findViewById(R.id.btnRssi);
		btnStartEcg = (Button) findViewById(R.id.btnStartEcg);
		btnStopEcg = (Button) findViewById(R.id.btnStopEcg);
		btnDisconnect = (Button) findViewById(R.id.btnDisconnect);
		btnFinish = (Button) findViewById(R.id.btnFinish);
		btnStopScan = (Button) findViewById(R.id.btnStopScan);
		btnMirror= (Button) findViewById(R.id.btnMirror);

		btnStartAccel = (Button) findViewById(R.id.btnStartAccel);
		btnStopAccel = (Button) findViewById(R.id.btnStopAccel);
		btnStartGyro = (Button) findViewById(R.id.btnStartGyro);
		btnStopGyro = (Button) findViewById(R.id.btnStopGyro);
		btnStartGesture = (Button) findViewById(R.id.btnStartGes);
		btnStopGesture = (Button) findViewById(R.id.btnStopGes);
		btnCreateSKP = (Button) findViewById(R.id.btnCrkSKP);
		btnSign = (Button) findViewById(R.id.btnSign);
		btnCrkGSKP = (Button) findViewById(R.id.btnCrkGSKP);
		btnGS = (Button) findViewById(R.id.btnGS);
		btnVerify = (Button) findViewById(R.id.btnVerify);
		btnCrkSig = (Button) findViewById(R.id.btnCrkSig);
		btnGetSK = (Button) findViewById(R.id.btnGetSK);
		btnPrg = (Button) findViewById(R.id.btnPrg);

		btnFirmware = (Button) findViewById(R.id.btnFirmware);
		btnStatus = (Button) findViewById(R.id.btnStatus);
		btnNotify = (Button) findViewById(R.id.btnNotify);

		((TextView) findViewById(R.id.txtViewLog)).setMovementMethod(new ScrollingMovementMethod());
		
		//NclHelper.initialize(this);
		
		// IMPORTANT ****
		// If you are running on he emulator, ip should be "10.0.2.2"
		// If you are running on a device, change it to the IP of the address
		//String ip = "10.0.2.2";
		String ip ="10.0.1.92";
		//NclHelper.initialize(this, ip, 9089);
		NclHelper.initialize(this);
		
		final String path = Environment.getExternalStorageDirectory() + "";
		cb = new NclCallback(this, "HandleCallBack", NclEventType.NCL_EVENT_ANY);
		new Thread(new Runnable() {
			@Override
			public void run() {
				Boolean b = Ncl.init(cb, null, "LOCK", NclMode.NCL_MODE_DEFAULT, path + "/AB_MIRROR.txt");
			}
		}).start();

		btnDiscover.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				NclHelper.discoverAllNymis(new OnDismissListener() {
					@Override
					public void onDismiss(DialogInterface dialog) {
						if (((ProvisioningDialog) dialog).result == ProvisioningDialog.SUCCESS) {
							provisions.add(((ProvisioningDialog) dialog).provision);
						}
						else {
							((ProvisioningDialog) dialog).errorHandle();
						}
					}
				});
				return;
			}
		});

		btnFind.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				NclHelper.SelectFind(provisions, new OnDismissListener() {

					@Override
					public void onDismiss(DialogInterface dialog) {
						if (((ProvisioningDialog) dialog).result == ProvisioningDialog.SUCCESS) {
							nymiHandle = ((ProvisioningDialog) dialog).getConnectedNymiHandle();
							return;
						}

					}
				});

			}
		});

		btnDetect.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.startFinding(null, 0, NclBool.NCL_TRUE);
			}
		});

		btnSave.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Save();
			}
		});
		
		btnMirror.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				if(!Ncl.mirror(nymiHandle))
					writeToAppLog("Ncl.mirror("+nymiHandle+") returned False\n");
				
			}
		});

		btnRevoke.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				provisions.clear();
			}
		});

		btnStartEcg.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.startEcgStream(nymiHandle);
			}
		});

		btnStopEcg.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.stopEcgStream(nymiHandle);
			}
		});

		btnRssi.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.getRssi(nymiHandle);
			}
		});

		btnDisconnect.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.disconnect(nymiHandle);
			}
		});

		btnStartAccel.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.startAccelStream(nymiHandle);
			}
		});

		btnStopAccel.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Ncl.stopAccelStream(nymiHandle);
			}
		});

		btnStartGyro.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.startGyroStream(nymiHandle);
			}
		});

		btnStopGyro.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Ncl.stopGyroStream(nymiHandle);
			}
		});

		btnStartGesture.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.startGestureStream(nymiHandle);
			}
		});

		btnStopGesture.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Ncl.stopGestureStream(nymiHandle);
			}
		});

		btnCreateSKP.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.createSigKeyPair(nymiHandle);

			}
		});

		btnSign.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				NclHelper.Sign(nymiHandle, sigKeys, new OnDismissListener() {

					@Override
					public void onDismiss(DialogInterface dialog) {
						vk=ProvisioningDialog.nclVK.vk;
						sig=ProvisioningDialog.nclSig.sig;
						message=ProvisioningDialog.message;

					}
				});

			}
		});

		btnCrkGSKP.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.createGlobalSigKeyPair(nymiHandle, partnerPublicKey, bionymSignature);
			}
		});

		btnGS.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (!Ncl.globalSign(nymiHandle, partnerPrivateKey, partnerPublicKey, message)) {
					writeToAppLog("Failed to Global Sign\n");
				}

			}
		});

		btnVerify.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (last_event != null) {
					switch (last_event) {
						case NCL_EVENT_SIG: {
							Toast.makeText(StartPage.this, 
									StartPage.this.getString(R.string.nymi_verify_message, Ncl.verify(vk, sig, message)), 
									Toast.LENGTH_LONG).show();
							break;
						}
						case NCL_EVENT_GLOBAL_SIG: {
							Toast.makeText(StartPage.this, 
									StartPage.this.getString(R.string.nymi_global_verify_message, Ncl.verify(globalVk, globalSig, message)), 
									Toast.LENGTH_LONG).show();
							break;
						}
					}
				}
			}
		});

		btnCrkSig.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.createSk(nymiHandle);
			}
		});

		btnGetSK.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				NclHelper.GetSk(nymiHandle, symmetricKeys, new OnDismissListener() {

					@Override
					public void onDismiss(DialogInterface dialog) {
						// TODO Auto-generated method stub

					}
				});
				// Ncl.getSk(nymiHandle, crkVkId);

			}
		});

		btnPrg.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.prg(nymiHandle);

			}
		});

		btnFirmware.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.getFirmwareVersion(nymiHandle);

			}
		});

		btnStatus.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.getStatus(nymiHandle);
			}
		});

		btnNotify.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Ncl.notify(nymiHandle, 1);
			}
		});

		btnStopScan.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				writeToAppLog("Stop Scan Clicked\n");
				Ncl.stopScan();

			}
		});

	}

	public void Save() {
		SharedPreferences prefs = this.getSharedPreferences("SK2", Context.MODE_PRIVATE);
		// writeToOnAppLog("Save Clicked\n", 1);
		JSONObject jObj = new JSONObject();
		JSONArray jArray = new JSONArray();

		JSONObject jPro = null;
		JSONArray jKey = null;
		JSONArray jId = null;

		for (NclProvision p : provisions) {
			// nclCalls.nclFind(p.key, p.id);

			jPro = new JSONObject();
			jKey = new JSONArray();
			jId = new JSONArray();

			for (int a = 0; a < NclProvision.NCL_PROVISION_KEY_SIZE; a++) {
				jKey.put(p.key[a]);
				jId.put(p.id[a]);
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
		}
		try {
			jObj.put("provisions", jArray);
			Log.d("Java Code", jObj.toString());
		}
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SharedPreferences.Editor editor = prefs.edit();
		editor.putString("provisions", jObj.toString());
		editor.commit();
	}

	public void loadProvisions() {
		final SharedPreferences prefs = this.getSharedPreferences("SK2", Context.MODE_PRIVATE);

		String str = prefs.getString("provisions", "NULL");

		if (!str.equals("NULL")) {
			getSavedProvisions(str);
		}
	}

	private void getSavedProvisions(String str) {
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
			provisions.add(p);

		}

	}

	public void writeToAppLog(final String txt) {
		// txtViewLog.append(txt);

		runOnUiThread(new Runnable() {

			@Override
			public void run() {
				TextView txtView = ((TextView) findViewById(R.id.txtViewLog));
				txtView.append(txt);
				int height = txtView.getHeight();
				int lines = txtView.getLineCount();
				int lineHeight = txtView.getLineHeight();
				if (height < lines * lineHeight) {
					txtView.scrollTo(0, (lines - 1) * lineHeight - height);
				}

			}
		});

	}

	Handler ledHandler = new Handler();
	int agreement_pattern = 0;

	public void HandleCallBack(NclEvent event, Object userData) {

		Log.d("HandleCallBack", "NclEvent: " + event.type);

		switch (event.type) {
			case NCL_EVENT_ERROR: {
				writeToAppLog("NCL_EVENT_ERROR\n");
				break;
			}
		
			case NCL_EVENT_INIT: {
				writeToAppLog("NCL_EVENT_INIT Returned " + NclBool.values()[event.init.success] + "\n");
				// Ncl.startDiscovery();
				break;
			}

			case NCL_EVENT_DISCOVERY: {
				writeToAppLog("NCL_EVENT_DISCOVERY\n" +
						"NymiHandle: " + event.discovery.nymiHandle + "   Rssi: " + event.discovery.rssi + "    TxPowerLevel: " + event.discovery.txPowerLevel + "\n");
				break;
			}

			case NCL_EVENT_FIND: {
				writeToAppLog("NCL_EVENT_FIND\nNymiHandle: " + event.find.nymiHandle + "   Rssi: " + event.find.rssi + "    TxPowerLevel: " + event.find.txPowerLevel + "\n");
				break;
			}

			case NCL_EVENT_DETECTION: {
				writeToAppLog("NCL_EVENT_DETECTION\nNymiHandle: " + event.detection.nymiHandle + "   Rssi: " + event.detection.rssi + "    TxPowerLevel: " + event.detection.txPowerLevel + "\n");
				break;
			}

			case NCL_EVENT_AGREEMENT: {
				writeToAppLog("NCL_EVENT_AGREEMENT\n");
				break;
			}

			case NCL_EVENT_PROVISION: {
				writeToAppLog("NCL_EVENT_PROVISION\n");
				break;
			}

			case NCL_EVENT_VALIDATION: {
				writeToAppLog("NCL_EVENT_VALIDATION\n");
				break;
			}

			case NCL_EVENT_ECG_START: {
				writeToAppLog("NCL_EVENT_ECG_START\n");
				break;
			}

			case NCL_EVENT_ECG: {
				for (short data : event.ecg.samples) {
					writeToAppLog(data + " ");
				}
				writeToAppLog("\n");
				break;
			}

			case NCL_EVENT_ECG_STOP: {
				writeToAppLog("NCL_EVENT_ECG_STOP\n");
				// nymiHandle = event.ecgStop.nymiHandle;
				break;
			}

			case NCL_EVENT_ACCEL_START: {
				writeToAppLog("NCL_EVENT_ACCEL_START\n");
				// nymiHandle = event.accelStart.nymiHandle;
				break;
			}
			case NCL_EVENT_ACCEL: {
				writeToAppLog(event.accel.x + "	" + event.accel.y + "		" + event.accel.z + "");
				writeToAppLog("\n");
				break;
			}
			case NCL_EVENT_ACCEL_STOP: {
				writeToAppLog("NCL_EVENT_ACCEL_STOP\n");
				nymiHandle = event.accelStop.nymiHandle;
				break;
			}
			case NCL_EVENT_GYRO_START: {
				writeToAppLog("NCL_EVENT_GYRO_START\n");
				nymiHandle = event.gyroStart.nymiHandle;
				break;
			}
			case NCL_EVENT_GYRO: {
				writeToAppLog(event.gyro.x + "	" + event.gyro.y + "		" + event.gyro.z + "");
				writeToAppLog("\n");
				break;
			}
			case NCL_EVENT_GYRO_STOP: {
				writeToAppLog("NCL_EVENT_GYRO_STOP\n");
				nymiHandle = event.gyroStop.nymiHandle;
				break;
			}
			case NCL_EVENT_GESTURE_START: {
				writeToAppLog("NCL_EVENT_GESTURE_START\n");
				nymiHandle = event.gestureStart.nymiHandle;
				break;
			}
			case NCL_EVENT_GESTURE: {
				writeToAppLog("NCL_EVENT_GESTURE\n");
				break;
			}
			case NCL_EVENT_GESTURE_STOP: {
				writeToAppLog("NCL_EVENT_GESTURE_STOP\n");
				nymiHandle = event.gestureStop.nymiHandle;
				break;
			}

			case NCL_EVENT_VK: {
				writeToAppLog("NCL_EVENT_VK\n");
				nymiHandle = event.vk.nymiHandle;
				writeToAppLog("VK: " + NclHelper.SomeWhatReadable(event.vk.vk) + "\n");
				writeToAppLog("ID: " + NclHelper.SomeWhatReadable(event.vk.id) + "\n");
				// vk = event.vk.vk.clone();
				// vkid = event.vk.id.clone();
				sigKeys.add(event.vk);
				break;
			}
			case NCL_EVENT_SIG: {
				writeToAppLog("NCL_EVENT_SIG\n");
				writeToAppLog("Sig: " + NclHelper.SomeWhatReadable(event.sig.sig) + "\n");
				last_event = event.type;
				break;

			}
			case NCL_EVENT_GLOBAL_VK: {
				writeToAppLog("NCL_EVENT_GLOBAL_VK\n");
				nymiHandle = event.globalVk.nymiHandle;
				writeToAppLog("VK: " + NclHelper.SomeWhatReadable(event.globalVk.vk) + "\n");
				writeToAppLog("ID: " + NclHelper.SomeWhatReadable(event.globalVk.id) + "\n");
				globalVk = event.globalVk.vk.clone();
				globalVkid = event.globalVk.id.clone();
				break;
			}
			case NCL_EVENT_GLOBAL_SIG: {
				writeToAppLog("NCL_EVENT_GLOBAL_SIG\n");
				nymiHandle = event.globalSig.nymiHandle;
				writeToAppLog("VKID: " + NclHelper.SomeWhatReadable(event.globalSig.vkId) + "\n");
				writeToAppLog("Sig: " + NclHelper.SomeWhatReadable(event.globalSig.sig) + "\n");
				globalSig = event.globalSig.sig.clone();
				last_event =event.type;
				break;
			}

			case NCL_EVENT_CREATED_SK: {
				writeToAppLog("NCL_EVENT_CREATED_SK\n");
				nymiHandle = event.createdSk.nymiHandle;
				writeToAppLog("SK: " + NclHelper.SomeWhatReadable(event.createdSk.sk) + "\n");
				writeToAppLog("ID: " + NclHelper.SomeWhatReadable(event.createdSk.id) + "\n");
				symmetricKeys.add(event.createdSk);
				break;
			}
			case NCL_EVENT_GOT_SK: {
				writeToAppLog("NCL_EVENT_GOT_SK\n");
				nymiHandle = event.gotSk.nymiHandle;
				writeToAppLog("SK: " + NclHelper.SomeWhatReadable(event.gotSk.sk) + "\n");
				break;
			}
			case NCL_EVENT_PRG: {
				writeToAppLog("NCL_EVENT_PRG\n");
				nymiHandle = event.prg.nymiHandle;
				writeToAppLog("Value: " + NclHelper.SomeWhatReadable(event.prg.value) + "\n");
				break;
			}

			case NCL_EVENT_RSSI: {
				writeToAppLog("NCL_EVENT_RSSI		Rssi:	" + event.rssi.rssi + "\n");
				nymiHandle = event.rssi.nymiHandle;
				break;
			}

			case NCL_EVENT_FIRMWARE_VERSION: {
				writeToAppLog("NCL_EVENT_FIRMWARE_VERSION\n");
				nymiHandle = event.firmwareVersion.nymiHandle;
				for (char c : event.firmwareVersion.version) {
					writeToAppLog(String.format("%01x", (int) c) + " ");
				}
				writeToAppLog("\n");
				break;
			}
			case NCL_EVENT_NOTIFIED: {
				writeToAppLog("NCL_EVENT_NOTIFIED\n");
				nymiHandle = event.notified.nymiHandle;
				break;
			}
			case NCL_EVENT_DISCONNECTION: {
				writeToAppLog("NCL_EVENT_DISCONNECTION\n");
				break;
			}

		}
	}
}
