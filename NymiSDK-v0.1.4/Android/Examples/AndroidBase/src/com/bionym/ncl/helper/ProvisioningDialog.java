package com.bionym.ncl.helper;

import java.util.ArrayList;
import java.util.concurrent.ScheduledThreadPoolExecutor;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.bionym.androidbase.R;
import com.bionym.ncl.Ncl;
import com.bionym.ncl.NclBool;
import com.bionym.ncl.NclCallback;
import com.bionym.ncl.NclEvent;
import com.bionym.ncl.NclEventCreatedSk;
import com.bionym.ncl.NclEventDiscovery;
import com.bionym.ncl.NclEventSig;
import com.bionym.ncl.NclEventType;
import com.bionym.ncl.NclEventVk;
import com.bionym.ncl.NclProvision;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Rect;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RadioButton;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

public class ProvisioningDialog extends Dialog {
	protected static ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(1);
	
	static NclCallback cb;
	static NclHelperAction currentAction;
	
	LinearLayout llPattern;
	TextView txtCurrentStep;
	LinearLayout spinnerLayout;
	LinearLayout llButtonHolder;
	EditText edtMessage;
	ScrollView scrollView;
	LinearLayout llScrollView;

	ArrayList<NclEventDiscoveryListItem> nymis = new ArrayList<NclEventDiscoveryListItem>();

	public static NclProvision provision;

	public static NclEventVk nclVK;
	public static NclEventSig nclSig;
	public static char[] message;

	public int result = -1;
	public static int SUCCESS = 1;

	protected int nymiHandle = -1;
	
	Context context;

	public ProvisioningDialog(Context context) {
		super(context);
		this.context = context;
	}

	@Override
	public void dismiss() {
		if (cb != null) {
			Ncl.removeBehavior(cb);
			cb = null;
		}

		if (currentAction != null) {
			if (currentAction == NclHelperAction.DISCOVER_ALL_NYMIS
					|| currentAction == NclHelperAction.FIND_SELECT_NYMI
					|| currentAction == NclHelperAction.FIND_ALL_NYMIS) {
				Ncl.stopScan();
			} else if (currentAction == NclHelperAction.GET_ACCEL) {
				Ncl.stopAccelStream(nymiHandle);
			} else if (currentAction == NclHelperAction.GET_ECG) {
				Ncl.stopEcgStream(nymiHandle);
			} else if (currentAction == NclHelperAction.GET_GYRO) {
				Ncl.stopGyroStream(nymiHandle);
			} else if (currentAction == NclHelperAction.GET_GESTURE) {
				Ncl.stopGestureStream(nymiHandle);
			}

			currentAction = null;
		}

		super.dismiss();
	}

	public int getConnectedNymiHandle() {
		return nymiHandle;
	}
	
	public void showPattern(final int[] leds) {
		RadioButton rb;
		for (int i = 0; i < llPattern.getChildCount(); i++) {
			rb = (RadioButton) llPattern.getChildAt(i);
			rb.setChecked(false);
			rb.setChecked(leds[i] > 0);
		}

	}

	public void clearPattern() {

		RadioButton rb;
		for (int i = 0; i < llPattern.getChildCount(); i++) {
			rb = (RadioButton) llPattern.getChildAt(i);
			rb.setChecked(false);
		}
	}

	private void nclAgree(int nymiHandle) {
		((Activity) context).runOnUiThread(new Runnable() {

			@Override
			public void run() {
				txtCurrentStep.setText("Agreeing");
				scrollView.setVisibility(View.GONE);
			}
		});

		Ncl.stopScan();
		Ncl.agree(nymiHandle);
	}

	Boolean touchDown = false;

