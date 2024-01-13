#define DBG_VAR(NAME) llOwnerSay((string)NAME);

#define DEF_STATEFUL(TYPE, NAME) TYPE s_##NAME; Set_##NAME(TYPE v){s_##NAME=v; Event_##NAME();} Event_##NAME() {  

#define DEF_STATEFUL_MSG(MSG_CLASS) Emit_S_##MSG_CLASS() { integer c = MSG_CLASS; list msg = [
#define STATEFUL_MSG_PARAM(NAME) s_##NAME
#define END_STATEFUL_MSG_TO_REGION ]; llRegionSay(CHANNEL,llDumpList2String([c]+msg,"|")); }
#define END_STATEFUL_MSG_TO_LINK(LINK_SCOPE) ]; llMessageLinked(LINK_SCOPE,c,llDumpList2String(msg,"|")); }

#define EMIT_MSG(MSG_CLASS) Emit_S_##MSG_CLASS();\

#define BEGIN_DEF_PARSE_MSG(MSG_CLASS)\
Parse_##MSG_CLASS(list msg) {

#define MSG_STATEFUL_PARAM_TO(TYPE, NAME, OFFSET)\
Set_##NAME(TYPE(msg[OFFSET]));\

#define MSG_LOCAL_PARAM_TO(TYPE, NAME, OFFSET)\
TYPE NAME = TYPE(msg[OFFSET]);\

#define MSG_PARAM(TYPE, OFFSET)\
TYPE(msg[OFFSET]);\

#define END_DEF }

#define PARSE_MSG(MSG_CLASS, msg) Parse_##MSG_CLASS(msg);

#define DEF_LISTEN \
listen( integer c, string n, key id, string m ){\
list msg = llParseStringKeepNulls(m,["|"],[]);\

#define LISTEN_CASE(MSG_CLASS) if(MSG_CLASS == ((integer)msg[0])) { Parse_##MSG_CLASS(llDeleteSubList(msg,0,0)); }
#define ELSE_LISTEN_CASE(MSG_CLASS) else if(MSG_CLASS == ((integer)msg[0])) { Parse_##MSG_CLASS(llDeleteSubList(msg,0,0)); }
#define END_LISTEN else {llOwnerSay("Unknown msg ID: " + (string)msg[0]);}}
