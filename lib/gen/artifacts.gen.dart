// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:agentic/chat/content/content_audio.dart";import "package:agentic/chat/content/content_group.dart";import "package:agentic/chat/content/content.dart";import "package:agentic/chat/content/content_image.dart";import "package:agentic/chat/content/text_content.dart";import "package:agentic/chat/message/message.dart";import "package:agentic/chat/message/message_user.dart";import "package:agentic/chat/message/message_system.dart";import "package:agentic/chat/message/message_agent.dart";import "package:agentic/chat/message/message_tool.dart";import "package:agentic/chat/connector/model.dart";import "package:agentic/chat/connector/chat_request.dart";import "package:agentic/chat/connector/result.dart";import "package:agentic/chat/tool/tool_call.dart";import "package:agentic/chat/tool/tool_schema.dart";import "package:agentic/util/chat_models.dart";import "package:artifact/artifact.dart";import "dart:core";import "package:agentic/chat/tool/tool.dart";import "package:rational/rational.dart";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=AudioContent;typedef _7=ContentGroup;typedef _8=Content;typedef _9=ImageContent;typedef _a=TextContent;typedef _b=Message;typedef _c=UserMessage;typedef _d=SystemMessage;typedef _e=AgentMessage;typedef _f=ToolMessage;typedef _g=ChatModel;typedef _h=ChatRequest;typedef _i=ChatResult;typedef _j=ChatUsage;typedef _k=ToolCall;typedef _l=ToolSchema;typedef _m=ChatModelCapabilities;typedef _n=ChatModelCost;typedef _o=bool;typedef _p=List;typedef _q=List<Content>;typedef _r=ArgumentError;typedef _s=List<ToolCall>;typedef _t=Tool;typedef _u=List<Message>;typedef _v=List<Tool>;typedef _w=MapEntry;typedef _x=MapEntry<String, dynamic>;typedef _y=Rational;typedef _z=ChatFinishReason;typedef _10=ChatModelSystemMode;typedef _11=List<Modality>;typedef _12=double;typedef _13=List<dynamic>;
const _2 _S=['_subclass_Content','audioUrl','base64Audio','contents','AudioContent','ContentGroup','ImageContent','TextContent','imageUrl','base64Image','text','content','_subclass_Message','UserMessage','SystemMessage','AgentMessage','ToolMessage','Missing required Message."content" in map ','Missing required UserMessage."content" in map ','Missing required SystemMessage."content" in map ','toolCalls','Missing required AgentMessage."content" in map ','toolCallId','Missing required ToolMessage."content" in map ','Missing required ToolMessage."toolCallId" in map ','displayName','cost','capabilities','Missing required ChatModel."id" in map ','Missing required ChatModel."cost" in map ','Missing required ChatModel."capabilities" in map ','messages','tools','model','systemPrompt','user','responseFormat','Missing required ChatRequest."messages" in map ','Missing required ChatRequest."model" in map ','message','realCost','finishReason','metadata','usage','Missing required ChatResult."message" in map ','Missing required ChatResult."realCost" in map ','inputTokens','outputTokens','name','arguments','Missing required ToolCall."id" in map ','Missing required ToolCall."name" in map ','Missing required ToolCall."arguments" in map ','description','schema','Missing required ToolSchema."name" in map ','Missing required ToolSchema."description" in map ','Missing required ToolSchema."schema" in map ','ultraCompatibleMode','systemMode','contextWindow','maxTokenOutput','inputModalities','outputModalities','reasoning','structuredOutput','streaming','seesToolMessages','Missing required ChatModelCapabilities."tools" in map ','Missing required ChatModelCapabilities."ultraCompatibleMode" in map ','Missing required ChatModelCapabilities."systemMode" in map ','Missing required ChatModelCapabilities."contextWindow" in map ','Missing required ChatModelCapabilities."maxTokenOutput" in map ','Missing required ChatModelCapabilities."inputModalities" in map ','Missing required ChatModelCapabilities."outputModalities" in map ','Missing required ChatModelCapabilities."reasoning" in map ','Missing required ChatModelCapabilities."structuredOutput" in map ','Missing required ChatModelCapabilities."streaming" in map ','Missing required ChatModelCapabilities."seesToolMessages" in map ','input','output','Missing required ChatModelCost."input" in map ','Missing required ChatModelCost."output" in map '];const _13 _V=[<_8>[],<_k>[],<_t>[],ChatFinishReason.unspecified,<_3,_4>{},ChatUsage()];const _o _T=true;const _o _F=false;const _5 _ = 0;
extension $AudioContent on _6{
  _6 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'AudioContent',_S[1]:_0.ea(audioUrl),_S[2]:_0.ea(base64Audio),}.$nn;}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromMap(_1 r){_;_1 m=r.$nn;return _6(audioUrl: m.$c(_S[1]) ?  _0.da(m[_S[1]], _3) as _3? : null,base64Audio: m.$c(_S[2]) ?  _0.da(m[_S[2]], _3) as _3? : null,);}
  _6 copyWith({_3? audioUrl,_o deleteAudioUrl=_F,_3? base64Audio,_o deleteBase64Audio=_F,})=>_6(audioUrl: deleteAudioUrl?null:(audioUrl??_H.audioUrl),base64Audio: deleteBase64Audio?null:(base64Audio??_H.base64Audio),);
}
extension $ContentGroup on _7{
  _7 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'ContentGroup',_S[3]:contents.$m((e)=> e.toMap()).$l,}.$nn;}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromMap(_1 r){_;_1 m=r.$nn;return _7(contents: m.$c(_S[3]) ?  (m[_S[3]] as _p).$m((e)=>$Content.fromMap((e) as _1)).$l : _V[0],);}
  _7 copyWith({_q? contents,_o resetContents=_F,_q? appendContents,_q? removeContents,})=>_7(contents: ((resetContents?_V[0]:(contents??_H.contents)) as _q).$u(appendContents,removeContents),);
}
extension $Content on _8{
  _8 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;if (_H is _6){return (_H as _6).toMap();}if (_H is _7){return (_H as _7).toMap();}if (_H is _9){return (_H as _9).toMap();}if (_H is _a){return (_H as _a).toMap();}return <_3, _4>{}.$nn;}
  static _8 fromJson(String j)=>fromMap(_0.o(j));
  static _8 fromMap(_1 r){_;_1 m=r.$nn;if(m.$c(_S[0])){String _I=m[_S[0]] as _3;if(_I==_S[4]){return $AudioContent.fromMap(m);}if(_I==_S[5]){return $ContentGroup.fromMap(m);}if(_I==_S[6]){return $ImageContent.fromMap(m);}if(_I==_S[7]){return $TextContent.fromMap(m);}}return _8();}
}
extension $ImageContent on _9{
  _9 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'ImageContent',_S[8]:_0.ea(imageUrl),_S[9]:_0.ea(base64Image),}.$nn;}
  static _9 fromJson(String j)=>fromMap(_0.o(j));
  static _9 fromMap(_1 r){_;_1 m=r.$nn;return _9(imageUrl: m.$c(_S[8]) ?  _0.da(m[_S[8]], _3) as _3? : null,base64Image: m.$c(_S[9]) ?  _0.da(m[_S[9]], _3) as _3? : null,);}
  _9 copyWith({_3? imageUrl,_o deleteImageUrl=_F,_3? base64Image,_o deleteBase64Image=_F,})=>_9(imageUrl: deleteImageUrl?null:(imageUrl??_H.imageUrl),base64Image: deleteBase64Image?null:(base64Image??_H.base64Image),);
}
extension $TextContent on _a{
  _a get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'TextContent',_S[10]:_0.ea(text),}.$nn;}
  static _a fromJson(String j)=>fromMap(_0.o(j));
  static _a fromMap(_1 r){_;_1 m=r.$nn;return _a(text: m.$c(_S[10]) ?  _0.da(m[_S[10]], _3) as _3 : "",);}
  _a copyWith({_3? text,_o resetText=_F,})=>_a(text: resetText?"":(text??_H.text),);
}
extension $Message on _b{
  _b get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;if (_H is _c){return (_H as _c).toMap();}if (_H is _d){return (_H as _d).toMap();}if (_H is _e){return (_H as _e).toMap();}if (_H is _f){return (_H as _f).toMap();}return <_3, _4>{_S[11]:content.toMap(),}.$nn;}
  static _b fromJson(String j)=>fromMap(_0.o(j));
  static _b fromMap(_1 r){_;_1 m=r.$nn;if(m.$c(_S[12])){String _I=m[_S[12]] as _3;if(_I==_S[13]){return $UserMessage.fromMap(m);}if(_I==_S[14]){return $SystemMessage.fromMap(m);}if(_I==_S[15]){return $AgentMessage.fromMap(m);}if(_I==_S[16]){return $ToolMessage.fromMap(m);}}return _b(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _r('${_S[17]}$m.')),);}
  _b copyWith({_8? content,}){if (_H is _c){return (_H as _c).copyWith(content: content,);}if (_H is _d){return (_H as _d).copyWith(content: content,);}if (_H is _e){return (_H as _e).copyWith(content: content,);}if (_H is _f){return (_H as _f).copyWith(content: content,);}return _b(content: content??_H.content,);}
}
extension $UserMessage on _c{
  _c get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'UserMessage',_S[11]:content.toMap(),}.$nn;}
  static _c fromJson(String j)=>fromMap(_0.o(j));
  static _c fromMap(_1 r){_;_1 m=r.$nn;return _c(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _r('${_S[18]}$m.')),);}
  _c copyWith({_8? content,})=>_c(content: content??_H.content,);
}
extension $SystemMessage on _d{
  _d get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'SystemMessage',_S[11]:content.toMap(),}.$nn;}
  static _d fromJson(String j)=>fromMap(_0.o(j));
  static _d fromMap(_1 r){_;_1 m=r.$nn;return _d(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _r('${_S[19]}$m.')),);}
  _d copyWith({_8? content,})=>_d(content: content??_H.content,);
}
extension $AgentMessage on _e{
  _e get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'AgentMessage',_S[11]:content.toMap(),_S[20]:toolCalls.$m((e)=> e.toMap()).$l,}.$nn;}
  static _e fromJson(String j)=>fromMap(_0.o(j));
  static _e fromMap(_1 r){_;_1 m=r.$nn;return _e(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _r('${_S[21]}$m.')),toolCalls: m.$c(_S[20]) ?  (m[_S[20]] as _p).$m((e)=>$ToolCall.fromMap((e) as _1)).$l : _V[1],);}
  _e copyWith({_8? content,_s? toolCalls,_o resetToolCalls=_F,_s? appendToolCalls,_s? removeToolCalls,})=>_e(content: content??_H.content,toolCalls: ((resetToolCalls?_V[1]:(toolCalls??_H.toolCalls)) as _s).$u(appendToolCalls,removeToolCalls),);
}
extension $ToolMessage on _f{
  _f get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'ToolMessage',_S[11]:content.toMap(),_S[22]:_0.ea(toolCallId),}.$nn;}
  static _f fromJson(String j)=>fromMap(_0.o(j));
  static _f fromMap(_1 r){_;_1 m=r.$nn;return _f(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _r('${_S[23]}$m.')),toolCallId: m.$c(_S[22])? _0.da(m[_S[22]], _3) as _3:(throw _r('${_S[24]}$m.')),);}
  _f copyWith({_8? content,_3? toolCallId,})=>_f(content: content??_H.content,toolCallId: toolCallId??_H.toolCallId,);
}
extension $ChatModel on _g{
  _g get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'id':_0.ea(id),_S[25]:_0.ea(displayName),_S[26]:cost.toMap(),_S[27]:capabilities.toMap(),}.$nn;}
  static _g fromJson(String j)=>fromMap(_0.o(j));
  static _g fromMap(_1 r){_;_1 m=r.$nn;return _g(id: m.$c('id')? _0.da(m['id'], _3) as _3:(throw _r('${_S[28]}$m.')),displayName: m.$c(_S[25]) ?  _0.da(m[_S[25]], _3) as _3? : null,cost: m.$c(_S[26])?$ChatModelCost.fromMap((m[_S[26]]) as _1):(throw _r('${_S[29]}$m.')),capabilities: m.$c(_S[27])?$ChatModelCapabilities.fromMap((m[_S[27]]) as _1):(throw _r('${_S[30]}$m.')),);}
  _g copyWith({_3? id,_3? displayName,_o deleteDisplayName=_F,_n? cost,_m? capabilities,})=>_g(id: id??_H.id,displayName: deleteDisplayName?null:(displayName??_H.displayName),cost: cost??_H.cost,capabilities: capabilities??_H.capabilities,);
}
extension $ChatRequest on _h{
  _h get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[31]:messages.$m((e)=> e.toMap()).$l,_S[32]:tools.$m((e)=> _0.ea(e)).$l,_S[33]:model.toMap(),_S[34]:_0.ea(systemPrompt),_S[35]:_0.ea(user),_S[36]:responseFormat?.toMap(),}.$nn;}
  static _h fromJson(String j)=>fromMap(_0.o(j));
  static _h fromMap(_1 r){_;_1 m=r.$nn;return _h(messages: m.$c(_S[31])? (m[_S[31]] as _p).$m((e)=>$Message.fromMap((e) as _1)).$l:(throw _r('${_S[37]}$m.')),tools: m.$c(_S[32]) ?  (m[_S[32]] as _p).$m((e)=> _0.da(e, _t) as _t).$l : _V[2],model: m.$c(_S[33])?$ChatModel.fromMap((m[_S[33]]) as _1):(throw _r('${_S[38]}$m.')),systemPrompt: m.$c(_S[34]) ?  _0.da(m[_S[34]], _3) as _3? : null,user: m.$c(_S[35]) ?  _0.da(m[_S[35]], _3) as _3? : null,responseFormat: m.$c(_S[36]) ? $ToolSchema.fromMap((m[_S[36]]) as _1) : null,);}
  _h copyWith({_u? messages,_u? appendMessages,_u? removeMessages,_v? tools,_o resetTools=_F,_v? appendTools,_v? removeTools,_g? model,_3? systemPrompt,_o deleteSystemPrompt=_F,_3? user,_o deleteUser=_F,_l? responseFormat,_o deleteResponseFormat=_F,})=>_h(messages: (messages??_H.messages).$u(appendMessages,removeMessages),tools: ((resetTools?_V[2]:(tools??_H.tools)) as _v).$u(appendTools,removeTools),model: model??_H.model,systemPrompt: deleteSystemPrompt?null:(systemPrompt??_H.systemPrompt),user: deleteUser?null:(user??_H.user),responseFormat: deleteResponseFormat?null:(responseFormat??_H.responseFormat),);
}
extension $ChatResult on _i{
  _i get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[39]:message.toMap(),_S[40]:_0.ea(realCost),_S[41]:finishReason.name,_S[42]:metadata.$m((k,v)=>_w(k,v)),_S[43]:usage.toMap(),}.$nn;}
  static _i fromJson(String j)=>fromMap(_0.o(j));
  static _i fromMap(_1 r){_;_1 m=r.$nn;return _i(message: m.$c(_S[39])?$AgentMessage.fromMap((m[_S[39]]) as _1):(throw _r('${_S[44]}$m.')),realCost: m.$c(_S[40])? _0.da(m[_S[40]], _y) as _y:(throw _r('${_S[45]}$m.')),finishReason: m.$c(_S[41]) ? _0.e(ChatFinishReason.values, m[_S[41]]) as ChatFinishReason : _V[3],metadata: m.$c(_S[42]) ?  _0.fe((m[_S[42]] as Map).$e.$m((e)=>_x(e.key,e.value))) : _V[4],usage: m.$c(_S[43]) ? $ChatUsage.fromMap((m[_S[43]]) as _1) : _V[5],);}
  _i copyWith({_e? message,_y? realCost,_z? finishReason,_o resetFinishReason=_F,_1? metadata,_o resetMetadata=_F,_j? usage,_o resetUsage=_F,})=>_i(message: message??_H.message,realCost: realCost??_H.realCost,finishReason: resetFinishReason?_V[3]:(finishReason??_H.finishReason),metadata: resetMetadata?_V[4]:(metadata??_H.metadata),usage: resetUsage?_V[5]:(usage??_H.usage),);
}
extension $ChatUsage on _j{
  _j get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[46]:_0.ea(inputTokens),_S[47]:_0.ea(outputTokens),}.$nn;}
  static _j fromJson(String j)=>fromMap(_0.o(j));
  static _j fromMap(_1 r){_;_1 m=r.$nn;return _j(inputTokens: m.$c(_S[46]) ?  _0.da(m[_S[46]], _5) as _5 : 0,outputTokens: m.$c(_S[47]) ?  _0.da(m[_S[47]], _5) as _5 : 0,);}
  _j copyWith({_5? inputTokens,_o resetInputTokens=_F,_5? deltaInputTokens,_5? outputTokens,_o resetOutputTokens=_F,_5? deltaOutputTokens,})=>_j(inputTokens: deltaInputTokens!=null?(inputTokens??_H.inputTokens)+deltaInputTokens:resetInputTokens?0:(inputTokens??_H.inputTokens),outputTokens: deltaOutputTokens!=null?(outputTokens??_H.outputTokens)+deltaOutputTokens:resetOutputTokens?0:(outputTokens??_H.outputTokens),);
}
extension $ToolCall on _k{
  _k get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'id':_0.ea(id),_S[48]:_0.ea(name),_S[49]:_0.ea(arguments),}.$nn;}
  static _k fromJson(String j)=>fromMap(_0.o(j));
  static _k fromMap(_1 r){_;_1 m=r.$nn;return _k(id: m.$c('id')? _0.da(m['id'], _3) as _3:(throw _r('${_S[50]}$m.')),name: m.$c(_S[48])? _0.da(m[_S[48]], _3) as _3:(throw _r('${_S[51]}$m.')),arguments: m.$c(_S[49])? _0.da(m[_S[49]], _3) as _3:(throw _r('${_S[52]}$m.')),);}
  _k copyWith({_3? id,_3? name,_3? arguments,})=>_k(id: id??_H.id,name: name??_H.name,arguments: arguments??_H.arguments,);
}
extension $ToolSchema on _l{
  _l get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[48]:_0.ea(name),_S[53]:_0.ea(description),_S[54]:schema.$m((k,v)=>_w(k,v)),}.$nn;}
  static _l fromJson(String j)=>fromMap(_0.o(j));
  static _l fromMap(_1 r){_;_1 m=r.$nn;return _l(name: m.$c(_S[48])? _0.da(m[_S[48]], _3) as _3:(throw _r('${_S[55]}$m.')),description: m.$c(_S[53])? _0.da(m[_S[53]], _3) as _3:(throw _r('${_S[56]}$m.')),schema: m.$c(_S[54])? _0.fe((m[_S[54]] as Map).$e.$m((e)=>_x(e.key,e.value))):(throw _r('${_S[57]}$m.')),);}
  _l copyWith({_3? name,_3? description,_1? schema,})=>_l(name: name??_H.name,description: description??_H.description,schema: schema??_H.schema,);
}
extension $ChatModelCapabilities on _m{
  _m get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[32]:_0.ea(tools),_S[58]:_0.ea(ultraCompatibleMode),_S[59]:systemMode.name,_S[60]:_0.ea(contextWindow),_S[61]:_0.ea(maxTokenOutput),_S[62]:inputModalities.$m((e)=> e.name).$l,_S[63]:outputModalities.$m((e)=> e.name).$l,_S[64]:_0.ea(reasoning),_S[65]:_0.ea(structuredOutput),_S[66]:_0.ea(streaming),_S[67]:_0.ea(seesToolMessages),}.$nn;}
  static _m fromJson(String j)=>fromMap(_0.o(j));
  static _m fromMap(_1 r){_;_1 m=r.$nn;return _m(tools: m.$c(_S[32])? _0.da(m[_S[32]], _o) as _o:(throw _r('${_S[68]}$m.')),ultraCompatibleMode: m.$c(_S[58])? _0.da(m[_S[58]], _o) as _o:(throw _r('${_S[69]}$m.')),systemMode: m.$c(_S[59])?_0.e(ChatModelSystemMode.values, m[_S[59]]) as ChatModelSystemMode:(throw _r('${_S[70]}$m.')),contextWindow: m.$c(_S[60])? _0.da(m[_S[60]], _5) as _5:(throw _r('${_S[71]}$m.')),maxTokenOutput: m.$c(_S[61])? _0.da(m[_S[61]], _5) as _5:(throw _r('${_S[72]}$m.')),inputModalities: m.$c(_S[62])? (m[_S[62]] as _p).$m((e)=>_0.e(Modality.values, e) as Modality).$l:(throw _r('${_S[73]}$m.')),outputModalities: m.$c(_S[63])? (m[_S[63]] as _p).$m((e)=>_0.e(Modality.values, e) as Modality).$l:(throw _r('${_S[74]}$m.')),reasoning: m.$c(_S[64])? _0.da(m[_S[64]], _o) as _o:(throw _r('${_S[75]}$m.')),structuredOutput: m.$c(_S[65])? _0.da(m[_S[65]], _o) as _o:(throw _r('${_S[76]}$m.')),streaming: m.$c(_S[66])? _0.da(m[_S[66]], _o) as _o:(throw _r('${_S[77]}$m.')),seesToolMessages: m.$c(_S[67])? _0.da(m[_S[67]], _o) as _o:(throw _r('${_S[78]}$m.')),);}
  _m copyWith({_o? tools,_o? ultraCompatibleMode,_10? systemMode,_5? contextWindow,_5? deltaContextWindow,_5? maxTokenOutput,_5? deltaMaxTokenOutput,_11? inputModalities,_11? appendInputModalities,_11? removeInputModalities,_11? outputModalities,_11? appendOutputModalities,_11? removeOutputModalities,_o? reasoning,_o? structuredOutput,_o? streaming,_o? seesToolMessages,})=>_m(tools: tools??_H.tools,ultraCompatibleMode: ultraCompatibleMode??_H.ultraCompatibleMode,systemMode: systemMode??_H.systemMode,contextWindow: deltaContextWindow!=null?(contextWindow??_H.contextWindow)+deltaContextWindow:contextWindow??_H.contextWindow,maxTokenOutput: deltaMaxTokenOutput!=null?(maxTokenOutput??_H.maxTokenOutput)+deltaMaxTokenOutput:maxTokenOutput??_H.maxTokenOutput,inputModalities: (inputModalities??_H.inputModalities).$u(appendInputModalities,removeInputModalities),outputModalities: (outputModalities??_H.outputModalities).$u(appendOutputModalities,removeOutputModalities),reasoning: reasoning??_H.reasoning,structuredOutput: structuredOutput??_H.structuredOutput,streaming: streaming??_H.streaming,seesToolMessages: seesToolMessages??_H.seesToolMessages,);
}
extension $ChatModelCost on _n{
  _n get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[79]:_0.ea(input),_S[80]:_0.ea(output),}.$nn;}
  static _n fromJson(String j)=>fromMap(_0.o(j));
  static _n fromMap(_1 r){_;_1 m=r.$nn;return _n(input: m.$c(_S[79])? _0.da(m[_S[79]], _12) as _12:(throw _r('${_S[81]}$m.')),output: m.$c(_S[80])? _0.da(m[_S[80]], _12) as _12:(throw _r('${_S[82]}$m.')),);}
  _n copyWith({_12? input,_12? deltaInput,_12? output,_12? deltaOutput,})=>_n(input: deltaInput!=null?(input??_H.input)+deltaInput:input??_H.input,output: deltaOutput!=null?(output??_H.output)+deltaOutput:output??_H.output,);
}

