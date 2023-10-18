var multiSelectWindow = {
    // Variable para almacenar 'name' de forma accesible a otras funciones
    name: null,

    _initialize: function (initName, initValues) {
        "use strict";

        try {
            //
            var lSpinner$ = apex.util.showSpinner('#data-multiselect-info');
            // Asignar 'initName' a la variable 'name'
            this.name = initName;

            // Split comma-separated values into an array
            let itemsValues = initValues.split(enum_strings.ARRAY_SEPARATOR);

            // Check if 'values' is not null and is a non-empty string
            if (initValues && typeof initValues === 'string') {
                // Split 'values' by ARRAY_SEPARATOR and remove whitespace around each element
                let itemsValues = initValues.split(enum_strings.ARRAY_SEPARATOR).map(function (value) {
                    return value.trim();
                });
                // Check if 'itemsValues' contains at least one element
                if (itemsValues.length > 0) {
                    // Iterate through the elements and perform the necessary operations
                    itemsValues.forEach(function (value) {
                        // Find the corresponding checkbox by value and check it
                        $('#data-multiselect-info input[type="checkbox"][value="' + value + '"]').prop('checked', true);
                    });
                } else {
                    mostrarErrorGenerico("MultiSelectWindow: The 'values' variable does not contain elements after splitting by commas.");
                }
            }
            //
            lSpinner$.remove();
        } catch (error) {
            mostrarErrorGenerico("MultiSelectWindow error: " + error.message);
        }

        // Add an event handler to the button
        $("#b-data-multiselect-info").on("click", function () {
            $("#data-multiselect-info").slideToggle();
            changeButtonIcon();
        });

        // Add an event handler for checkbox state changes
        $('#data-multiselect-info input[type="checkbox"]').on('change', function () {
            // Filter checked checkboxes and get their values
            var selectedValues = $('#data-multiselect-info input[type="checkbox"]:checked').map(function () {
                return $(this).val();
            }).get();

            // Store the selected values somewhere with the provided 'name'
            $s(initName, selectedValues.join(enum_strings.ARRAY_SEPARATOR));
        });

        // Change the button icon on click
        function changeButtonIcon() {
            let $button = $("#b-data-multiselect-info .t-Icon");
            $button.toggleClass("fa-angle-down fa-angle-up");
        }
    },

    value: function () {
        return $v(this.name);
    },

    valueAsArray: function () {
        try {
            return $v(this.name).split(enum_strings.ARRAY_SEPARATOR);
        } catch (error) {
            mostrarErrorGenerico("MultiSelectWindow error: " + error.message);
        }
    }
};