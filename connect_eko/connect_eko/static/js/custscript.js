// On Document Ready...............
$(function()
{
	//  Multi Select dropdown -->
	$('.selectpicker').selectpicker();		// OPTIONS: {'selectedText': 'CSP'}


	// Make first base-commission value editable
	editableBaseComm('#base-rid1');


	// Make slab-values-input editable in table
	editableSlabRange('#slab-rid1');

	// Show EDIT tooltip on EDIT icons
	$('.glyphicon.glyphicon-pencil').tooltip({title:'Edit', placement:'auto right', container:'body'});

	// jsTree
	$("#csptreelist").jstree({
			// the `plugins` array allows you to configure the active plugins on this instance
			"plugins" : ["themes","html_data","ui","crrm","hotkeys","checkbox"],
			// each plugin you have included can have its own config object
			"core" : {
				"animation" : 100,
				"initially_open" : [ "phtml_1" ]
			},
			// set a theme
			"themes" : {
		    "theme" : "proton",
		    "icons" : false

		},
		});
});

// x-editable helper functions......................
function editableSlabRange(inp_id)
{
	$(inp_id).editable
	({
		value: {
			city: "",
			street: ""
		},

		validate: function(value)
		{
			if ((value.city=="" || value.city=="0") && (value.street=="0" || value.street=="")) return 'slab range cannot be blank';
		},
		
		url: function (params)
		{
			// Adding start slab value to form
			if(typeof document.frmcomm["start"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["start"+params.name].value=params.value.city;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "start"+params.name);
				inp.setAttribute("value", params.value.city);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add end slab value to form
			if(typeof document.frmcomm["end"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["end"+params.name].value=params.value.street;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "end"+params.name);
				inp.setAttribute("value", params.value.street);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}

function editableBaseComm(inp_id)
{
	$(inp_id).editable
	({
		emptytext: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
		title: 'Enter Base Commission',

		validate: function(value)
		{
			//TODO
		},
		
		url: function (params)
		{
			// Adding commission value to form............................
			if(typeof document.frmcomm["val-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["val-"+params.name].value=params.value.val;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "val-"+params.name);
				inp.setAttribute("value", params.value.val);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add commission value-type (rupees or percent) to form.......
			if (typeof document.frmcomm["type-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["type-"+params.name].value = params.value.val_type_selected;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "type-"+params.name);
				inp.setAttribute("value", params.value.val_type_selected);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}

function editableSourceIncentive(inp_id)
{
	$(inp_id).editable
	({
		emptytext: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
		title: 'Enter Source',
		validate: function(value)
		{
			//TODO
		},
		
		url: function (params)
		{
			// Adding commission value to form............................
			if(typeof document.frmcomm["val-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["val-"+params.name].value=params.value.val;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "val-"+params.name);
				inp.setAttribute("value", params.value.val);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add commission value-type (rupees or percent) to form.......
			if (typeof document.frmcomm["type-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["type-"+params.name].value = params.value.val_type_selected;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "type-"+params.name);
				inp.setAttribute("value", params.value.val_type_selected);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}

function editableTargetHeadIncentive(inp_id)
{
	$(inp_id).editable
	({
		emptytext: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
		validate: function(value)
		{
			if($.trim(value)=='') return 'This field is required';
		},
		url: function (params)
		{
			// Adding commission value to form............................
			if(typeof document.frmcomm["val-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["val-"+params.name].value=params.value.val;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "val-"+params.name);
				inp.setAttribute("value", params.value.val);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add commission value-type (rupees or percent) to form.......
			if (typeof document.frmcomm["type-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["type-"+params.name].value = params.value.val_type_selected;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "type-"+params.name);
				inp.setAttribute("value", params.value.val_type_selected);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}

function editableTargetBodyIncentive(inp_id)
{
	$(inp_id).editable
	({
		emptytext: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
		validate: function(value)
		{
			if($.trim(value)=='') return 'This field is required';
		},
		url: function (params)
		{
			// Adding commission value to form............................
			if(typeof document.frmcomm["val-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["val-"+params.name].value=params.value.val;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "val-"+params.name);
				inp.setAttribute("value", params.value.val);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add commission value-type (rupees or percent) to form.......
			if (typeof document.frmcomm["type-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["type-"+params.name].value = params.value.val_type_selected;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "type-"+params.name);
				inp.setAttribute("value", params.value.val_type_selected);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}

function editableVolumeHeadIncentive(inp_id)
{
	$(inp_id).editable
	({
		emptytext: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8377;',
		validate: function(value)
		{
			if($.trim(value)=='') return 'This field is required';
		},
		url: function (params)
		{
			// Adding commission value to form............................
			if(typeof document.frmcomm["val-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["val-"+params.name].value=params.value.val;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "val-"+params.name);
				inp.setAttribute("value", params.value.val);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add commission value-type (rupees or percent) to form.......
			if (typeof document.frmcomm["type-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["type-"+params.name].value = params.value.val_type_selected;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "type-"+params.name);
				inp.setAttribute("value", params.value.val_type_selected);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}

function editableVolumeBodyIncentive(inp_id)
{
	$(inp_id).editable
	({
		emptytext: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
		validate: function(value)
		{
			if($.trim(value)=='') return 'This field is required';
		},
		url: function (params)
		{
			// Adding commission value to form............................
			if(typeof document.frmcomm["val-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["val-"+params.name].value=params.value.val;
			}
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "val-"+params.name);
				inp.setAttribute("value", params.value.val);
				document.getElementById("frmcomm").appendChild(inp);
			}

			// Add commission value-type (rupees or percent) to form.......
			if (typeof document.frmcomm["type-"+params.name] != 'undefined')
			{
				// Field available. Update value...
				document.frmcomm["type-"+params.name].value = params.value.val_type_selected;
			} 
			else
			{
				// Field not available. Create new...
				var inp = document.createElement("input");
				inp.setAttribute("type", "hidden");
				inp.setAttribute("name", "type-"+params.name);
				inp.setAttribute("value", params.value.val_type_selected);
				document.getElementById("frmcomm").appendChild(inp);
			}
		}
	});
}


//  Row Add
function addslab()
{
	var slbc = document.frmcomm.slabcnt;
	var slbccurr = document.frmcomm.slabcntcurr;

	if (parseInt(slbccurr.value) < 20)
	{
		slbc.value = parseInt(slbc.value) + 1;		// increment slabcnt value by 1
		slbccurr.value = parseInt(slbccurr.value) + 1;	// increment slabcnt value by 1


		// document.frmcomm.slabcnt.value = parseInt(document.frmcomm.slabcnt.value) + 1;
		// var table1 = document.getElementById('tbody');
		//table1.innerHTML = table1.innerHTML  + "<tr>" + document.getElementById('trbody').innerHTML  + "</tr>";

		var tmprow = document.createElement("tr"); // creating object
		tmprow.innerHTML = document.getElementById('trbody').innerHTML.replace(/-rid[0-9]+/g, "-rid"+slbc.value).replace(/(<a.*?>).*?(<\/a)/ig, "$1$2");
		document.getElementById('tblbody').appendChild(tmprow);

		// For Adding Slab Comm
		editableSlabRange('#slab-rid'+slbc.value);

		// For making the new Base-Comm editable
		editableBaseComm('#base-rid'+ slbc.value);

		// For Adding Source Comm
		for (var s = 0; s < parseInt(document.frmcomm.sourcecolcnt.value); s++)
		{
			editableSourceIncentive('#source-cid'+s+'-rid'+slbc.value);
		}

		// For Adding Target Comm
		for (var t = 0; t < parseInt(document.frmcomm.targetcolcnt.value); t++)
		{
			editableTargetBodyIncentive('#target-cid'+t+'-rid'+slbc.value);
		}

		// For Adding Transaction Volume Comm
		for (var v = 0; v < parseInt(document.frmcomm.volcolcnt.value); v++)
		{
			editableVolumeBodyIncentive('#volume-cid'+v+'-rid'+slbc.value);
		}
	}
}


// Make table scrollable if it is too wide
function resetTableScroll()
{
	if( $('#pnlThreeBdy').innerWidth() - $('#tblComm').outerWidth() <= 50 )
	{
		$('#tblCommHolder').addClass('table-resp');
	}
}

//  SOURCE Column Add
function sourceinc()
{
	var srcnt = document.frmcomm.sourcecolcnt;
	var srcntcurr = document.frmcomm.sourcecolcntcurr;
	if (parseInt(srcnt.value) < 3)
	{
		// Source Head
		var tablehead = document.getElementById("trhead");
		var tmpth = document.createElement("th");
		tmpth.innerHTML = "Source&nbsp;&nbsp;<a href='#' id='sourcehead-col"+srcnt.value+"' data-type='select' data-value='' data-original-title='select' class='editable editable-click'></a>";
		tablehead.appendChild(tmpth);

		$('#sourcehead-col'+srcnt.value).editable
		({
			prepend: "select",
			source: [
				{value:1, text:'EkoDial'},
				{value:2, text:'EDIC'},
				{value:3, text:'USSD'}
				],
			display: function(value, sourceData)
			{
				var colors = {"":"#FA5858", 1:"blue", 2:"green", 3:"cyan"},
				elem = $.grep(sourceData, function(o){return o.value == value;});

				if(elem.length)
				{
					$(this).text(elem[0].text).css("color", colors[value]);
				}
				else
				{
					$(this).empty();
				}
			}
		});

		//Source Body
		var tr_list = document.getElementById('tblbody').getElementsByTagName('tr');
		for(var i=0; i<tr_list.length; i++)
		{
			var tmptd = document.createElement("td");
			tmptd.innerHTML = '<a href="#" id="source-cid'+srcnt.value+'-rid'+(i+1)+'" data-type="slab_value" data-savenochange="true" data-placeholder="Required" data-original-title="Enter Source Value" class="editable editable-click editable-empty"></a>';
			tr_list[i].appendChild(tmptd);

			editableSourceIncentive('#source-cid'+srcnt.value+'-rid'+(i+1));
		}
		// increment source column count
		srcnt.value = parseInt(srcnt.value) + 1;
		srcntcurr.value = parseInt(srcntcurr.value) + 1;
	}

	resetTableScroll();
}

//  TARGET Column Add
function targetinc()
{
	var tgtcnt = document.frmcomm.targetcolcnt;
	var tgtcntcurr = document.frmcomm.targetcolcntcurr;
	if (parseInt(tgtcnt.value) < 5)
	{
		//Target Head
		var trgthead = document.getElementById("trhead");
		var tgtth = document.createElement("th");
		tgtth.innerHTML ="<a href='#' id='targethead-col"+tgtcnt.value+"' data-type='target_percent' data-placeholder='Required' data-original-title='Enter Target' class='editable editable-click editable-empty'></a>&nbsp;Target</th>";
		trgthead.appendChild(tgtth);

		editableTargetHeadIncentive('#targethead-col'+tgtcnt.value)

		//Target Body
		var trs = document.getElementById('tblbody').getElementsByTagName('tr');
		for(var i=0; i<trs.length; i++)
		{
			var tgttd = document.createElement("td");
			tgttd.innerHTML = '<a href="#" id="target-cid'+tgtcnt.value+'-rid'+(i+1)+'" data-type="slab_value" data-savenochange="true" data-placeholder="Required" data-title="Enter Target Value"></a>';
			trs[i].appendChild(tgttd);

			editableTargetBodyIncentive('#target-cid'+tgtcnt.value+'-rid'+(i+1))

		}
		// increment Target column
		tgtcnt.value = parseInt(tgtcnt.value) + 1;
		tgtcntcurr.value = parseInt(tgtcntcurr.value) + 1;
	}

	resetTableScroll();
}

// Transaction Volume Add
function volumeinc()
{
	var volcnt = document.frmcomm.volcolcnt;
	var volcntcurr = document.frmcomm.volcolcntcurr;
	if (parseInt(volcnt.value) < 5)
	{
		//Target Head
		var volhead = document.getElementById("trhead");
		var volth = document.createElement("th");
		volth.innerHTML ="<a href='#' id='volumehead-col"+volcnt.value+"' data-type='address' data-placeholder='Required' data-original-title='Enter Transaction Volume Range' class='editable editable-click editable-empty'></a></th>";
		volhead.appendChild(volth);

		editableVolumeHeadIncentive('#volumehead-col'+volcnt.value)

		//Target Body
		var trs = document.getElementById('tblbody').getElementsByTagName('tr');;
		for(var i=0; i<trs.length; i++)
		{
			var tgttd = document.createElement("td");
			tgttd.innerHTML = '<a href="#" id="volume-cid'+volcnt.value+'-rid'+(i+1)+'" data-type="slab_value" data-savenochange="true" data-placeholder="Required" data-title="Enter Volume Commission"></a>';
			trs[i].appendChild(tgttd);

			editableVolumeBodyIncentive('#volume-cid'+volcnt.value+'-rid'+(i+1))

		}
		// increment Target column
		volcnt.value = parseInt(volcnt.value) + 1;
		volcntcurr.value = parseInt(volcntcurr.value) + 1;
	}

	resetTableScroll();
}


/*
//Onclick move to 2nd Div
function ValPreviewDivOne()
{
	// Update preview
	// preview-span-id.innerHtml = input-name.value
	$('#prvValName').html(document.frmcomm.commName.value);
	$('#prvValBank').html(document.frmcomm.commBank.value);
	$('#prvValpayfreq').html(document.frmcomm.commPayment.value);
	//$('#prvValBc').html(document.frmcomm.bc_detail.value);

	// For Multi Select BC
	var prvBCs = "";
	var bclist = document.frmcomm.bc_detail;
	for (n=0; n<bclist.length; n++)
	{
		if (bclist[n].selected) prvBCs += (prvBCs==''?'':', ') + bclist[n].value;
	}
	document.getElementById("prvValBc").innerHTML=prvBCs;

	//$('#prvValFrom').html(document.frmcomm.commFrom.value);
	// document.getElementById('prvValName').innerHTML = document.frmcomm.commName.value;

	// Set dates
	var datefields;
	var month_names = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
	datefields=document.frmcomm.commFrom.value.split(/[^0-9]+/);
	document.getElementById("prvFromDt").innerHTML = datefields[0];
	document.getElementById("prvFromMh").innerHTML = month_names[parseInt(datefields[1], 10)];
	document.getElementById("prvFromYr").innerHTML = datefields[2];

	datefields=document.frmcomm.commTo.value.split(/[^0-9]+/);
	document.getElementById("prvToDt").innerHTML = datefields[0];
	document.getElementById("prvToMh").innerHTML = month_names[parseInt(datefields[1], 10)];
	document.getElementById("prvToYr").innerHTML = datefields[2];

	$('#prvCommDescFirst').css('display','block');
	$('#collapseTwo').css('overflow','hidden');
	$('#divDescription').css('display','none'); // To hide the Division 1 label
}
*/

// Start Old Commission Section Edit (Hide the preview)
function hidePreview(div_id, title_id)
{
	$(div_id).css('display','none');
	$(title_id).css('display','inline-block');
}

// On popover
$('#commName').popover();


//Remove Slab
function deleteRow(close_button)
{
	// decrease slab-row count by 1
	document.frmcomm.slabcntcurr.value = document.frmcomm.slabcntcurr.value - 1;

	$(close_button.parentNode.parentNode).fadeOut(250,function()
	{
	    $(this).remove();
	});
}

//Custom Target Validation
function tgtValidate()
{
	var is_error = false;
	val = document.getElementById("uplfield").value;
	if (val.length == 0 || val.length == "")
	{
		is_error = true;
		document.getElementById("valuplfield").innerHTML = "*This field is required";
		document.getElementById("valuplfield").style.display="inline-block";
	}
	else if (val.substring(val.length-3,val.length).toLowerCase()!="csv")
	{
		is_error = true;
		document.getElementById("valuplfield").innerHTML = "Only .csv file allowed";
		document.getElementById("valuplfield").style.display="inline-block";
	}

	if (is_error)
	{
		return false;
	}
	else
	{
		return true;
	}
}

//Custom Create Page Validation
function valPreviewDivOne()
{
	var is_error = false;
	valname = document.frmcomm.commName.value;
	if (valname.length == 0 || valname.length == "")
	{
		is_error = true;
		document.getElementById("valCommName").innerHTML = "This field is required";
	}
	else
	{
		document.getElementById("valCommName").innerHTML = "";
	}

	valfrom = document.frmcomm.commFrom.value;
	if (valfrom.length == 0 || valfrom.length == "")
	{
		is_error = true;
		document.getElementById("valcommFrom").innerHTML = "This field is required";
	}
	else
	{
		document.getElementById("valcommFrom").innerHTML = "";
	}

	valTo = document.frmcomm.commTo.value;
	if (valTo.length == 0 || valTo.length == "")
	{
		is_error = true;
		document.getElementById("valcommTo").innerHTML = "This field is required";
	}
	else
	{
		document.getElementById("valcommTo").innerHTML = "";
	}


	if (!is_error)
	{
		// Display next div
		$('#prvValName').html(document.frmcomm.commName.value);
		$('#prvValBank').html(document.frmcomm.commBank.value);
		$('#prvValpayfreq').html(document.frmcomm.commPayment.value);

		// For Multi Select BC
		var prvBCs = "";
		var bclist = document.frmcomm.bc_detail;
		for (n=0; n<bclist.length; n++)
		{
			if (bclist[n].selected) prvBCs += (prvBCs==''?'':', ') + bclist[n].value;
		}
		document.getElementById("prvValBc").innerHTML=prvBCs;

		// Set dates
		var datepckrfield;
		var month_names = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
		var datepckrfield=document.frmcomm.commFrom.value.split(/[^0-9]+/);
		document.getElementById("prvFromDt").innerHTML = datepckrfield[0];
		document.getElementById("prvFromMh").innerHTML = month_names[parseInt(datepckrfield[1], 10)];
		document.getElementById("prvFromYr").innerHTML = datepckrfield[2];

		datepckrfield=document.frmcomm.commTo.value.split(/[^0-9]+/);
		document.getElementById("prvToDt").innerHTML = datepckrfield[0];
		document.getElementById("prvToMh").innerHTML = month_names[parseInt(datepckrfield[1], 10)];
		document.getElementById("prvToYr").innerHTML = datepckrfield[2];

		$('#prvCommDescFirst').css('display','block');
		$('#collapseTwo').css('overflow','hidden');
		$('#divDescription').css('display','none'); // To hide the Division 1 label

		// show Div Two
		$("#collapseOne").collapse('hide');
		$("#collapseTwo").collapse('show');
		//$("#collapseThree").collapse('hide');
		//$("#collapseFour").collapse('hide');

	}
}

function ValPreviewDivTwo()
{
	$('#prvValAgent').html(document.frmcomm.commAgent.value);
	$('#prvValTrxnType').html(document.frmcomm.commTxType.value);
	//$('#prvValRegion').html(document.frmcomm.commRegion.value);

	// For Multi Select Region
	var prvReg = "";
	var reglist = document.frmcomm.commRegion;
	for (a=0; a<reglist.length; a++)
	{
		if (reglist[a].selected) prvReg += (prvReg==''?'':', ') + reglist[a].value;
	}
	document.getElementById("prvValRegion").innerHTML=prvReg;

	// For Multi Select Agent
	var prvAgnt = "";
	var agentlist = document.frmcomm.commAgent;
	for (a=0; a<agentlist.length; a++)
	{
		if (agentlist[a].selected) prvAgnt += (prvAgnt==''?'':', ') + agentlist[a].value;
	}
	document.getElementById("prvValAgent").innerHTML=prvAgnt;

	$('#prvCommDescSecond').css('display','block');
	$('#collapseThree').css('overflow','hidden');
	$('#parameters').css('display','none');


	//$("#collapseOne").collapse('hide');
	$("#collapseTwo").collapse('hide');
	$("#collapseThree").collapse('show');


}

function ValPreviewDivThree()
{
	$('#prvCommDescThird').css('display','block');
	$('#collapseFour').css('overflow','hidden');
	$('#rule').css('display','none');

	$("#collapseThree").collapse('hide');
	$("#collapseFour").collapse('show');

}

// Only numeric value is allowed