	private View createDiscoveryCell(final NclEventDiscovery d) {
		final RelativeLayout ll = (RelativeLayout) LayoutInflater.from(context).inflate(R.layout.nymi_discovery_item, null);
		final TextView nymiHandle = (TextView) ll.findViewById(R.id.handle);
		final TextView rssi = (TextView) ll.findViewById(R.id.rssi);	
		
		nymiHandle.setText("Nymihandle: " + d.nymiHandle);
		
		rssi.setText("Rssi: " + d.rssi);
		rssi.setGravity(Gravity.CENTER);
		
		View.OnClickListener listener = new View.OnClickListener() {
			@Override
			public void onClick(View paramView) {
				nclAgree(d.nymiHandle);
			}
		};

		ll.setOnClickListener(listener);
		nymiHandle.setOnClickListener(listener);
		rssi.setOnClickListener(listener);

		return ll;
	}

	private LinearLayout createGetSkCell(final NclEventCreatedSk k) {
		final LinearLayout ll = new LinearLayout(context);
		ll.setOrientation(LinearLayout.HORIZONTAL);
		ll.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				LayoutParams.WRAP_CONTENT));

		final TextView txtProvision = new TextView(context);
		txtProvision.setText("Provison: " + SomeWhatReadable(k.id));
		txtProvision.setGravity(Gravity.CENTER);
		txtProvision.setLayoutParams(new TableLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1f));
		txtProvision.setPadding(10, 10, 10, 10);
		txtProvision.setTextColor(Color.parseColor("#33B5E5"));

		ll.addView(txtProvision);

		View.OnClickListener listener = new View.OnClickListener() {

			@Override
			public void onClick(View paramView) {
				Ncl.getSk(nymiHandle, k.id);
				spinnerLayout.setVisibility(View.VISIBLE);
				scrollView.setVisibility(View.GONE);
			}
		};

		ll.setOnClickListener(listener);
		txtProvision.setOnClickListener(listener);

		View.OnTouchListener touchListener = new View.OnTouchListener() {

			@Override
			public boolean onTouch(View view, MotionEvent event) {
				if (event.getAction() == MotionEvent.ACTION_UP) {

					ll.setBackgroundColor(Color.WHITE);
					txtProvision.setTextColor(Color.parseColor("#33B5E5"));
					Ncl.getSk(nymiHandle, k.id);
					spinnerLayout.setVisibility(View.VISIBLE);
					scrollView.setVisibility(View.GONE);
					return true;
				} else if (event.getAction() == MotionEvent.ACTION_DOWN) {
					ll.setBackgroundColor(Color.parseColor("#33B5E5"));
					txtProvision.setTextColor(Color.WHITE);
					return true;
				} else if (event.getAction() == MotionEvent.ACTION_MOVE) {
					Rect rect = new Rect(ll.getLeft(), ll.getTop(),
							ll.getRight(), ll.getBottom());
					if (!rect.contains((int) event.getX(), (int) event.getY())) {
						touchDown = false;
						ll.setBackgroundColor(Color.WHITE);
						txtProvision.setTextColor(Color.parseColor("#33B5E5"));
					}
					return true;
				}
				return false;
			}
		};

		ll.setOnTouchListener(touchListener);
		txtProvision.setOnTouchListener(touchListener);

		return ll;
	}

	private LinearLayout createProvisionCell(final NclProvision p) {
		final LinearLayout ll = new LinearLayout(context);
		ll.setOrientation(LinearLayout.HORIZONTAL);
		ll.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				LayoutParams.WRAP_CONTENT));

		final TextView txtProvision = new TextView(context);
		txtProvision.setText("Provison: " + SomeWhatReadable(p.key));
		txtProvision.setGravity(Gravity.CENTER);
		txtProvision.setLayoutParams(new TableLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1f));
		txtProvision.setPadding(10, 10, 10, 10);
		txtProvision.setTextColor(Color.parseColor("#33B5E5"));

		ll.addView(txtProvision);

		View.OnClickListener listener = new View.OnClickListener() {

			@Override
			public void onClick(View paramView) {
				executor.execute(new Runnable() {
					@Override
					public void run() {
						ArrayList<NclProvision> provisions = new ArrayList<NclProvision>();
						provisions.add(p);
						Ncl.startFinding(provisions, 1, NclBool.NCL_FALSE);
					}
				});

				spinnerLayout.setVisibility(View.VISIBLE);
				scrollView.setVisibility(View.GONE);
			}
		};

		ll.setOnClickListener(listener);
		txtProvision.setOnClickListener(listener);

		View.OnTouchListener touchListener = new View.OnTouchListener() {

			@Override
			public boolean onTouch(View view, MotionEvent event) {
				if (event.getAction() == MotionEvent.ACTION_UP) {

					ll.setBackgroundColor(Color.WHITE);
					txtProvision.setTextColor(Color.parseColor("#33B5E5"));
					ArrayList<NclProvision> provisions = new ArrayList<NclProvision>();
					provisions.add(p);
					Ncl.startFinding(provisions, 1, NclBool.NCL_FALSE);
					spinnerLayout.setVisibility(View.VISIBLE);
					scrollView.setVisibility(View.GONE);
					return true;
				} else if (event.getAction() == MotionEvent.ACTION_DOWN) {
					ll.setBackgroundColor(Color.parseColor("#33B5E5"));
					txtProvision.setTextColor(Color.WHITE);
					return true;
				} else if (event.getAction() == MotionEvent.ACTION_MOVE) {
					Rect rect = new Rect(ll.getLeft(), ll.getTop(),
							ll.getRight(), ll.getBottom());
					if (!rect.contains((int) event.getX(), (int) event.getY())) {
						touchDown = false;
						ll.setBackgroundColor(Color.WHITE);
						txtProvision.setTextColor(Color.parseColor("#33B5E5"));
					}
					return true;
				}
				return false;
			}
		};

		ll.setOnTouchListener(touchListener);
		txtProvision.setOnTouchListener(touchListener);

		return ll;
	}

	private ViewGroup createCell(char[] id, final android.view.View.OnClickListener listener) {
		final ViewGroup ll = (ViewGroup) LayoutInflater.from(context).inflate(R.layout.nymi_find_item, null);
		
		final TextView txtProvision = (TextView) ll.findViewById(R.id.provision);
		txtProvision.setText(SomeWhatReadable(id));
		
		ll.setOnClickListener(listener);

		return ll;
	}

	private void Save(String string, char[] array) {
		JSONArray jArray = new JSONArray();
		for (int a = 0; a < array.length; a++) {
			jArray.put(array[a]);
		}
		NymiSharedPreferences.addToPref(string, jArray.toString());
	}

	public void Save(NclProvision p) {
		JSONObject jObj = new JSONObject();
		JSONArray jArray = new JSONArray();

		JSONObject jPro = new JSONObject();
		JSONArray jKey = new JSONArray();
		JSONArray jId = new JSONArray();

		for (int a = 0; a < NclProvision.NCL_PROVISION_KEY_SIZE; a++) {
			jKey.put(p.key[a]);
			jId.put(p.id[a]);
		}
		try {
			jPro.putOpt("key", jKey);
			jPro.putOpt("id", jId);
			jArray.put(jPro);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			jObj.put("provisions", jArray);
			Log.d("Java Code", jObj.toString());
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		NymiSharedPreferences.addToPref(Constants.Provisions, jObj.toString());
	}

	public boolean setAction(NclHelperAction action, int nymiHandle, Object obj) {
		if (action == null) {
			Log.w(getClass().getName(), "Previous action has not yet been dismissed!");
			return false;
		}

		currentAction = action;
		this.nymiHandle = nymiHandle;
		if (cb != null) {
			Ncl.removeBehavior(cb);
		}

		cb = new NclCallback(this, action.toString(),
				NclEventType.NCL_EVENT_ANY);
		Ncl.addBehavior(cb);

		switch (action) {
		case DISCOVER_ALL_NYMIS:
			createDiscoverAllNymisView();
			Ncl.startDiscovery();
			break;
		case FIND_SELECT_NYMI:
			if (obj != null && obj instanceof ArrayList && ((ArrayList<?>) obj).size() > 0) {
				createFindSelectNymisView((ArrayList<NclProvision>) obj);
			} else {
				Toast.makeText(context, context.getText(R.string.no_provision), Toast.LENGTH_SHORT).show();
				return false;
			}
			break;
		default:
		}

		return true;
	}

	public void DISCOVER_ALL_NYMIS(NclEvent e, Object userData) {
		final NclEvent event = e;
		Log.d("DISCOVER_ALL_NYMIS", "callback: " + event.type);
		switch (event.type) {
		case NCL_EVENT_INIT:
			break;
		case NCL_EVENT_DISCOVERY:
			((Activity) context).runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Boolean isNew = true;
					Boolean shouldRemove = false;
					for (NclEventDiscoveryListItem d : nymis) {
						if (d.nymiHandle == event.discovery.nymiHandle) {
							d.rssi = event.discovery.rssi;
							isNew = false;
							d.lastUpdate = System.currentTimeMillis();
						}
					}
					if (isNew) {
						NclEventDiscoveryListItem i = new NclEventDiscoveryListItem();
						i.nymiHandle = event.discovery.nymiHandle;
						i.rssi = event.discovery.rssi;
						i.lastUpdate = System.currentTimeMillis();
						nymis.add(i);
						View cell = createDiscoveryCell(i);
						llScrollView.addView(cell);
					}

					for (NclEventDiscoveryListItem d : nymis) {
						int i = llScrollView.getChildCount();
						for (int a = 0; a < i; a++) {
							View v = llScrollView.getChildAt(a);
							View n = (((ViewGroup) v).getChildAt(0));
							if (((TextView) n).getText().toString()
									.equals("Nymihandle: " + d.nymiHandle + "")) {
								if (System.currentTimeMillis() - d.lastUpdate > NclEventDiscoveryListItem.DNE_After) {
									llScrollView.removeViewAt(a);

								}
								break;
							}
						}
					}

					for (NclEventDiscoveryListItem d : nymis) {
						int i = llScrollView.getChildCount();
						for (int a = 0; a < i; a++) {
							View v = llScrollView.getChildAt(a);
							View n = (((ViewGroup) v).getChildAt(0));
							if (((TextView) n).getText().toString()
									.equals("Nymihandle: " + d.nymiHandle + "")) {
								View r = (((ViewGroup) v).getChildAt(1));
								((TextView) r).setText("Rssi: " + d.rssi);
							}
						}
					}

					llScrollView.invalidate();

				}
			});

			break;
		case NCL_EVENT_AGREEMENT:
			((Activity) context).runOnUiThread(new Runnable() {
				@Override
				public void run() {
					spinnerLayout.setVisibility(View.GONE);
					llPattern.setVisibility(View.VISIBLE);
					showPattern(event.agreement.leds[0]);
					llButtonHolder.setVisibility(View.VISIBLE);
				}
			});

			nymiHandle = event.agreement.nymiHandle;
			break;
		case NCL_EVENT_PROVISION:
			((Activity) context).runOnUiThread(new Runnable() {

				@Override
				public void run() {
					clearPattern();
					provision = event.provision.provision;
					// com.bionym.ncl.helper.SaveProvision(event.provision.provision);
					result = 1;
					if (isShowing()) {
						dismiss();
					}
				}
			});

			break;
		case NCL_EVENT_ERROR:
			((Activity) context).runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Toast.makeText(context, context.getString(R.string.nymi_failed), Toast.LENGTH_LONG).show();
				}
			});
			break;
		case NCL_EVENT_DISCONNECTION:
			if (isShowing()) {
				dismiss();
			}
			break;
		default:
		}
	}

	public void FIND_SELECT_NYMI(NclEvent e, Object userData) {
		final NclEvent event = e;

		Log.d("FIND_SELECT_NYMI", "callback: " + event.type);
		switch (event.type) {
		case NCL_EVENT_INIT:
			break;
		case NCL_EVENT_FIND:
			nymiHandle = event.find.nymiHandle;
			Log.d("FIND_SELECT_NYMI", "vValidating...: " + event.type);
			Ncl.validate(nymiHandle);
			break;
		case NCL_EVENT_VALIDATION:
			Log.d("FIND_SELECT_NYMI", "Validated" + event.type);
			nymiHandle = event.validation.nymiHandle;
			result = ProvisioningDialog.SUCCESS;
			((Activity) context).runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Toast.makeText(context, context.getString(R.string.nymi_validated, nymiHandle), Toast.LENGTH_LONG).show();
					if (isShowing()) {
						dismiss();
					}
				}
			});
			break;
		case NCL_EVENT_ERROR:
			((Activity) context).runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Toast.makeText(context, context.getString(R.string.nymi_failed), Toast.LENGTH_LONG).show();
				}
			});
			break;
		case NCL_EVENT_DISCONNECTION:
			break;
		default:
		}
	}

	private void createCreateSKView() {
		setTitle("Creating SK");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Finding");

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);

		llMain.addView(txtCurrentStep);
		llMain.addView(spinnerLayout);

		this.setContentView(llMain);
	}

	private void createProvisionView() {
		setTitle("Provisioning Nymi");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Discovering");

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);

		llPattern = new LinearLayout(context);
		RadioButton rb;
		for (int i = 0; i < 5; i++) {
			rb = new RadioButton(context);
			llPattern.addView(rb);
		}
		llPattern.setGravity(Gravity.CENTER);
		llPattern.setVisibility(View.GONE);

		llButtonHolder = new LinearLayout(context);
		llButtonHolder.setOrientation(LinearLayout.HORIZONTAL);
		llButtonHolder.setGravity(Gravity.CENTER);

		Button btnAgree = new Button(context);
		btnAgree.setText("Agree");

		Button btnDecline = new Button(context);
		btnDecline.setText("Decline");

		btnAgree.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				txtCurrentStep.setText("Provisioning");
				Ncl.provision(nymiHandle);
			}
		});

		llButtonHolder.addView(btnAgree);
		llButtonHolder.addView(btnDecline);
		llButtonHolder.setVisibility(View.GONE);

		llMain.addView(txtCurrentStep);
		llMain.addView(spinnerLayout);
		llMain.addView(llPattern);
		llMain.addView(llButtonHolder);

		this.setContentView(llMain);

	}

	private void createGetKeyView() {
		setTitle("Getting SK");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Finding");

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);

		llMain.addView(txtCurrentStep);
		llMain.addView(spinnerLayout);

		this.setContentView(llMain);
	}

	private void createSignSelectNymisView(ArrayList<NclEventVk> keys) {
		setTitle("Sign Message");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Select Key");

		edtMessage = new EditText(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Your Message Here");

		scrollView = new ScrollView(context);
		scrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				250));
		llScrollView = new LinearLayout(context);
		llScrollView.setOrientation(LinearLayout.VERTICAL);
		llScrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				LayoutParams.WRAP_CONTENT));

		for (final NclEventVk k : keys) {
			ViewGroup cell = createCell(k.id, new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					spinnerLayout.setVisibility(View.VISIBLE);
					scrollView.setVisibility(View.GONE);
					executor.execute(new Runnable() {
						@Override
						public void run() {
							nclVK = k;
							message = edtMessage.getText().toString().toCharArray();
							Ncl.sign(nymiHandle, k.id, message);
						}
					});
				}
			});
			
			llScrollView.addView(cell);
		}

		scrollView.addView(llScrollView);

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);
		spinnerLayout.setLayoutParams(new LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);
		spinnerLayout.setVisibility(View.GONE);

		llButtonHolder = new LinearLayout(context);
		llButtonHolder.setOrientation(LinearLayout.HORIZONTAL);
		llButtonHolder.setGravity(Gravity.CENTER);

		Button btnValidate = new Button(context);
		btnValidate.setText("btnValidate");

		Button btnDecline = new Button(context);
		btnDecline.setText("Decline");

		btnValidate.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				txtCurrentStep.setText("Validating");
				Ncl.provision(nymiHandle);
			}
		});

		llButtonHolder.addView(btnValidate);
		llButtonHolder.addView(btnDecline);
		llButtonHolder.setVisibility(View.GONE);

		llMain.addView(txtCurrentStep);
		llMain.addView(edtMessage);
		llMain.addView(scrollView);
		llMain.addView(spinnerLayout);
		llMain.addView(llButtonHolder);

		this.setContentView(llMain);

	}

	private void createGetSkSelectNymisView(ArrayList<NclEventCreatedSk> keys) {
		setTitle("Get Sk");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Select Id");

		scrollView = new ScrollView(context);
		scrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				250));
		llScrollView = new LinearLayout(context);
		llScrollView.setOrientation(LinearLayout.VERTICAL);
		llScrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				LayoutParams.WRAP_CONTENT));

		for (final NclEventCreatedSk k : keys) {
			ViewGroup cell = createCell(k.id, new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					spinnerLayout.setVisibility(View.VISIBLE);
					scrollView.setVisibility(View.GONE);
					executor.execute(new Runnable() {
						@Override
						public void run() {
							Ncl.getSk(nymiHandle, k.id);
		
						}
					});
				}
			});
			
			llScrollView.addView(cell);
		}

		scrollView.addView(llScrollView);

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);
		spinnerLayout.setLayoutParams(new LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);
		spinnerLayout.setVisibility(View.GONE);

		llButtonHolder = new LinearLayout(context);
		llButtonHolder.setOrientation(LinearLayout.HORIZONTAL);
		llButtonHolder.setGravity(Gravity.CENTER);

		Button btnValidate = new Button(context);
		btnValidate.setText("btnValidate");

		Button btnDecline = new Button(context);
		btnDecline.setText("Decline");

		btnValidate.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				txtCurrentStep.setText("Validating");
				Ncl.provision(nymiHandle);
			}
		});

		llButtonHolder.addView(btnValidate);
		llButtonHolder.addView(btnDecline);
		llButtonHolder.setVisibility(View.GONE);

		llMain.addView(txtCurrentStep);
		llMain.addView(scrollView);
		llMain.addView(spinnerLayout);
		llMain.addView(llButtonHolder);

		this.setContentView(llMain);

	}

	private void createFindSelectNymisView(ArrayList<NclProvision> provisions) {
		setTitle("Find Nymi");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Select Provision");

		scrollView = new ScrollView(context);
		scrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				250));
		llScrollView = new LinearLayout(context);
		llScrollView.setOrientation(LinearLayout.VERTICAL);
		llScrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));

		for (final NclProvision p : provisions) {
			ViewGroup cell = createCell(p.id, new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					spinnerLayout.setVisibility(View.VISIBLE);
				scrollView.setVisibility(View.GONE);
					executor.execute(new Runnable() {
						@Override
						public void run() {
							ArrayList<NclProvision> provisions = new ArrayList<NclProvision>();
							provisions.add(p);
							Ncl.startFinding(provisions, 1, NclBool.NCL_FALSE);
						}
					});
				}
			});
			
			llScrollView.addView(cell);
		}

		scrollView.addView(llScrollView);

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);
		spinnerLayout.setLayoutParams(new LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);
		spinnerLayout.setVisibility(View.GONE);

		llButtonHolder = new LinearLayout(context);
		llButtonHolder.setOrientation(LinearLayout.HORIZONTAL);
		llButtonHolder.setGravity(Gravity.CENTER);

		Button btnValidate = new Button(context);
		btnValidate.setText("btnValidate");

		Button btnDecline = new Button(context);
		btnDecline.setText("Decline");

		btnValidate.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				txtCurrentStep.setText("Validating");
				Ncl.validate(nymiHandle);
			}
		});

		llButtonHolder.addView(btnValidate);
		llButtonHolder.addView(btnDecline);
		llButtonHolder.setVisibility(View.GONE);

		llMain.addView(txtCurrentStep);
		llMain.addView(scrollView);
		llMain.addView(spinnerLayout);
		llMain.addView(llButtonHolder);

		this.setContentView(llMain);
	}

	private void createDiscoverAllNymisView() {
		setTitle("Discoving Nymi's");

		LinearLayout llMain = new LinearLayout(context);
		llMain.setOrientation(LinearLayout.VERTICAL);

		txtCurrentStep = new TextView(context);
		txtCurrentStep.setGravity(Gravity.CENTER);
		txtCurrentStep.setText("Discovering");

		scrollView = new ScrollView(context);
		scrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				250));
		llScrollView = new LinearLayout(context);
		llScrollView.setOrientation(LinearLayout.VERTICAL);
		llScrollView.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
				LayoutParams.WRAP_CONTENT));
		scrollView.addView(llScrollView);

		spinnerLayout = new LinearLayout(context);
		spinnerLayout.setGravity(Gravity.CENTER);

		ProgressBar progressBar = new ProgressBar(context, null, android.R.attr.progressBarStyle);

		spinnerLayout.addView(progressBar);

		llPattern = new LinearLayout(context);
		RadioButton rb;
		for (int i = 0; i < 5; i++) {
			rb = new RadioButton(context);
			llPattern.addView(rb);
		}
		llPattern.setGravity(Gravity.CENTER);
		llPattern.setVisibility(View.GONE);

		llButtonHolder = new LinearLayout(context);
		llButtonHolder.setOrientation(LinearLayout.HORIZONTAL);
		llButtonHolder.setGravity(Gravity.CENTER);

		Button btnAgree = new Button(context);
		btnAgree.setText("Agree");

		Button btnDecline = new Button(context);
		btnDecline.setText("Decline");

		btnAgree.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				txtCurrentStep.setText("Provisioning");
				Ncl.provision(nymiHandle);
			}
		});

		llButtonHolder.addView(btnAgree);
		llButtonHolder.addView(btnDecline);
		llButtonHolder.setVisibility(View.GONE);

		llMain.addView(txtCurrentStep);
		llMain.addView(scrollView);
		llMain.addView(spinnerLayout);
		llMain.addView(llPattern);
		llMain.addView(llButtonHolder);

		this.setContentView(llMain);
	}

	public NclProvision loadProvision() {
		// final SharedPreferences prefs =
		// this.getSharedPreferences("com.bionyum.skeleton_code",
		// Context.MODE_PRIVATE);

		String str = NymiSharedPreferences.getFromPref("Provision");// prefs.getString("provisions",
																	// "NULL");

		if (!str.equals("nothing")) {
			return getSavedProvisions(str);
		}
		return null;
	}

	private NclProvision getSavedProvisions(String str) {
		JSONObject jObj = null;
		JSONArray jArray = null;

		JSONObject jPro = null;
		JSONArray jKey = new JSONArray();
		JSONArray jId = new JSONArray();
		try {
			jObj = new JSONObject(str);
			jArray = jObj.getJSONArray("provisions");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int len = jArray.length();

		for (int i = 0; i < len; i++) {
			try {
				jPro = jArray.getJSONObject(i);
				jKey = jPro.getJSONArray("key");
				jId = jPro.getJSONArray("id");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			NclProvision p = new NclProvision();
			for (int a = 0; a < NclProvision.NCL_PROVISION_KEY_SIZE; a++) {
				try {
					p.key[a] = (char) jKey.getInt(a);
					p.id[a] = (char) jId.getInt(a);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return (p);

		}
		return null;

	}

	public class NclEventDiscoveryListItem extends NclEventDiscovery {
		public static final int DNE_After = 1000;
		public long lastUpdate = 0;
		Boolean isNew = true;
	}

	public void errorHandle() {
		Ncl.stopScan();
		if (cb != null) {
			Ncl.removeBehavior(cb);
		}
	}

	protected static String SomeWhatReadable(char[] arr) {
		String str = "";
		if (arr != null && arr.length > 0) {
			for (char c : arr) {
				str += ((int) c) + " ";
			}
		}

		return str;
	}
}
