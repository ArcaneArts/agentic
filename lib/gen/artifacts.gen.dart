// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:agentic/chat/content/content_audio.dart";import "package:agentic/chat/content/content_group.dart";import "package:agentic/chat/content/content.dart";import "package:agentic/chat/content/content_image.dart";import "package:agentic/chat/content/text_content.dart";import "package:agentic/chat/message/message.dart";import "package:agentic/chat/message/message_user.dart";import "package:agentic/chat/message/message_system.dart";import "package:agentic/chat/message/message_agent.dart";import "package:agentic/chat/message/message_tool.dart";import "package:agentic/chat/connector/model.dart";import "package:agentic/chat/connector/chat_request.dart";import "package:agentic/chat/connector/result.dart";import "package:agentic/chat/tool/tool_call.dart";import "package:agentic/chat/tool/tool_schema.dart";import "package:agentic/util/chat_models.dart";import "package:agentic/util/naga_models.dart";import "package:agentic/util/open_router_models.dart";import "package:artifact/artifact.dart";import "dart:core";import "package:agentic/chat/tool/tool.dart";import "package:rational/rational.dart";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=AudioContent;typedef _7=ContentGroup;typedef _8=Content;typedef _9=ImageContent;typedef _a=TextContent;typedef _b=Message;typedef _c=UserMessage;typedef _d=SystemMessage;typedef _e=AgentMessage;typedef _f=ToolMessage;typedef _g=ChatModel;typedef _h=ChatRequest;typedef _i=ChatResult;typedef _j=ChatUsage;typedef _k=ToolCall;typedef _l=ToolSchema;typedef _m=ChatModelCapabilities;typedef _n=ChatModelCost;typedef _o=NagaModelsListResponse;typedef _p=NagaModel;typedef _q=NagaArchitecture;typedef _r=NagaPricing;typedef _s=OpenRouterModelsListResponse;typedef _t=OpenRouterModel;typedef _u=OpenRouterArchitecture;typedef _v=OpenRouterPricing;typedef _w=bool;typedef _x=List;typedef _y=List<Content>;typedef _z=ArgumentError;typedef _10=List<ToolCall>;typedef _11=Tool;typedef _12=List<Message>;typedef _13=List<Tool>;typedef _14=MapEntry;typedef _15=MapEntry<String, dynamic>;typedef _16=Rational;typedef _17=ChatFinishReason;typedef _18=ChatModelSystemMode;typedef _19=List<Modality>;typedef _1a=double;typedef _1b=List<NagaModel>;typedef _1c=List<OpenRouterModel>;typedef _1d=List<dynamic>;
const _2 _S=['_subclass_Content','audioUrl','base64Audio','contents','AudioContent','ContentGroup','ImageContent','TextContent','imageUrl','base64Image','text','content','_subclass_Message','UserMessage','SystemMessage','AgentMessage','ToolMessage','Missing required Message."content" in map ','Missing required UserMessage."content" in map ','Missing required SystemMessage."content" in map ','toolCalls','Missing required AgentMessage."content" in map ','toolCallId','Missing required ToolMessage."content" in map ','Missing required ToolMessage."toolCallId" in map ','displayName','cost','capabilities','deprecated','Missing required ChatModel."id" in map ','Missing required ChatModel."cost" in map ','Missing required ChatModel."capabilities" in map ','messages','tools','model','systemPrompt','user','responseFormat','Missing required ChatRequest."messages" in map ','Missing required ChatRequest."model" in map ','message','realCost','finishReason','metadata','usage','Missing required ChatResult."message" in map ','Missing required ChatResult."realCost" in map ','inputTokens','outputTokens','name','arguments','Missing required ToolCall."id" in map ','Missing required ToolCall."name" in map ','Missing required ToolCall."arguments" in map ','description','schema','Missing required ToolSchema."name" in map ','Missing required ToolSchema."description" in map ','Missing required ToolSchema."schema" in map ','ultraCompatibleMode','systemMode','contextWindow','maxTokenOutput','inputModalities','outputModalities','reasoning','structuredOutput','streaming','seesToolMessages','Missing required ChatModelCapabilities."tools" in map ','Missing required ChatModelCapabilities."ultraCompatibleMode" in map ','Missing required ChatModelCapabilities."systemMode" in map ','Missing required ChatModelCapabilities."contextWindow" in map ','Missing required ChatModelCapabilities."maxTokenOutput" in map ','Missing required ChatModelCapabilities."inputModalities" in map ','Missing required ChatModelCapabilities."outputModalities" in map ','Missing required ChatModelCapabilities."reasoning" in map ','Missing required ChatModelCapabilities."structuredOutput" in map ','Missing required ChatModelCapabilities."streaming" in map ','Missing required ChatModelCapabilities."seesToolMessages" in map ','input','output','Missing required ChatModelCost."input" in map ','Missing required ChatModelCost."output" in map ','data','context_length','architecture','supported_parameters','pricing','Missing required NagaModel."id" in map ','Missing required NagaModel."architecture" in map ','input_modalities','output_modalities','tokenizer','Missing required NagaArchitecture."tokenizer" in map ','prompt','completion','request','image','web_search','audio','internal_reasoning','canonical_slug','created','Missing required OpenRouterModel."id" in map ','Missing required OpenRouterModel."canonical_slug" in map ','Missing required OpenRouterModel."name" in map ','Missing required OpenRouterModel."created" in map ','Missing required OpenRouterModel."context_length" in map ','Missing required OpenRouterModel."architecture" in map ','modality','Missing required OpenRouterArchitecture."modality" in map ','Missing required OpenRouterArchitecture."tokenizer" in map '];const _1d _V=[<_8>[],<_k>[],false,<_11>[],ChatFinishReason.unspecified,<_3,_4>{},ChatUsage(),<_p>[],200000,<_3>[],NagaPricing(),<_t>[],OpenRouterPricing()];const _w _T=true;const _w _F=false;const _5 _ = 0;
extension $AudioContent on _6{
  _6 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'AudioContent',_S[1]:_0.ea(audioUrl),_S[2]:_0.ea(base64Audio),}.$nn;}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromMap(_1 r){_;_1 m=r.$nn;return _6(audioUrl: m.$c(_S[1]) ?  _0.da(m[_S[1]], _3) as _3? : null,base64Audio: m.$c(_S[2]) ?  _0.da(m[_S[2]], _3) as _3? : null,);}
  _6 copyWith({_3? audioUrl,_w deleteAudioUrl=_F,_3? base64Audio,_w deleteBase64Audio=_F,})=>_6(audioUrl: deleteAudioUrl?null:(audioUrl??_H.audioUrl),base64Audio: deleteBase64Audio?null:(base64Audio??_H.base64Audio),);
}
extension $ContentGroup on _7{
  _7 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'ContentGroup',_S[3]:contents.$m((e)=> e.toMap()).$l,}.$nn;}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromMap(_1 r){_;_1 m=r.$nn;return _7(contents: m.$c(_S[3]) ?  (m[_S[3]] as _x).$m((e)=>$Content.fromMap((e) as _1)).$l : _V[0],);}
  _7 copyWith({_y? contents,_w resetContents=_F,_y? appendContents,_y? removeContents,})=>_7(contents: ((resetContents?_V[0]:(contents??_H.contents)) as _y).$u(appendContents,removeContents),);
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
  _9 copyWith({_3? imageUrl,_w deleteImageUrl=_F,_3? base64Image,_w deleteBase64Image=_F,})=>_9(imageUrl: deleteImageUrl?null:(imageUrl??_H.imageUrl),base64Image: deleteBase64Image?null:(base64Image??_H.base64Image),);
}
extension $TextContent on _a{
  _a get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'TextContent',_S[10]:_0.ea(text),}.$nn;}
  static _a fromJson(String j)=>fromMap(_0.o(j));
  static _a fromMap(_1 r){_;_1 m=r.$nn;return _a(text: m.$c(_S[10]) ?  _0.da(m[_S[10]], _3) as _3 : "",);}
  _a copyWith({_3? text,_w resetText=_F,})=>_a(text: resetText?"":(text??_H.text),);
}
extension $Message on _b{
  _b get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;if (_H is _c){return (_H as _c).toMap();}if (_H is _d){return (_H as _d).toMap();}if (_H is _e){return (_H as _e).toMap();}if (_H is _f){return (_H as _f).toMap();}return <_3, _4>{_S[11]:content.toMap(),}.$nn;}
  static _b fromJson(String j)=>fromMap(_0.o(j));
  static _b fromMap(_1 r){_;_1 m=r.$nn;if(m.$c(_S[12])){String _I=m[_S[12]] as _3;if(_I==_S[13]){return $UserMessage.fromMap(m);}if(_I==_S[14]){return $SystemMessage.fromMap(m);}if(_I==_S[15]){return $AgentMessage.fromMap(m);}if(_I==_S[16]){return $ToolMessage.fromMap(m);}}return _b(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _z('${_S[17]}$m.')),);}
  _b copyWith({_8? content,}){if (_H is _c){return (_H as _c).copyWith(content: content,);}if (_H is _d){return (_H as _d).copyWith(content: content,);}if (_H is _e){return (_H as _e).copyWith(content: content,);}if (_H is _f){return (_H as _f).copyWith(content: content,);}return _b(content: content??_H.content,);}
}
extension $UserMessage on _c{
  _c get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'UserMessage',_S[11]:content.toMap(),}.$nn;}
  static _c fromJson(String j)=>fromMap(_0.o(j));
  static _c fromMap(_1 r){_;_1 m=r.$nn;return _c(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _z('${_S[18]}$m.')),);}
  _c copyWith({_8? content,})=>_c(content: content??_H.content,);
}
extension $SystemMessage on _d{
  _d get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'SystemMessage',_S[11]:content.toMap(),}.$nn;}
  static _d fromJson(String j)=>fromMap(_0.o(j));
  static _d fromMap(_1 r){_;_1 m=r.$nn;return _d(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _z('${_S[19]}$m.')),);}
  _d copyWith({_8? content,})=>_d(content: content??_H.content,);
}
extension $AgentMessage on _e{
  _e get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'AgentMessage',_S[11]:content.toMap(),_S[20]:toolCalls.$m((e)=> e.toMap()).$l,}.$nn;}
  static _e fromJson(String j)=>fromMap(_0.o(j));
  static _e fromMap(_1 r){_;_1 m=r.$nn;return _e(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _z('${_S[21]}$m.')),toolCalls: m.$c(_S[20]) ?  (m[_S[20]] as _x).$m((e)=>$ToolCall.fromMap((e) as _1)).$l : _V[1],);}
  _e copyWith({_8? content,_10? toolCalls,_w resetToolCalls=_F,_10? appendToolCalls,_10? removeToolCalls,})=>_e(content: content??_H.content,toolCalls: ((resetToolCalls?_V[1]:(toolCalls??_H.toolCalls)) as _10).$u(appendToolCalls,removeToolCalls),);
}
extension $ToolMessage on _f{
  _f get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[12]: 'ToolMessage',_S[11]:content.toMap(),_S[22]:_0.ea(toolCallId),}.$nn;}
  static _f fromJson(String j)=>fromMap(_0.o(j));
  static _f fromMap(_1 r){_;_1 m=r.$nn;return _f(content: m.$c(_S[11])?$Content.fromMap((m[_S[11]]) as _1):(throw _z('${_S[23]}$m.')),toolCallId: m.$c(_S[22])? _0.da(m[_S[22]], _3) as _3:(throw _z('${_S[24]}$m.')),);}
  _f copyWith({_8? content,_3? toolCallId,})=>_f(content: content??_H.content,toolCallId: toolCallId??_H.toolCallId,);
}
extension $ChatModel on _g{
  _g get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'id':_0.ea(id),_S[25]:_0.ea(displayName),_S[26]:cost.toMap(),_S[27]:capabilities.toMap(),_S[28]:_0.ea(deprecated),}.$nn;}
  static _g fromJson(String j)=>fromMap(_0.o(j));
  static _g fromMap(_1 r){_;_1 m=r.$nn;return _g(id: m.$c('id')? _0.da(m['id'], _3) as _3:(throw _z('${_S[29]}$m.')),displayName: m.$c(_S[25]) ?  _0.da(m[_S[25]], _3) as _3? : null,cost: m.$c(_S[26])?$ChatModelCost.fromMap((m[_S[26]]) as _1):(throw _z('${_S[30]}$m.')),capabilities: m.$c(_S[27])?$ChatModelCapabilities.fromMap((m[_S[27]]) as _1):(throw _z('${_S[31]}$m.')),deprecated: m.$c(_S[28]) ?  _0.da(m[_S[28]], _w) as _w : _V[2],);}
  _g copyWith({_3? id,_3? displayName,_w deleteDisplayName=_F,_n? cost,_m? capabilities,_w? deprecated,_w resetDeprecated=_F,})=>_g(id: id??_H.id,displayName: deleteDisplayName?null:(displayName??_H.displayName),cost: cost??_H.cost,capabilities: capabilities??_H.capabilities,deprecated: resetDeprecated?_V[2]:(deprecated??_H.deprecated),);
}
extension $ChatRequest on _h{
  _h get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[32]:messages.$m((e)=> e.toMap()).$l,_S[33]:tools.$m((e)=> _0.ea(e)).$l,_S[34]:model.toMap(),_S[35]:_0.ea(systemPrompt),_S[36]:_0.ea(user),_S[37]:responseFormat?.toMap(),}.$nn;}
  static _h fromJson(String j)=>fromMap(_0.o(j));
  static _h fromMap(_1 r){_;_1 m=r.$nn;return _h(messages: m.$c(_S[32])? (m[_S[32]] as _x).$m((e)=>$Message.fromMap((e) as _1)).$l:(throw _z('${_S[38]}$m.')),tools: m.$c(_S[33]) ?  (m[_S[33]] as _x).$m((e)=> _0.da(e, _11) as _11).$l : _V[3],model: m.$c(_S[34])?$ChatModel.fromMap((m[_S[34]]) as _1):(throw _z('${_S[39]}$m.')),systemPrompt: m.$c(_S[35]) ?  _0.da(m[_S[35]], _3) as _3? : null,user: m.$c(_S[36]) ?  _0.da(m[_S[36]], _3) as _3? : null,responseFormat: m.$c(_S[37]) ? $ToolSchema.fromMap((m[_S[37]]) as _1) : null,);}
  _h copyWith({_12? messages,_12? appendMessages,_12? removeMessages,_13? tools,_w resetTools=_F,_13? appendTools,_13? removeTools,_g? model,_3? systemPrompt,_w deleteSystemPrompt=_F,_3? user,_w deleteUser=_F,_l? responseFormat,_w deleteResponseFormat=_F,})=>_h(messages: (messages??_H.messages).$u(appendMessages,removeMessages),tools: ((resetTools?_V[3]:(tools??_H.tools)) as _13).$u(appendTools,removeTools),model: model??_H.model,systemPrompt: deleteSystemPrompt?null:(systemPrompt??_H.systemPrompt),user: deleteUser?null:(user??_H.user),responseFormat: deleteResponseFormat?null:(responseFormat??_H.responseFormat),);
}
extension $ChatResult on _i{
  _i get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[40]:message.toMap(),_S[41]:_0.ea(realCost),_S[42]:finishReason.name,_S[43]:metadata.$m((k,v)=>_14(k,v)),_S[44]:usage.toMap(),}.$nn;}
  static _i fromJson(String j)=>fromMap(_0.o(j));
  static _i fromMap(_1 r){_;_1 m=r.$nn;return _i(message: m.$c(_S[40])?$AgentMessage.fromMap((m[_S[40]]) as _1):(throw _z('${_S[45]}$m.')),realCost: m.$c(_S[41])? _0.da(m[_S[41]], _16) as _16:(throw _z('${_S[46]}$m.')),finishReason: m.$c(_S[42]) ? _0.e(ChatFinishReason.values, m[_S[42]]) as ChatFinishReason : _V[4],metadata: m.$c(_S[43]) ?  _0.fe((m[_S[43]] as Map).$e.$m((e)=>_15(e.key,e.value))) : _V[5],usage: m.$c(_S[44]) ? $ChatUsage.fromMap((m[_S[44]]) as _1) : _V[6],);}
  _i copyWith({_e? message,_16? realCost,_17? finishReason,_w resetFinishReason=_F,_1? metadata,_w resetMetadata=_F,_j? usage,_w resetUsage=_F,})=>_i(message: message??_H.message,realCost: realCost??_H.realCost,finishReason: resetFinishReason?_V[4]:(finishReason??_H.finishReason),metadata: resetMetadata?_V[5]:(metadata??_H.metadata),usage: resetUsage?_V[6]:(usage??_H.usage),);
}
extension $ChatUsage on _j{
  _j get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[47]:_0.ea(inputTokens),_S[48]:_0.ea(outputTokens),}.$nn;}
  static _j fromJson(String j)=>fromMap(_0.o(j));
  static _j fromMap(_1 r){_;_1 m=r.$nn;return _j(inputTokens: m.$c(_S[47]) ?  _0.da(m[_S[47]], _5) as _5 : 0,outputTokens: m.$c(_S[48]) ?  _0.da(m[_S[48]], _5) as _5 : 0,);}
  _j copyWith({_5? inputTokens,_w resetInputTokens=_F,_5? deltaInputTokens,_5? outputTokens,_w resetOutputTokens=_F,_5? deltaOutputTokens,})=>_j(inputTokens: deltaInputTokens!=null?(inputTokens??_H.inputTokens)+deltaInputTokens:resetInputTokens?0:(inputTokens??_H.inputTokens),outputTokens: deltaOutputTokens!=null?(outputTokens??_H.outputTokens)+deltaOutputTokens:resetOutputTokens?0:(outputTokens??_H.outputTokens),);
}
extension $ToolCall on _k{
  _k get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'id':_0.ea(id),_S[49]:_0.ea(name),_S[50]:_0.ea(arguments),}.$nn;}
  static _k fromJson(String j)=>fromMap(_0.o(j));
  static _k fromMap(_1 r){_;_1 m=r.$nn;return _k(id: m.$c('id')? _0.da(m['id'], _3) as _3:(throw _z('${_S[51]}$m.')),name: m.$c(_S[49])? _0.da(m[_S[49]], _3) as _3:(throw _z('${_S[52]}$m.')),arguments: m.$c(_S[50])? _0.da(m[_S[50]], _3) as _3:(throw _z('${_S[53]}$m.')),);}
  _k copyWith({_3? id,_3? name,_3? arguments,})=>_k(id: id??_H.id,name: name??_H.name,arguments: arguments??_H.arguments,);
}
extension $ToolSchema on _l{
  _l get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[49]:_0.ea(name),_S[54]:_0.ea(description),_S[55]:schema.$m((k,v)=>_14(k,v)),}.$nn;}
  static _l fromJson(String j)=>fromMap(_0.o(j));
  static _l fromMap(_1 r){_;_1 m=r.$nn;return _l(name: m.$c(_S[49])? _0.da(m[_S[49]], _3) as _3:(throw _z('${_S[56]}$m.')),description: m.$c(_S[54])? _0.da(m[_S[54]], _3) as _3:(throw _z('${_S[57]}$m.')),schema: m.$c(_S[55])? _0.fe((m[_S[55]] as Map).$e.$m((e)=>_15(e.key,e.value))):(throw _z('${_S[58]}$m.')),);}
  _l copyWith({_3? name,_3? description,_1? schema,})=>_l(name: name??_H.name,description: description??_H.description,schema: schema??_H.schema,);
}
extension $ChatModelCapabilities on _m{
  _m get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[33]:_0.ea(tools),_S[59]:_0.ea(ultraCompatibleMode),_S[60]:systemMode.name,_S[61]:_0.ea(contextWindow),_S[62]:_0.ea(maxTokenOutput),_S[63]:inputModalities.$m((e)=> e.name).$l,_S[64]:outputModalities.$m((e)=> e.name).$l,_S[65]:_0.ea(reasoning),_S[66]:_0.ea(structuredOutput),_S[67]:_0.ea(streaming),_S[68]:_0.ea(seesToolMessages),}.$nn;}
  static _m fromJson(String j)=>fromMap(_0.o(j));
  static _m fromMap(_1 r){_;_1 m=r.$nn;return _m(tools: m.$c(_S[33])? _0.da(m[_S[33]], _w) as _w:(throw _z('${_S[69]}$m.')),ultraCompatibleMode: m.$c(_S[59])? _0.da(m[_S[59]], _w) as _w:(throw _z('${_S[70]}$m.')),systemMode: m.$c(_S[60])?_0.e(ChatModelSystemMode.values, m[_S[60]]) as ChatModelSystemMode:(throw _z('${_S[71]}$m.')),contextWindow: m.$c(_S[61])? _0.da(m[_S[61]], _5) as _5:(throw _z('${_S[72]}$m.')),maxTokenOutput: m.$c(_S[62])? _0.da(m[_S[62]], _5) as _5:(throw _z('${_S[73]}$m.')),inputModalities: m.$c(_S[63])? (m[_S[63]] as _x).$m((e)=>_0.e(Modality.values, e) as Modality).$l:(throw _z('${_S[74]}$m.')),outputModalities: m.$c(_S[64])? (m[_S[64]] as _x).$m((e)=>_0.e(Modality.values, e) as Modality).$l:(throw _z('${_S[75]}$m.')),reasoning: m.$c(_S[65])? _0.da(m[_S[65]], _w) as _w:(throw _z('${_S[76]}$m.')),structuredOutput: m.$c(_S[66])? _0.da(m[_S[66]], _w) as _w:(throw _z('${_S[77]}$m.')),streaming: m.$c(_S[67])? _0.da(m[_S[67]], _w) as _w:(throw _z('${_S[78]}$m.')),seesToolMessages: m.$c(_S[68])? _0.da(m[_S[68]], _w) as _w:(throw _z('${_S[79]}$m.')),);}
  _m copyWith({_w? tools,_w? ultraCompatibleMode,_18? systemMode,_5? contextWindow,_5? deltaContextWindow,_5? maxTokenOutput,_5? deltaMaxTokenOutput,_19? inputModalities,_19? appendInputModalities,_19? removeInputModalities,_19? outputModalities,_19? appendOutputModalities,_19? removeOutputModalities,_w? reasoning,_w? structuredOutput,_w? streaming,_w? seesToolMessages,})=>_m(tools: tools??_H.tools,ultraCompatibleMode: ultraCompatibleMode??_H.ultraCompatibleMode,systemMode: systemMode??_H.systemMode,contextWindow: deltaContextWindow!=null?(contextWindow??_H.contextWindow)+deltaContextWindow:contextWindow??_H.contextWindow,maxTokenOutput: deltaMaxTokenOutput!=null?(maxTokenOutput??_H.maxTokenOutput)+deltaMaxTokenOutput:maxTokenOutput??_H.maxTokenOutput,inputModalities: (inputModalities??_H.inputModalities).$u(appendInputModalities,removeInputModalities),outputModalities: (outputModalities??_H.outputModalities).$u(appendOutputModalities,removeOutputModalities),reasoning: reasoning??_H.reasoning,structuredOutput: structuredOutput??_H.structuredOutput,streaming: streaming??_H.streaming,seesToolMessages: seesToolMessages??_H.seesToolMessages,);
}
extension $ChatModelCost on _n{
  _n get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[80]:_0.ea(input),_S[81]:_0.ea(output),}.$nn;}
  static _n fromJson(String j)=>fromMap(_0.o(j));
  static _n fromMap(_1 r){_;_1 m=r.$nn;return _n(input: m.$c(_S[80])? _0.da(m[_S[80]], _1a) as _1a:(throw _z('${_S[82]}$m.')),output: m.$c(_S[81])? _0.da(m[_S[81]], _1a) as _1a:(throw _z('${_S[83]}$m.')),);}
  _n copyWith({_1a? input,_1a? deltaInput,_1a? output,_1a? deltaOutput,})=>_n(input: deltaInput!=null?(input??_H.input)+deltaInput:input??_H.input,output: deltaOutput!=null?(output??_H.output)+deltaOutput:output??_H.output,);
}
extension $NagaModelsListResponse on _o{
  _o get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[84]:data.$m((e)=> e.toMap()).$l,}.$nn;}
  static _o fromJson(String j)=>fromMap(_0.o(j));
  static _o fromMap(_1 r){_;_1 m=r.$nn;return _o(data: m.$c(_S[84]) ?  (m[_S[84]] as _x).$m((e)=>$NagaModel.fromMap((e) as _1)).$l : _V[7],);}
  _o copyWith({_1b? data,_w resetData=_F,_1b? appendData,_1b? removeData,})=>_o(data: ((resetData?_V[7]:(data??_H.data)) as _1b).$u(appendData,removeData),);
}
extension $NagaModel on _p{
  _p get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'id':_0.ea(id),_S[85]:_0.ea(context_length),_S[86]:architecture.toMap(),_S[87]:supported_parameters.$m((e)=> _0.ea(e)).$l,_S[88]:pricing.toMap(),}.$nn;}
  static _p fromJson(String j)=>fromMap(_0.o(j));
  static _p fromMap(_1 r){_;_1 m=r.$nn;return _p(id: m.$c('id')? _0.da(m['id'], _3) as _3:(throw _z('${_S[89]}$m.')),context_length: m.$c(_S[85]) ?  _0.da(m[_S[85]], _5) as _5 : _V[8],architecture: m.$c(_S[86])?$NagaArchitecture.fromMap((m[_S[86]]) as _1):(throw _z('${_S[90]}$m.')),supported_parameters: m.$c(_S[87]) ?  (m[_S[87]] as _x).$m((e)=> _0.da(e, _3) as _3).$l : _V[9],pricing: m.$c(_S[88]) ? $NagaPricing.fromMap((m[_S[88]]) as _1) : _V[10],);}
  _p copyWith({_3? id,_5? context_length,_w resetContext_length=_F,_5? deltaContext_length,_q? architecture,_2? supported_parameters,_w resetSupported_parameters=_F,_2? appendSupported_parameters,_2? removeSupported_parameters,_r? pricing,_w resetPricing=_F,})=>_p(id: id??_H.id,context_length: deltaContext_length!=null?(context_length??_H.context_length)+deltaContext_length:resetContext_length?_V[8]:(context_length??_H.context_length),architecture: architecture??_H.architecture,supported_parameters: ((resetSupported_parameters?_V[9]:(supported_parameters??_H.supported_parameters)) as _2).$u(appendSupported_parameters,removeSupported_parameters),pricing: resetPricing?_V[10]:(pricing??_H.pricing),);
}
extension $NagaArchitecture on _q{
  _q get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[91]:input_modalities.$m((e)=> _0.ea(e)).$l,_S[92]:output_modalities.$m((e)=> _0.ea(e)).$l,_S[93]:_0.ea(tokenizer),}.$nn;}
  static _q fromJson(String j)=>fromMap(_0.o(j));
  static _q fromMap(_1 r){_;_1 m=r.$nn;return _q(input_modalities: m.$c(_S[91]) ?  (m[_S[91]] as _x).$m((e)=> _0.da(e, _3) as _3).$l : _V[9],output_modalities: m.$c(_S[92]) ?  (m[_S[92]] as _x).$m((e)=> _0.da(e, _3) as _3).$l : _V[9],tokenizer: m.$c(_S[93])? _0.da(m[_S[93]], _3) as _3:(throw _z('${_S[94]}$m.')),);}
  _q copyWith({_2? input_modalities,_w resetInput_modalities=_F,_2? appendInput_modalities,_2? removeInput_modalities,_2? output_modalities,_w resetOutput_modalities=_F,_2? appendOutput_modalities,_2? removeOutput_modalities,_3? tokenizer,})=>_q(input_modalities: ((resetInput_modalities?_V[9]:(input_modalities??_H.input_modalities)) as _2).$u(appendInput_modalities,removeInput_modalities),output_modalities: ((resetOutput_modalities?_V[9]:(output_modalities??_H.output_modalities)) as _2).$u(appendOutput_modalities,removeOutput_modalities),tokenizer: tokenizer??_H.tokenizer,);
}
extension $NagaPricing on _r{
  _r get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[95]:_0.ea(prompt),_S[96]:_0.ea(completion),_S[97]:_0.ea(request),_S[98]:_0.ea(image),_S[99]:_0.ea(web_search),_S[100]:_0.ea(audio),_S[101]:_0.ea(internal_reasoning),}.$nn;}
  static _r fromJson(String j)=>fromMap(_0.o(j));
  static _r fromMap(_1 r){_;_1 m=r.$nn;return _r(prompt: m.$c(_S[95]) ?  _0.da(m[_S[95]], _3) as _3 : "0",completion: m.$c(_S[96]) ?  _0.da(m[_S[96]], _3) as _3 : "0",request: m.$c(_S[97]) ?  _0.da(m[_S[97]], _3) as _3 : "0",image: m.$c(_S[98]) ?  _0.da(m[_S[98]], _3) as _3 : "0",web_search: m.$c(_S[99]) ?  _0.da(m[_S[99]], _3) as _3 : "0",audio: m.$c(_S[100]) ?  _0.da(m[_S[100]], _3) as _3 : "0",internal_reasoning: m.$c(_S[101]) ?  _0.da(m[_S[101]], _3) as _3 : "0",);}
  _r copyWith({_3? prompt,_w resetPrompt=_F,_3? completion,_w resetCompletion=_F,_3? request,_w resetRequest=_F,_3? image,_w resetImage=_F,_3? web_search,_w resetWeb_search=_F,_3? audio,_w resetAudio=_F,_3? internal_reasoning,_w resetInternal_reasoning=_F,})=>_r(prompt: resetPrompt?"0":(prompt??_H.prompt),completion: resetCompletion?"0":(completion??_H.completion),request: resetRequest?"0":(request??_H.request),image: resetImage?"0":(image??_H.image),web_search: resetWeb_search?"0":(web_search??_H.web_search),audio: resetAudio?"0":(audio??_H.audio),internal_reasoning: resetInternal_reasoning?"0":(internal_reasoning??_H.internal_reasoning),);
}
extension $OpenRouterModelsListResponse on _s{
  _s get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[84]:data.$m((e)=> e.toMap()).$l,}.$nn;}
  static _s fromJson(String j)=>fromMap(_0.o(j));
  static _s fromMap(_1 r){_;_1 m=r.$nn;return _s(data: m.$c(_S[84]) ?  (m[_S[84]] as _x).$m((e)=>$OpenRouterModel.fromMap((e) as _1)).$l : _V[11],);}
  _s copyWith({_1c? data,_w resetData=_F,_1c? appendData,_1c? removeData,})=>_s(data: ((resetData?_V[11]:(data??_H.data)) as _1c).$u(appendData,removeData),);
}
extension $OpenRouterModel on _t{
  _t get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'id':_0.ea(id),_S[102]:_0.ea(canonical_slug),_S[49]:_0.ea(name),_S[103]:_0.ea(created),_S[85]:_0.ea(context_length),_S[86]:architecture.toMap(),_S[87]:supported_parameters.$m((e)=> _0.ea(e)).$l,_S[88]:pricing.toMap(),}.$nn;}
  static _t fromJson(String j)=>fromMap(_0.o(j));
  static _t fromMap(_1 r){_;_1 m=r.$nn;return _t(id: m.$c('id')? _0.da(m['id'], _3) as _3:(throw _z('${_S[104]}$m.')),canonical_slug: m.$c(_S[102])? _0.da(m[_S[102]], _3) as _3:(throw _z('${_S[105]}$m.')),name: m.$c(_S[49])? _0.da(m[_S[49]], _3) as _3:(throw _z('${_S[106]}$m.')),created: m.$c(_S[103])? _0.da(m[_S[103]], _5) as _5:(throw _z('${_S[107]}$m.')),context_length: m.$c(_S[85])? _0.da(m[_S[85]], _5) as _5:(throw _z('${_S[108]}$m.')),architecture: m.$c(_S[86])?$OpenRouterArchitecture.fromMap((m[_S[86]]) as _1):(throw _z('${_S[109]}$m.')),supported_parameters: m.$c(_S[87]) ?  (m[_S[87]] as _x).$m((e)=> _0.da(e, _3) as _3).$l : _V[9],pricing: m.$c(_S[88]) ? $OpenRouterPricing.fromMap((m[_S[88]]) as _1) : _V[12],);}
  _t copyWith({_3? id,_3? canonical_slug,_3? name,_5? created,_5? deltaCreated,_5? context_length,_5? deltaContext_length,_u? architecture,_2? supported_parameters,_w resetSupported_parameters=_F,_2? appendSupported_parameters,_2? removeSupported_parameters,_v? pricing,_w resetPricing=_F,})=>_t(id: id??_H.id,canonical_slug: canonical_slug??_H.canonical_slug,name: name??_H.name,created: deltaCreated!=null?(created??_H.created)+deltaCreated:created??_H.created,context_length: deltaContext_length!=null?(context_length??_H.context_length)+deltaContext_length:context_length??_H.context_length,architecture: architecture??_H.architecture,supported_parameters: ((resetSupported_parameters?_V[9]:(supported_parameters??_H.supported_parameters)) as _2).$u(appendSupported_parameters,removeSupported_parameters),pricing: resetPricing?_V[12]:(pricing??_H.pricing),);
}
extension $OpenRouterArchitecture on _u{
  _u get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[110]:_0.ea(modality),_S[91]:input_modalities.$m((e)=> _0.ea(e)).$l,_S[92]:output_modalities.$m((e)=> _0.ea(e)).$l,_S[93]:_0.ea(tokenizer),}.$nn;}
  static _u fromJson(String j)=>fromMap(_0.o(j));
  static _u fromMap(_1 r){_;_1 m=r.$nn;return _u(modality: m.$c(_S[110])? _0.da(m[_S[110]], _3) as _3:(throw _z('${_S[111]}$m.')),input_modalities: m.$c(_S[91]) ?  (m[_S[91]] as _x).$m((e)=> _0.da(e, _3) as _3).$l : _V[9],output_modalities: m.$c(_S[92]) ?  (m[_S[92]] as _x).$m((e)=> _0.da(e, _3) as _3).$l : _V[9],tokenizer: m.$c(_S[93])? _0.da(m[_S[93]], _3) as _3:(throw _z('${_S[112]}$m.')),);}
  _u copyWith({_3? modality,_2? input_modalities,_w resetInput_modalities=_F,_2? appendInput_modalities,_2? removeInput_modalities,_2? output_modalities,_w resetOutput_modalities=_F,_2? appendOutput_modalities,_2? removeOutput_modalities,_3? tokenizer,})=>_u(modality: modality??_H.modality,input_modalities: ((resetInput_modalities?_V[9]:(input_modalities??_H.input_modalities)) as _2).$u(appendInput_modalities,removeInput_modalities),output_modalities: ((resetOutput_modalities?_V[9]:(output_modalities??_H.output_modalities)) as _2).$u(appendOutput_modalities,removeOutput_modalities),tokenizer: tokenizer??_H.tokenizer,);
}
extension $OpenRouterPricing on _v{
  _v get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[95]:_0.ea(prompt),_S[96]:_0.ea(completion),_S[97]:_0.ea(request),_S[98]:_0.ea(image),_S[99]:_0.ea(web_search),_S[100]:_0.ea(audio),_S[101]:_0.ea(internal_reasoning),}.$nn;}
  static _v fromJson(String j)=>fromMap(_0.o(j));
  static _v fromMap(_1 r){_;_1 m=r.$nn;return _v(prompt: m.$c(_S[95]) ?  _0.da(m[_S[95]], _3) as _3 : "0",completion: m.$c(_S[96]) ?  _0.da(m[_S[96]], _3) as _3 : "0",request: m.$c(_S[97]) ?  _0.da(m[_S[97]], _3) as _3 : "0",image: m.$c(_S[98]) ?  _0.da(m[_S[98]], _3) as _3 : "0",web_search: m.$c(_S[99]) ?  _0.da(m[_S[99]], _3) as _3 : "0",audio: m.$c(_S[100]) ?  _0.da(m[_S[100]], _3) as _3 : "0",internal_reasoning: m.$c(_S[101]) ?  _0.da(m[_S[101]], _3) as _3 : "0",);}
  _v copyWith({_3? prompt,_w resetPrompt=_F,_3? completion,_w resetCompletion=_F,_3? request,_w resetRequest=_F,_3? image,_w resetImage=_F,_3? web_search,_w resetWeb_search=_F,_3? audio,_w resetAudio=_F,_3? internal_reasoning,_w resetInternal_reasoning=_F,})=>_v(prompt: resetPrompt?"0":(prompt??_H.prompt),completion: resetCompletion?"0":(completion??_H.completion),request: resetRequest?"0":(request??_H.request),image: resetImage?"0":(image??_H.image),web_search: resetWeb_search?"0":(web_search??_H.web_search),audio: resetAudio?"0":(audio??_H.audio),internal_reasoning: resetInternal_reasoning?"0":(internal_reasoning??_H.internal_reasoning),);
}

