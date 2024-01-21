#define DBG_VAR(NAME) llOwnerSay((string)NAME);

#define DEF_STATEFUL(TYPE, NAME) TYPE s_##NAME; Set_##NAME(TYPE v){s_##NAME=v; Event_##NAME();} Event_##NAME() {  
#define DEF_STATEFUL_LSD(TYPE, NAME) TYPE Get_##NAME(){return (TYPE)llLinksetDataRead("s_"+#NAME);} Set_##NAME(TYPE v){llLinksetDataWrite("s_"+#NAME,(string)v); Event_##NAME();} Event_##NAME() { 
#define DEF_STATEFUL_LSD_LIST(NAME) list Get_##NAME(){return llParseStringKeepNulls(llLinksetDataRead("s_"+#NAME),["|"],[]);} Set_##NAME(list v){llLinksetDataWrite("s_"+#NAME,llDumpList2String(v,"|")); Event_##NAME();} Event_##NAME() { 

#define DEF_STATEFUL_LSD_PROTECTED(TYPE, NAME, PASSWORD) TYPE Get_##NAME(){return (TYPE)llLinksetDataReadProtected("s_"+#NAME,PASSWORD);} Set_##NAME(TYPE v){llLinksetDataWriteProtected("s_"+#NAME,(string)v,PASSWORD); Event_##NAME();} Event_##NAME() { 
#define DEF_STATEFUL_LSD_PROTECTED_LIST(NAME, PASSWORD) list Get_##NAME(){return llParseStringKeepNulls(llLinksetDataReadProtected("s_"+#NAME),["|"],[]);} Set_##NAME(list v){llLinksetDataWriteProtected("s_"+#NAME,llDumpList2String(v,"|")); Event_##NAME();} Event_##NAME() { 

#define DEF_STATEFUL_MSG(MSG_CLASS) Emit_S_##MSG_CLASS() { list msg = [MSG_CLASS
#define DEF_STATEFUL_MSG_ARGS(MSG_CLASS,...) Emit_S_##MSG_CLASS(__VA_ARGS__) { list msg = [MSG_CLASS

#define STATEFUL_MSG_ARG(NAME) ,NAME
#define STATEFUL_MSG_PARAM(NAME) ,s_##NAME
#define STATEFUL_MSG_PARAM_LIST(NAME) ,llDumpList2String(s_##NAME,",")
#define STATEFUL_MSG_PARAM_LSD(NAME) ,Get_##NAME()
#define STATEFUL_MSG_PARAM_LSD_LIST(NAME) ,llDumpList2String(Get_##NAME(),",")

#define END_STATEFUL_MSG_TO_REGION(CHANNEL) ]; llRegionSay(CHANNEL,llDumpList2String(msg,"|")); END_DEF
#define END_STATEFUL_MSG_TO_LINK(LINK_SCOPE) ]; llMessageLinked(LINK_SCOPE,c,llDumpList2String(msg,"|")); END_DEF

#define EMIT_MSG(MSG_CLASS) Emit_S_##MSG_CLASS();\

#define EMIT_MSG_ARGS(MSG_CLASS,...) Emit_S_##MSG_CLASS(__VA_ARGS__);\

#define BEGIN_DEF_PARSE_MSG(MSG_CLASS)\
Parse_##MSG_CLASS(list msg) {

#define MSG_STATEFUL_PARAM_TO(TYPE, NAME, OFFSET)\
Set_##NAME(TYPE(msg[OFFSET]));\

#define MSG_STATEFUL_PARAM_LIST(NAME, OFFSET)\
Set_##NAME(llParseStringKeepNulls((string)(msg[OFFSET]),[","],[]));\

#define MSG_LOCAL_PARAM_TO(TYPE, NAME, OFFSET)\
TYPE NAME = TYPE(msg[OFFSET]);\

#define END_DEF }

#define PARSE_MSG(MSG_CLASS, MSG) Parse_##MSG_CLASS(MSG);

#define DEF_LISTEN \
listen( integer c, string n, key id, string m ){\
list msg = llParseStringKeepNulls(m,["|"],[]);\

#define LISTEN_CASE(MSG_CLASS) if(MSG_CLASS == ((integer)msg[0])) { Parse_##MSG_CLASS(llDeleteSubList(msg,0,0)); }
#define ELSE_LISTEN_CASE(MSG_CLASS) else if(MSG_CLASS == ((integer)msg[0])) { Parse_##MSG_CLASS(llDeleteSubList(msg,0,0)); }
#define END_LISTEN else {llOwnerSay("Unknown msg ID: " + (string)msg[0]);}}
