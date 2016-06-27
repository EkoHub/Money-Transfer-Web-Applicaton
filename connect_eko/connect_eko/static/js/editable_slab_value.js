/**
Slab-value editable input.
Internally value stored as {val: "Moscow", val_type: "Lenina", building: "15"}

@class address
@extends abstractinput
@final
@example
<a href="#" id="address" data-type="address" data-pk="1">awesome</a>
<script>
$(function(){
    $('#address').editable({
        url: '/post',
        title: 'Enter val, val_type and building #',
        value: {
            val: "Moscow",
            val_type: "Lenina",
            building: "15"
        }
    });
});
</script>
**/
(function ($) {
    "use strict";

    var Slab_Value = function (options) {
        this.init('slab_value', options, Slab_Value.defaults);
    };

    //inherit from Abstract input
    $.fn.editableutils.inherit(Slab_Value, $.fn.editabletypes.abstractinput);

    $.extend(Slab_Value.prototype, {
        /**
        Renders input from tpl

        @method render()
        **/
        render: function() {
           this.$input = this.$tpl.find('input');
        },

        /**
        Default method to show value in element. Can be overwritten by display option.

        @method value2html(value, element)
        **/
        value2html: function(value, element)
        {
            if(!value)
            {
                $(element).empty();
                return;
            }

/*
		var btns = value.val_type;
/*
		for (var i = 0; i < radio_group.length; i++)
		{
			var button = radio_group[i];
			if (button.checked) {
			return button;
			}
		}
		return undefined;
		}
		var checkedButton = getCheckedRadio();
		if (checkedButton) {
		alert("The value is " + checkedButton.value);


*/

            value.val = $.trim(value.val);
            value.val_type = $.trim(value.val_type);

            var html = "set value";
            if ( !((value.val=="0" || value.val=="") && (value.val_type=="0" || value.val_type=="")) )
            {
            	if (($('.setslabinput input[name=val_type]').get(0).checked))
				{
					html = $('<div>').text(value.val).html() + ' %';
				}
				else if (($('.setslabinput input[name=val_type]').get(1).checked))
				{
					html = '&#8377; '+$('<div>').text(value.val).html();
				}
            }
            $(element).html(html);
        },

        /**
        Gets value from element's html

        @method html2value(html)
        **/
        html2value: function(html) {
          /*
            you may write parsing method to get value by element's html
            e.g. "Moscow, st. Lenina, bld. 15" => {val: "Moscow", val_type: "Lenina", building: "15"}
            but for complex structures it's not recommended.
            Better set value directly via javascript, e.g.
            editable({
                value: {
                    val: "Moscow",
                    val_type: "Lenina",
                    building: "15"
                }
            });
          */
          return null;
        },

       /**
        Converts value to string.
        It is used in internal comparing (not for sending to server).

        @method value2str(value)
       **/
       value2str: function(value) {
           var str = '';
           if(value) {
               for(var k in value) {
                   str = str + k + ':' + value[k] + ';';
               }
           }
           return str;
       },

       /*
        Converts string to value. Used for reading value from 'data-value' attribute.

        @method str2value(str)
       */
       str2value: function(str) {
           /*
           this is mainly for parsing value defined in data-value attribute.
           If you will always set value by javascript, no need to overwrite it
           */
           return str;
       },

       /**
        Sets value of input.

        @method value2input(value)
        @param {mixed} value
       **/
       value2input: function(value) {
           if(!value) {
             return;
           }
           this.$input.filter('[name="val"]').val(value.val);
           this.$input.filter('[name="val_type"]').val(value.val_type);
           this.$input.filter('[name="val_type_selected"]').val(value.val_type_selected);
       },

       /**
        Returns value of input.

        @method input2value()
       **/
       input2value: function() {
           return {
              val: this.$input.filter('[name="val"]').val(),
              val_type: this.$input.filter('[name="val_type"]').val()
           };
       },

        /**
        Activates input: sets focus on the first field.

        @method activate()
       **/
       activate: function() {
            this.$input.filter('[name="val"]').focus();
       },

       /**
        Attaches handler to submit form in case of 'showbuttons=false' mode

        @method autosubmit()
       **/
       autosubmit: function() {
           this.$input.keydown(function (e) {
                if (e.which === 13) {
                    $(this).closest('form').submit();
                }
           });
       }
    });

    Slab_Value.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
        //tpl: '<div class="editable-address"><input type="text" name="val" class="input-small"> &ndash; <input type="text" name="val_type" class="input-small"></div>',
        //tpl: '<div class="form-group col-lg-6"><div class="col-lg-5"><input type="text" name="val" class="form-control input-small"></div><div class="col-lg-2 cntr">-</div><div class = "col-lg-5"><input type="text" name="val_type" class="form-control input-small"></div></div>',

        tpl:'<div class="setslabinput"><input type="text" name="val" class="form-control input-small" style="width:auto">&nbsp;&nbsp;<label class="radio-inline"><input type="radio" name="val_type" value="percent" checked="checked"> %</label><label class="radio-inline"><input type="radio" name="val_type" value="rupee"> &#8377;</label>&nbsp;',

        inputclass:''
    });

    $.fn.editabletypes.slab_value = Slab_Value;

}(window.jQuery));
