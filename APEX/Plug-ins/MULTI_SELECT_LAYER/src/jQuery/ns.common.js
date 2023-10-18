// Enums
const apex_messages_type = {
    ERROR: 'error'
};

const apex_messages_location = {
    PAGE: 'page'
};

const enum_strings = {
    ARRAY_SEPARATOR: '@',
    BLANK_SPACE: ' ',
    COMMA: ',',
    DASH: '-',
    DATE_SEPARATOR: '/',
    DOT: '.',
    DOUBLE_SEPARATOR: '||',
    EMPTY: '',
    SEMICOLON: ';'
};

const enum_trace = {
    ON: 'ON',
    OFF: 'OFF'
};

//
function mostrarErrorGenerico(message) {
    apex.message.showErrors([
        {
            type: apex_messages_type.ERROR,
            location: apex_messages_location.PAGE,
            message: message,
            unsafe: false,
        },
    ]);
}

function mostrarExitoGenerico(message) {
    apex.message.showPageSuccess(message);
}