# stateful.lsl 
stateful.lsl is a preprocessor macro library for lsl scripts that enables defining structured messages that self update internal fields/variables of lsl scripts. 

Structured messages can be easily defined as being passed between linked prims or region prims.

## Functions
| Functions | Description |
|-|-|
|`DBG_VAR(NAME)`| Simple printing of a variable when debugging your script |
|`DEF_STATEFUL(TYPE, NAME) ... END_DEF`| Begin defining a stateful event and variable where `TYPE` is an LSL Data Type and `NAME` is the name of the variable. Replace `...` with your event code. |
|-|-|
|`DEF_STATEFUL_MSG(MSG_CLASS)`| Begin defining a stateful message where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message |
|`STATEFUL_MSG_PARAM(NAME)`| Bind a stateful variable to the stateful message. This can be repeated as many times as needed to include multiple variables separated by a comma. |
|`END_STATEFUL_MSG_TO_REGION`| Finish defining a stateful message that is destined for listening prims in the region |
|`END_STATEFUL_MSG_TO_LINK(LINK_SCOPE)`| Finish defining a stateful message that is destined for linked prims |
|-|-|
|`EMIT_MSG(MSG_CLASS)`| Emit a message that contains the current variable states |
|-|-|
|`BEGIN_DEF_PARSE_MSG(MSG_CLASS)`| Begin defining a stateful message parser where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message being parsed. May also include script specific code within the message parser |
|`MSG_STATEFUL_PARAM_TO(TYPE, NAME, OFFSET)`| Bind a message parameter to a stateful variable where `TYPE` is an LSL Data Type, `NAME` is the name of the variable and `OFFSET` is the index in the message parameter list |
|`MSG_LOCAL_PARAM_TO(TYPE, NAME, OFFSET)`| Bind a message parameter to a local function variable where `TYPE` is an LSL Data Type, `NAME` is the name of the variable and `OFFSET` is the index in the message parameter list |
|-|-|
|`END_DEF`| Finishes a Definition of a Stateful or Stateful Message Parser |
|-|-|
|`PARSE_MSG(MSG_CLASS, MSG)`| Manually call a parse of a message where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message being parsed and  |
|-|-|
|`DEF_LISTEN`| |
|`LISTEN_CASE(MSG_CLASS)`| |
|`ELSE_LISTEN_CASE(MSG_CLASS)`| |
|`END_LISTEN`| |
