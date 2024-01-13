# stateful.lsl 
stateful.lsl is a small preprocessor macro library for lsl scripts that enables defining structured messages that self update internal fields/variables of lsl scripts. 

Structured messages can be easily defined as being passed between linked prims or region prims.

# Functions

## Defining a Stateful
| Declaration | Description |
|-|-|
|`DBG_VAR(NAME)`| Simple printing of a variable when debugging your script |
|`DEF_STATEFUL(TYPE, NAME) ... `| Begin defining a stateful event and variable where `TYPE` is an LSL Data Type and `NAME` is the name of the variable. Replace `...` with your event code. |
|`END_DEF`| Finishes a Definition of a Stateful Event |

## Defining and emiting a Stateful Message
| Declaration | Description |
|-|-|
|`DEF_STATEFUL_MSG(MSG_CLASS) ...`| Begin defining a stateful message where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message. Replace `...` with 0 or more `STATEFUL_MSG_PARAMS`. |
|`STATEFUL_MSG_PARAM(NAME)`| Bind a stateful variable to the stateful message. This can be repeated as many times as needed to include multiple variables separated by a comma. |
|`END_STATEFUL_MSG_TO_REGION`| Finish defining a stateful message that is destined for listening prims in the region |
|`END_STATEFUL_MSG_TO_LINK(LINK_SCOPE)`| Finish defining a stateful message that is destined for linked prims |
|`EMIT_MSG(MSG_CLASS)`| Emit a message that contains the current variable states |

## Parsing a Stateful Message
| Declaration | Description |
|-|-|
|`BEGIN_DEF_PARSE_MSG(MSG_CLASS) ...`| Begin defining a stateful message parser where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message being parsed. Replace `...` with 0 or more `MSG_STATEFUL_PARAM_TO` and `MSG_LOCAL_PARAM_TO`. May also include script specific code within the message parser |
|`MSG_STATEFUL_PARAM_TO(TYPE, NAME, OFFSET)`| Bind a message parameter to a stateful variable where `TYPE` is an LSL Data Type, `NAME` is the name of the variable and `OFFSET` is the index in the message parameter list |
|`MSG_LOCAL_PARAM_TO(TYPE, NAME, OFFSET)`| Bind a message parameter to a local function variable where `TYPE` is an LSL Data Type, `NAME` is the name of the variable and `OFFSET` is the index in the message parameter list |
|`END_DEF`| Finishes a Definition of a Stateful Message Parser |

| Declaration | Description |
|-|-|
|`PARSE_MSG(MSG_CLASS, MSG)`| Manually call a parse of a message where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message being parsed and  |

| Declaration | Description |
|-|-|
|`DEF_LISTEN`| Begin defining the lsl listen event for stateful messages. The listen parameter name culture is defined as `listen( integer c, string n, key id, string m )`. Any custom code must come imediately after this declaration. |
|`LISTEN_CASE(MSG_CLASS)`| Inject a listen case for a specific message where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message |
|`ELSE_LISTEN_CASE(MSG_CLASS)`| Same as above but for additional cases |
|`END_LISTEN`| Finish defining the lsl listen event. This declaration also includes a debug message in the event that a message type was not known. |
