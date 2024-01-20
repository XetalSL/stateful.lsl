# stateful.lsl 
stateful.lsl is a small preprocessor macro library for lsl scripts that enables generating structured messages that self update internal fields/variables of lsl scripts. 

Structured messages can be easily defined as being passed between linked prims or region prims.

# Functions

## Defining a Stateful
| Declaration | Description |
|-|-|
|`DBG_VAR(NAME)`| Simple printing of a variable when debugging your script |
|`DEF_STATEFUL(TYPE, NAME) ... `| Begin defining a stateful event and variable where `TYPE` is an LSL Data Type and `NAME` is the name of the variable. Replace `...` with your event code. |
|`DEF_STATEFUL_LSD(TYPE, NAME) ... `| Begin defining a stateful event and variable in the LinkSetData Key Value Storage where `TYPE` is an LSL Data Type and `NAME` is the name of the variable. Replace `...` with your event code. |
|`DEF_STATEFUL_LSD_PROTECTED(TYPE, NAME, PASSWORD) ... `| Begin defining a stateful event and variable in the LinkSetData Key Value Storage where `TYPE` is an LSL Data Type and `NAME` is the name of the variable. Replace `...` with your event code. |
|`END_DEF`| Finishes a Definition of a Stateful Event |

## Defining and emiting a Stateful Message
| Declaration | Description |
|-|-|
|`DEF_STATEFUL_MSG(MSG_CLASS) ...`| Begin defining a stateful message where `MSG_CLASS` is a PREPROCESSOR DEFINED integer to uniquely identify the stateful message. Replace `...` with 0 or more `STATEFUL_MSG_PARAMS`. |
|`STATEFUL_MSG_PARAM(NAME)`| Bind a stateful variable to the stateful message. This can be repeated as many times as needed to include multiple variables separated by a comma. |
|`STATEFUL_MSG_PARAM_LSD(NAME)`| Bind a stateful variable stored in the LinkSetData Key Value Storage to the stateful message. This can be repeated as many times as needed to include multiple variables separated by a comma. |
|`END_STATEFUL_MSG_TO_REGION(CHANNEL)`| Finish defining a stateful message that is destined for listening prims in the region |
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

# Example Usage
This example script provides a brief usecase overview. Copy and paste this into a new script in a prim and build. Once it is done, look at the preprocessor and youll see it has generated a load of working content that albeit a little messy, compiles.
```lsl
#include "stateful.lsl"

string password = "example_password_you_shouldnt_use";

integer chnl = 1020;

// Define a stateful integer field/variable and event that monitors the integer
DEF_STATEFUL(integer, count)
    llOwnerSay("Count Changed");
END_DEF

// Define a stateful integer and float. These are effectively decorated fields/variables
DEF_STATEFUL(integer, value)END_DEF
DEF_STATEFUL(float, name)END_DEF

// Define a stateful event that monitors a LinkSetData stored vector.
DEF_STATEFUL_LSD(vector, colour) 
    llOwnerSay("Colour Changed"); 
END_DEF

// Define a stateful event that monitors a Protected LinkSetData stored string.
DEF_STATEFUL_LSD_PROTECTED(string, text, password) 
    llOwnerSay("Text Changed to " + Get_text()); 
END_DEF

// Defines the stateful message of class "MSG_POLL" that has no parameters.
#define MSG_POLL 1
DEF_STATEFUL_MSG(MSG_POLL)
END_STATEFUL_MSG_TO_REGION(chnl)

// Parse the stateful message of class "MSG_POLL"
BEGIN_DEF_PARSE_MSG(MSG_POLL)
    llOwnerSay("Got the Poll message");
END_DEF

#define MSG_STATE 2
DEF_STATEFUL_MSG(MSG_STATE)
    STATEFUL_MSG_PARAM(count)
    STATEFUL_MSG_PARAM(value)
    STATEFUL_MSG_PARAM(name)
END_STATEFUL_MSG_TO_REGION(chnl)

/*
Parse the stateful message of class "MSG_STATE" that has three parameters.
Each parameter updates the stateful field/variable defined. The number at the end indicates the index of the paramter in the raw message.
*/
BEGIN_DEF_PARSE_MSG(MSG_STATE)
    MSG_STATEFUL_PARAM_TO(integer,count,0)
    MSG_STATEFUL_PARAM_TO(integer,value,1)
    MSG_STATEFUL_PARAM_TO(float,name,2)
END_DEF

#define MSG_COLOUR 3
DEF_STATEFUL_MSG(MSG_COLOUR)
    STATEFUL_MSG_PARAM_LSD(colour)
    STATEFUL_MSG_PARAM_LSD(text)
END_STATEFUL_MSG_TO_REGION(chnl)

BEGIN_DEF_PARSE_MSG(MSG_COLOUR)
    MSG_STATEFUL_PARAM_TO(vector,colour,0)
    MSG_STATEFUL_PARAM_TO(string,text,1)
END_DEF

default
{
    state_entry()
    {
        //Init stateful fields/variables
        Set_count(8);
        Set_value(8);
        Set_name(8);
        Set_colour(<1,2,3>);
        Set_text("some text");

        //Emit the state message.
        EMIT_MSG(MSG_STATE)
    }

    /*
    Define the standard lsl listen event function.
    This entirely replaces manual entry of the listen() function.
    If custom code is needed within the listen() function, place it after "DEF_LISTEN".
    "DEF_LISTEN" generates the listen event header as "listen( integer c, string n, key id, string m )"
    */
    DEF_LISTEN
    LISTEN_CASE(MSG_STATE)
    ELSE_LISTEN_CASE(MSG_COLOUR)
    END_LISTEN
}
```
