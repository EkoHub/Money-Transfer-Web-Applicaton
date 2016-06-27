/**
Target-percent editable input.
Internally value stored as {val: "20" (i.e. 20%)}

@class target_percent
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

    var Target_Percent = function (options) {
        this.init('target_percent', options, Target_Percent.defaults);
    };

    //inherit from Abstract input
    $.fn.editableutils.inherit(Target_Percent, $.fn.editabletypes.abstractinput);

    $.extend(Target_Percent.prototype, {
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


//alert (value+"  -  "+value.val);

            value.val = $.trim(value.val);
            var html =
		(value.val=="0" || value.val=="") ?
			"set"
			:
			$('<div>').text(value.val).html() + " %";
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
		if (!value) { return; }
		this.$input.filter('[name="val"]').val(value.val);
	},

       /**
        Returns value of input.

        @method input2value()
       **/
       input2value: function() {
           return {
              val: this.$input.filter('[name="val"]').val()
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

    Target_Percent.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
        tpl:'<div class="settargetpercent"><input type="text" name="val" class="form-control input-small" style="width:auto">&nbsp;&nbsp;<strong>%</strong>&nbsp;&nbsp;&nbsp;',

        inputclass:''
    });

    $.fn.editabletypes.target_percent = Target_Percent;

}(window.jQuery));
