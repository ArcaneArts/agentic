// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:agentic/chat/connector/chat_request.dart";import "package:agentic/chat/connector/model.dart";import "package:agentic/chat/connector/result.dart";import "package:agentic/chat/content/content.dart";import "package:agentic/chat/content/content_audio.dart";import "package:agentic/chat/content/content_group.dart";import "package:agentic/chat/content/content_image.dart";import "package:agentic/chat/content/text_content.dart";import "package:agentic/chat/message/message.dart";import "package:agentic/chat/message/message_agent.dart";import "package:agentic/chat/message/message_system.dart";import "package:agentic/chat/message/message_tool.dart";import "package:agentic/chat/message/message_user.dart";import "package:agentic/chat/tool/tool_call.dart";import "package:agentic/chat/tool/tool_schema.dart";import "package:agentic/ingest/chunker.dart";import "package:agentic/util/chat_models.dart";import "package:agentic/util/naga_models.dart";import "package:agentic/util/open_router_models.dart";import "package:agentic/chat/tool/tool.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=ArtifactDataUtil;typedef _2=ArtifactSecurityUtil;typedef _3=ArtifactReflection;typedef _4=ArtifactMirror;typedef _5=Map<String,dynamic>;typedef _6=List<String>;typedef _7=String;typedef _8=dynamic;typedef _9=int;typedef _a=ArtifactModelExporter;typedef _b=ArgumentError;typedef _c=Exception;typedef _d=ChatRequest;typedef _e=ChatModel;typedef _f=ARational;typedef _g=ChatResult;typedef _h=ChatUsage;typedef _i=Content;typedef _j=AudioContent;typedef _k=ContentGroup;typedef _l=ImageContent;typedef _m=TextContent;typedef _n=Message;typedef _o=AgentMessage;typedef _p=SystemMessage;typedef _q=ToolMessage;typedef _r=UserMessage;typedef _s=ToolCall;typedef _t=ToolSchema;typedef _u=IChunk;typedef _v=ChatModelCapabilities;typedef _w=ChatModelCost;typedef _x=NagaModelsListResponse;typedef _y=NagaModel;typedef _z=NagaArchitecture;typedef _10=NagaPricing;typedef _11=OpenRouterModelsListResponse;typedef _12=OpenRouterModel;typedef _13=OpenRouterArchitecture;typedef _14=OpenRouterPricing;typedef _15=ArtifactModelImporter<ChatRequest>;typedef _16=List;typedef _17=Tool;typedef _18=List<Message>;typedef _19=bool;typedef _1a=List<Tool>;typedef _1b=ArtifactModelImporter<ChatModel>;typedef _1c=ArtifactModelImporter<ARational>;typedef _1d=MapEntry;typedef _1e=MapEntry<String, dynamic>;typedef _1f=ArtifactModelImporter<ChatResult>;typedef _1g=ChatFinishReason;typedef _1h=Map<String, dynamic>;typedef _1i=ArtifactModelImporter<ChatUsage>;typedef _1j=ArtifactModelImporter<Content>;typedef _1k=ArtifactModelImporter<AudioContent>;typedef _1l=ArtifactModelImporter<ContentGroup>;typedef _1m=List<Content>;typedef _1n=ArtifactModelImporter<ImageContent>;typedef _1o=ArtifactModelImporter<TextContent>;typedef _1p=ArtifactModelImporter<Message>;typedef _1q=ArtifactModelImporter<AgentMessage>;typedef _1r=List<ToolCall>;typedef _1s=ArtifactModelImporter<SystemMessage>;typedef _1t=ArtifactModelImporter<ToolMessage>;typedef _1u=ArtifactModelImporter<UserMessage>;typedef _1v=ArtifactModelImporter<ToolCall>;typedef _1w=ArtifactModelImporter<ToolSchema>;typedef _1x=ArtifactModelImporter<IChunk>;typedef _1y=List<int>;typedef _1z=ArtifactModelImporter<ChatModelCapabilities>;typedef _20=ChatModelSystemMode;typedef _21=List<Modality>;typedef _22=ArtifactModelImporter<ChatModelCost>;typedef _23=double;typedef _24=ArtifactModelImporter<NagaModelsListResponse>;typedef _25=List<NagaModel>;typedef _26=ArtifactModelImporter<NagaModel>;typedef _27=ArtifactModelImporter<NagaArchitecture>;typedef _28=ArtifactModelImporter<NagaPricing>;typedef _29=ArtifactModelImporter<OpenRouterModelsListResponse>;typedef _2a=List<OpenRouterModel>;typedef _2b=ArtifactModelImporter<OpenRouterModel>;typedef _2c=ArtifactModelImporter<OpenRouterArchitecture>;typedef _2d=ArtifactModelImporter<OpenRouterPricing>;typedef _2e=ArtifactAccessor;typedef _2f=List<dynamic>;
_b __x(_7 c,_7 f)=>_b('${_S[89]}$c.$f');
const _6 _S=['messages','tools','model','systemPrompt','user','responseFormat','ChatRequest','displayName','cost','capabilities','deprecated','ChatModel','ARational','message','realCost','finishReason','metadata','usage','ChatResult','inputTokens','outputTokens','_subclass_Content','AudioContent','ContentGroup','ImageContent','TextContent','audioUrl','base64Audio','contents','imageUrl','base64Image','text','content','_subclass_Message','AgentMessage','SystemMessage','ToolMessage','UserMessage','Message','toolCalls','toolCallId','name','arguments','ToolCall','description','schema','ToolSchema','index','postContent','charStart','charEnd','froms','IChunk','ultraCompatibleMode','systemMode','contextWindow','maxTokenOutput','inputModalities','outputModalities','reasoning','structuredOutput','streaming','seesToolMessages','ChatModelCapabilities','input','output','ChatModelCost','data','context_length','architecture','supported_parameters','pricing','NagaModel','input_modalities','output_modalities','tokenizer','prompt','completion','request','image','web_search','audio','internal_reasoning','canonical_slug','created','OpenRouterModel','modality','OpenRouterArchitecture','agentic','Missing required '];const _2f _V=[<_17>[],false,ChatFinishReason.unspecified,<_7,_8>{},ChatUsage(),<_i>[],<_s>[],<_9>[],<_y>[],200000,<_7>[],NagaPricing(),<_12>[],OpenRouterPricing()];const _19 _T=true;const _19 _F=false;_9 _ = ((){if(!_2e.$i(_S[88])){_2e.$r(_S[88],_2e(isArtifact: $isArtifact,artifactMirror:{},constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $ChatRequest on _d{
  _d get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[0]:messages.$m((e)=> e.toMap()).$l,_S[1]:tools.$m((e)=> _0.ea(e)).$l,_S[2]:model.toMap(),_S[3]:_0.ea(systemPrompt),_S[4]:_0.ea(user),_S[5]:responseFormat?.toMap(),}.$nn;}
  static _15 get from=>_15(fromMap);
  static _d fromMap(_5 r){_;_5 m=r.$nn;return _d(messages: m.$c(_S[0])? (m[_S[0]] as _16).$m((e)=>$Message.fromMap((e) as Map<String, dynamic>)).$l:throw __x(_S[6],_S[0]),tools: m.$c(_S[1]) ?  (m[_S[1]] as _16).$m((e)=> _0.da(e, _17) as _17).$l : _V[0],model: m.$c(_S[2])?$ChatModel.fromMap((m[_S[2]]) as Map<String, dynamic>):throw __x(_S[6],_S[2]),systemPrompt: m.$c(_S[3]) ?  _0.da(m[_S[3]], _7) as _7? : null,user: m.$c(_S[4]) ?  _0.da(m[_S[4]], _7) as _7? : null,responseFormat: m.$c(_S[5]) ? $ToolSchema.fromMap((m[_S[5]]) as Map<String, dynamic>) : null,);}
  _d copyWith({_18? messages,_18? appendMessages,_18? removeMessages,_1a? tools,_19 resetTools=_F,_1a? appendTools,_1a? removeTools,_e? model,_7? systemPrompt,_19 deleteSystemPrompt=_F,_7? user,_19 deleteUser=_F,_t? responseFormat,_19 deleteResponseFormat=_F,})=>_d(messages: (messages??_H.messages).$u(appendMessages,removeMessages),tools: ((resetTools?_V[0]:(tools??_H.tools)) as _1a).$u(appendTools,removeTools),model: model??_H.model,systemPrompt: deleteSystemPrompt?null:(systemPrompt??_H.systemPrompt),user: deleteUser?null:(user??_H.user),responseFormat: deleteResponseFormat?null:(responseFormat??_H.responseFormat),);
  static _d get newInstance=>_d(messages: [],model: $ChatModel.newInstance,);
}
extension $ChatModel on _e{
  _e get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{'id':_0.ea(id),_S[7]:_0.ea(displayName),_S[8]:cost.toMap(),_S[9]:capabilities.toMap(),_S[10]:_0.ea(deprecated),}.$nn;}
  static _1b get from=>_1b(fromMap);
  static _e fromMap(_5 r){_;_5 m=r.$nn;return _e(id: m.$c('id')? _0.da(m['id'], _7) as _7:throw __x(_S[11],'id'),displayName: m.$c(_S[7]) ?  _0.da(m[_S[7]], _7) as _7? : null,cost: m.$c(_S[8])?$ChatModelCost.fromMap((m[_S[8]]) as Map<String, dynamic>):throw __x(_S[11],_S[8]),capabilities: m.$c(_S[9])?$ChatModelCapabilities.fromMap((m[_S[9]]) as Map<String, dynamic>):throw __x(_S[11],_S[9]),deprecated: m.$c(_S[10]) ?  _0.da(m[_S[10]], _19) as _19 : _V[1],);}
  _e copyWith({_7? id,_7? displayName,_19 deleteDisplayName=_F,_w? cost,_v? capabilities,_19? deprecated,_19 resetDeprecated=_F,})=>_e(id: id??_H.id,displayName: deleteDisplayName?null:(displayName??_H.displayName),cost: cost??_H.cost,capabilities: capabilities??_H.capabilities,deprecated: resetDeprecated?_V[1]:(deprecated??_H.deprecated),);
  static _e get newInstance=>_e(id: '',cost: $ChatModelCost.newInstance,capabilities: $ChatModelCapabilities.newInstance,);
}
extension $ARational on _f{
  _f get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{'n':_0.ea(n),'d':_0.ea(d),}.$nn;}
  static _1c get from=>_1c(fromMap);
  static _f fromMap(_5 r){_;_5 m=r.$nn;return _f(n: m.$c('n')? _0.da(m['n'], _7) as _7:throw __x(_S[12],'n'),d: m.$c('d') ?  _0.da(m['d'], _7) as _7 : "1",);}
  _f copyWith({_7? n,_7? d,_19 resetD=_F,})=>_f(n: n??_H.n,d: resetD?"1":(d??_H.d),);
  static _f get newInstance=>_f(n: '',);
}
extension $ChatResult on _g{
  _g get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[13]:message.toMap(),_S[14]:realCost.toMap(),_S[15]:finishReason.name,_S[16]:metadata.$m((k,v)=>_1d(k,v)),_S[17]:usage.toMap(),}.$nn;}
  static _1f get from=>_1f(fromMap);
  static _g fromMap(_5 r){_;_5 m=r.$nn;return _g(message: m.$c(_S[13])?$AgentMessage.fromMap((m[_S[13]]) as Map<String, dynamic>):throw __x(_S[18],_S[13]),realCost: m.$c(_S[14])?$ARational.fromMap((m[_S[14]]) as Map<String, dynamic>):throw __x(_S[18],_S[14]),finishReason: m.$c(_S[15]) ? _1.e(ChatFinishReason.values, m[_S[15]]) as ChatFinishReason : _V[2],metadata: m.$c(_S[16]) ?  _1.fe((m[_S[16]] as Map).$e.$m((e)=>_1e(e.key,e.value))) : _V[3],usage: m.$c(_S[17]) ? $ChatUsage.fromMap((m[_S[17]]) as Map<String, dynamic>) : _V[4],);}
  _g copyWith({_o? message,_f? realCost,_1g? finishReason,_19 resetFinishReason=_F,_1h? metadata,_19 resetMetadata=_F,_h? usage,_19 resetUsage=_F,})=>_g(message: message??_H.message,realCost: realCost??_H.realCost,finishReason: resetFinishReason?_V[2]:(finishReason??_H.finishReason),metadata: resetMetadata?_V[3]:(metadata??_H.metadata),usage: resetUsage?_V[4]:(usage??_H.usage),);
  static _g get newInstance=>_g(message: $AgentMessage.newInstance,realCost: $ARational.newInstance,);
}
extension $ChatUsage on _h{
  _h get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[19]:_0.ea(inputTokens),_S[20]:_0.ea(outputTokens),}.$nn;}
  static _1i get from=>_1i(fromMap);
  static _h fromMap(_5 r){_;_5 m=r.$nn;return _h(inputTokens: m.$c(_S[19]) ?  _0.da(m[_S[19]], _9) as _9 : 0,outputTokens: m.$c(_S[20]) ?  _0.da(m[_S[20]], _9) as _9 : 0,);}
  _h copyWith({_9? inputTokens,_19 resetInputTokens=_F,_9? deltaInputTokens,_9? outputTokens,_19 resetOutputTokens=_F,_9? deltaOutputTokens,})=>_h(inputTokens: deltaInputTokens!=null?(inputTokens??_H.inputTokens)+deltaInputTokens:resetInputTokens?0:(inputTokens??_H.inputTokens),outputTokens: deltaOutputTokens!=null?(outputTokens??_H.outputTokens)+deltaOutputTokens:resetOutputTokens?0:(outputTokens??_H.outputTokens),);
  static _h get newInstance=>_h();
}
extension $Content on _i{
  _i get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;if (_H is _j){return (_H as _j).toMap();}if (_H is _k){return (_H as _k).toMap();}if (_H is _l){return (_H as _l).toMap();}if (_H is _m){return (_H as _m).toMap();}return<_7,_8>{}.$nn;}
  static _1j get from=>_1j(fromMap);
  static _i fromMap(_5 r){_;_5 m=r.$nn;if(m.$c(_S[21])){String _I=m[_S[21]] as _7;if(_I==_S[22]){return $AudioContent.fromMap(m);}if(_I==_S[23]){return $ContentGroup.fromMap(m);}if(_I==_S[24]){return $ImageContent.fromMap(m);}if(_I==_S[25]){return $TextContent.fromMap(m);}}return _i();}
  static _i get newInstance=>_i();
}
extension $AudioContent on _j{
  _j get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[21]: 'AudioContent',_S[26]:_0.ea(audioUrl),_S[27]:_0.ea(base64Audio),}.$nn;}
  static _1k get from=>_1k(fromMap);
  static _j fromMap(_5 r){_;_5 m=r.$nn;return _j(audioUrl: m.$c(_S[26]) ?  _0.da(m[_S[26]], _7) as _7? : null,base64Audio: m.$c(_S[27]) ?  _0.da(m[_S[27]], _7) as _7? : null,);}
  _j copyWith({_7? audioUrl,_19 deleteAudioUrl=_F,_7? base64Audio,_19 deleteBase64Audio=_F,})=>_j(audioUrl: deleteAudioUrl?null:(audioUrl??_H.audioUrl),base64Audio: deleteBase64Audio?null:(base64Audio??_H.base64Audio),);
  static _j get newInstance=>_j();
}
extension $ContentGroup on _k{
  _k get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[21]: 'ContentGroup',_S[28]:contents.$m((e)=> e.toMap()).$l,}.$nn;}
  static _1l get from=>_1l(fromMap);
  static _k fromMap(_5 r){_;_5 m=r.$nn;return _k(contents: m.$c(_S[28]) ?  (m[_S[28]] as _16).$m((e)=>$Content.fromMap((e) as _1h)).$l : _V[5],);}
  _k copyWith({_1m? contents,_19 resetContents=_F,_1m? appendContents,_1m? removeContents,})=>_k(contents: ((resetContents?_V[5]:(contents??_H.contents)) as _1m).$u(appendContents,removeContents),);
  static _k get newInstance=>_k();
}
extension $ImageContent on _l{
  _l get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[21]: 'ImageContent',_S[29]:_0.ea(imageUrl),_S[30]:_0.ea(base64Image),}.$nn;}
  static _1n get from=>_1n(fromMap);
  static _l fromMap(_5 r){_;_5 m=r.$nn;return _l(imageUrl: m.$c(_S[29]) ?  _0.da(m[_S[29]], _7) as _7? : null,base64Image: m.$c(_S[30]) ?  _0.da(m[_S[30]], _7) as _7? : null,);}
  _l copyWith({_7? imageUrl,_19 deleteImageUrl=_F,_7? base64Image,_19 deleteBase64Image=_F,})=>_l(imageUrl: deleteImageUrl?null:(imageUrl??_H.imageUrl),base64Image: deleteBase64Image?null:(base64Image??_H.base64Image),);
  static _l get newInstance=>_l();
}
extension $TextContent on _m{
  _m get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[21]: 'TextContent',_S[31]:_0.ea(text),}.$nn;}
  static _1o get from=>_1o(fromMap);
  static _m fromMap(_5 r){_;_5 m=r.$nn;return _m(text: m.$c(_S[31]) ?  _0.da(m[_S[31]], _7) as _7 : "",);}
  _m copyWith({_7? text,_19 resetText=_F,})=>_m(text: resetText?"":(text??_H.text),);
  static _m get newInstance=>_m();
}
extension $Message on _n{
  _n get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;if (_H is _o){return (_H as _o).toMap();}if (_H is _p){return (_H as _p).toMap();}if (_H is _q){return (_H as _q).toMap();}if (_H is _r){return (_H as _r).toMap();}return<_7,_8>{_S[32]:content.toMap(),}.$nn;}
  static _1p get from=>_1p(fromMap);
  static _n fromMap(_5 r){_;_5 m=r.$nn;if(m.$c(_S[33])){String _I=m[_S[33]] as _7;if(_I==_S[34]){return $AgentMessage.fromMap(m);}if(_I==_S[35]){return $SystemMessage.fromMap(m);}if(_I==_S[36]){return $ToolMessage.fromMap(m);}if(_I==_S[37]){return $UserMessage.fromMap(m);}}return _n(content: m.$c(_S[32])?$Content.fromMap((m[_S[32]]) as _1h):throw __x(_S[38],_S[32]),);}
  _n copyWith({_i? content,}){if (_H is _o){return (_H as _o).copyWith(content: content,);}if (_H is _p){return (_H as _p).copyWith(content: content,);}if (_H is _q){return (_H as _q).copyWith(content: content,);}if (_H is _r){return (_H as _r).copyWith(content: content,);}return _n(content: content??_H.content,);}
  static _n get newInstance=>_n(content: $Content.newInstance,);
}
extension $AgentMessage on _o{
  _o get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[33]: 'AgentMessage',_S[32]:content.toMap(),_S[39]:toolCalls.$m((e)=> e.toMap()).$l,}.$nn;}
  static _1q get from=>_1q(fromMap);
  static _o fromMap(_5 r){_;_5 m=r.$nn;return _o(content: m.$c(_S[32])?$Content.fromMap((m[_S[32]]) as _1h):throw __x(_S[34],_S[32]),toolCalls: m.$c(_S[39]) ?  (m[_S[39]] as _16).$m((e)=>$ToolCall.fromMap((e) as _1h)).$l : _V[6],);}
  _o copyWith({_i? content,_1r? toolCalls,_19 resetToolCalls=_F,_1r? appendToolCalls,_1r? removeToolCalls,})=>_o(content: content??_H.content,toolCalls: ((resetToolCalls?_V[6]:(toolCalls??_H.toolCalls)) as _1r).$u(appendToolCalls,removeToolCalls),);
  static _o get newInstance=>_o(content: $Content.newInstance,);
}
extension $SystemMessage on _p{
  _p get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[33]: 'SystemMessage',_S[32]:content.toMap(),}.$nn;}
  static _1s get from=>_1s(fromMap);
  static _p fromMap(_5 r){_;_5 m=r.$nn;return _p(content: m.$c(_S[32])?$Content.fromMap((m[_S[32]]) as _1h):throw __x(_S[35],_S[32]),);}
  _p copyWith({_i? content,})=>_p(content: content??_H.content,);
  static _p get newInstance=>_p(content: $Content.newInstance,);
}
extension $ToolMessage on _q{
  _q get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[33]: 'ToolMessage',_S[32]:content.toMap(),_S[40]:_0.ea(toolCallId),}.$nn;}
  static _1t get from=>_1t(fromMap);
  static _q fromMap(_5 r){_;_5 m=r.$nn;return _q(content: m.$c(_S[32])?$Content.fromMap((m[_S[32]]) as _1h):throw __x(_S[36],_S[32]),toolCallId: m.$c(_S[40])? _0.da(m[_S[40]], _7) as _7:throw __x(_S[36],_S[40]),);}
  _q copyWith({_i? content,_7? toolCallId,})=>_q(content: content??_H.content,toolCallId: toolCallId??_H.toolCallId,);
  static _q get newInstance=>_q(content: $Content.newInstance,toolCallId: '',);
}
extension $UserMessage on _r{
  _r get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[33]: 'UserMessage',_S[32]:content.toMap(),}.$nn;}
  static _1u get from=>_1u(fromMap);
  static _r fromMap(_5 r){_;_5 m=r.$nn;return _r(content: m.$c(_S[32])?$Content.fromMap((m[_S[32]]) as _1h):throw __x(_S[37],_S[32]),);}
  _r copyWith({_i? content,})=>_r(content: content??_H.content,);
  static _r get newInstance=>_r(content: $Content.newInstance,);
}
extension $ToolCall on _s{
  _s get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{'id':_0.ea(id),_S[41]:_0.ea(name),_S[42]:_0.ea(arguments),}.$nn;}
  static _1v get from=>_1v(fromMap);
  static _s fromMap(_5 r){_;_5 m=r.$nn;return _s(id: m.$c('id')? _0.da(m['id'], _7) as _7:throw __x(_S[43],'id'),name: m.$c(_S[41])? _0.da(m[_S[41]], _7) as _7:throw __x(_S[43],_S[41]),arguments: m.$c(_S[42])? _0.da(m[_S[42]], _7) as _7:throw __x(_S[43],_S[42]),);}
  _s copyWith({_7? id,_7? name,_7? arguments,})=>_s(id: id??_H.id,name: name??_H.name,arguments: arguments??_H.arguments,);
  static _s get newInstance=>_s(id: '',name: '',arguments: '',);
}
extension $ToolSchema on _t{
  _t get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[41]:_0.ea(name),_S[44]:_0.ea(description),_S[45]:schema.$m((k,v)=>_1d(k,v)),}.$nn;}
  static _1w get from=>_1w(fromMap);
  static _t fromMap(_5 r){_;_5 m=r.$nn;return _t(name: m.$c(_S[41])? _0.da(m[_S[41]], _7) as _7:throw __x(_S[46],_S[41]),description: m.$c(_S[44])? _0.da(m[_S[44]], _7) as _7:throw __x(_S[46],_S[44]),schema: m.$c(_S[45])? _1.fe((m[_S[45]] as Map).$e.$m((e)=>_1e(e.key,e.value))):throw __x(_S[46],_S[45]),);}
  _t copyWith({_7? name,_7? description,_1h? schema,})=>_t(name: name??_H.name,description: description??_H.description,schema: schema??_H.schema,);
  static _t get newInstance=>_t(name: '',description: '',schema: {},);
}
extension $IChunk on _u{
  _u get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[47]:_0.ea(index),_S[32]:_0.ea(content),_S[48]:_0.ea(postContent),_S[49]:_0.ea(charStart),_S[50]:_0.ea(charEnd),'lod':_0.ea(lod),_S[51]:froms.$m((e)=> _0.ea(e)).$l,}.$nn;}
  static _1x get from=>_1x(fromMap);
  static _u fromMap(_5 r){_;_5 m=r.$nn;return _u(index: m.$c(_S[47])? _0.da(m[_S[47]], _9) as _9:throw __x(_S[52],_S[47]),content: m.$c(_S[32])? _0.da(m[_S[32]], _7) as _7:throw __x(_S[52],_S[32]),postContent: m.$c(_S[48]) ?  _0.da(m[_S[48]], _7) as _7 : "",charStart: m.$c(_S[49]) ?  _0.da(m[_S[49]], _9) as _9 : 0,charEnd: m.$c(_S[50]) ?  _0.da(m[_S[50]], _9) as _9 : 0,lod: m.$c('lod') ?  _0.da(m['lod'], _9) as _9 : 0,froms: m.$c(_S[51]) ?  (m[_S[51]] as _16).$m((e)=> _0.da(e, _9) as _9).$l : _V[7],);}
  _u copyWith({_9? index,_9? deltaIndex,_7? content,_7? postContent,_19 resetPostContent=_F,_9? charStart,_19 resetCharStart=_F,_9? deltaCharStart,_9? charEnd,_19 resetCharEnd=_F,_9? deltaCharEnd,_9? lod,_19 resetLod=_F,_9? deltaLod,_1y? froms,_19 resetFroms=_F,_1y? appendFroms,_1y? removeFroms,})=>_u(index: deltaIndex!=null?(index??_H.index)+deltaIndex:index??_H.index,content: content??_H.content,postContent: resetPostContent?"":(postContent??_H.postContent),charStart: deltaCharStart!=null?(charStart??_H.charStart)+deltaCharStart:resetCharStart?0:(charStart??_H.charStart),charEnd: deltaCharEnd!=null?(charEnd??_H.charEnd)+deltaCharEnd:resetCharEnd?0:(charEnd??_H.charEnd),lod: deltaLod!=null?(lod??_H.lod)+deltaLod:resetLod?0:(lod??_H.lod),froms: ((resetFroms?_V[7]:(froms??_H.froms)) as _1y).$u(appendFroms,removeFroms),);
  static _u get newInstance=>_u(index: 0,content: '',);
}
extension $ChatModelCapabilities on _v{
  _v get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[1]:_0.ea(tools),_S[53]:_0.ea(ultraCompatibleMode),_S[54]:systemMode.name,_S[55]:_0.ea(contextWindow),_S[56]:_0.ea(maxTokenOutput),_S[57]:inputModalities.$m((e)=> e.name).$l,_S[58]:outputModalities.$m((e)=> e.name).$l,_S[59]:_0.ea(reasoning),_S[60]:_0.ea(structuredOutput),_S[61]:_0.ea(streaming),_S[62]:_0.ea(seesToolMessages),}.$nn;}
  static _1z get from=>_1z(fromMap);
  static _v fromMap(_5 r){_;_5 m=r.$nn;return _v(tools: m.$c(_S[1])? _0.da(m[_S[1]], _19) as _19:throw __x(_S[63],_S[1]),ultraCompatibleMode: m.$c(_S[53])? _0.da(m[_S[53]], _19) as _19:throw __x(_S[63],_S[53]),systemMode: m.$c(_S[54])?_1.e(ChatModelSystemMode.values, m[_S[54]]) as ChatModelSystemMode:throw __x(_S[63],_S[54]),contextWindow: m.$c(_S[55])? _0.da(m[_S[55]], _9) as _9:throw __x(_S[63],_S[55]),maxTokenOutput: m.$c(_S[56])? _0.da(m[_S[56]], _9) as _9:throw __x(_S[63],_S[56]),inputModalities: m.$c(_S[57])? (m[_S[57]] as _16).$m((e)=>_1.e(Modality.values, e) as Modality).$l:throw __x(_S[63],_S[57]),outputModalities: m.$c(_S[58])? (m[_S[58]] as _16).$m((e)=>_1.e(Modality.values, e) as Modality).$l:throw __x(_S[63],_S[58]),reasoning: m.$c(_S[59])? _0.da(m[_S[59]], _19) as _19:throw __x(_S[63],_S[59]),structuredOutput: m.$c(_S[60])? _0.da(m[_S[60]], _19) as _19:throw __x(_S[63],_S[60]),streaming: m.$c(_S[61])? _0.da(m[_S[61]], _19) as _19:throw __x(_S[63],_S[61]),seesToolMessages: m.$c(_S[62])? _0.da(m[_S[62]], _19) as _19:throw __x(_S[63],_S[62]),);}
  _v copyWith({_19? tools,_19? ultraCompatibleMode,_20? systemMode,_9? contextWindow,_9? deltaContextWindow,_9? maxTokenOutput,_9? deltaMaxTokenOutput,_21? inputModalities,_21? appendInputModalities,_21? removeInputModalities,_21? outputModalities,_21? appendOutputModalities,_21? removeOutputModalities,_19? reasoning,_19? structuredOutput,_19? streaming,_19? seesToolMessages,})=>_v(tools: tools??_H.tools,ultraCompatibleMode: ultraCompatibleMode??_H.ultraCompatibleMode,systemMode: systemMode??_H.systemMode,contextWindow: deltaContextWindow!=null?(contextWindow??_H.contextWindow)+deltaContextWindow:contextWindow??_H.contextWindow,maxTokenOutput: deltaMaxTokenOutput!=null?(maxTokenOutput??_H.maxTokenOutput)+deltaMaxTokenOutput:maxTokenOutput??_H.maxTokenOutput,inputModalities: (inputModalities??_H.inputModalities).$u(appendInputModalities,removeInputModalities),outputModalities: (outputModalities??_H.outputModalities).$u(appendOutputModalities,removeOutputModalities),reasoning: reasoning??_H.reasoning,structuredOutput: structuredOutput??_H.structuredOutput,streaming: streaming??_H.streaming,seesToolMessages: seesToolMessages??_H.seesToolMessages,);
  static _v get newInstance=>_v(tools: _F,ultraCompatibleMode: _F,systemMode: _20.values.first,contextWindow: 0,maxTokenOutput: 0,inputModalities: [],outputModalities: [],reasoning: _F,structuredOutput: _F,streaming: _F,seesToolMessages: _F,);
}
extension $ChatModelCost on _w{
  _w get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[64]:_0.ea(input),_S[65]:_0.ea(output),}.$nn;}
  static _22 get from=>_22(fromMap);
  static _w fromMap(_5 r){_;_5 m=r.$nn;return _w(input: m.$c(_S[64])? _0.da(m[_S[64]], _23) as _23:throw __x(_S[66],_S[64]),output: m.$c(_S[65])? _0.da(m[_S[65]], _23) as _23:throw __x(_S[66],_S[65]),);}
  _w copyWith({_23? input,_23? deltaInput,_23? output,_23? deltaOutput,})=>_w(input: deltaInput!=null?(input??_H.input)+deltaInput:input??_H.input,output: deltaOutput!=null?(output??_H.output)+deltaOutput:output??_H.output,);
  static _w get newInstance=>_w(input: 0,output: 0,);
}
extension $NagaModelsListResponse on _x{
  _x get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[67]:data.$m((e)=> e.toMap()).$l,}.$nn;}
  static _24 get from=>_24(fromMap);
  static _x fromMap(_5 r){_;_5 m=r.$nn;return _x(data: m.$c(_S[67]) ?  (m[_S[67]] as _16).$m((e)=>$NagaModel.fromMap((e) as _1h)).$l : _V[8],);}
  _x copyWith({_25? data,_19 resetData=_F,_25? appendData,_25? removeData,})=>_x(data: ((resetData?_V[8]:(data??_H.data)) as _25).$u(appendData,removeData),);
  static _x get newInstance=>_x();
}
extension $NagaModel on _y{
  _y get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{'id':_0.ea(id),_S[68]:_0.ea(context_length),_S[69]:architecture.toMap(),_S[70]:supported_parameters.$m((e)=> _0.ea(e)).$l,_S[71]:pricing.toMap(),}.$nn;}
  static _26 get from=>_26(fromMap);
  static _y fromMap(_5 r){_;_5 m=r.$nn;return _y(id: m.$c('id')? _0.da(m['id'], _7) as _7:throw __x(_S[72],'id'),context_length: m.$c(_S[68]) ?  _0.da(m[_S[68]], _9) as _9 : _V[9],architecture: m.$c(_S[69])?$NagaArchitecture.fromMap((m[_S[69]]) as _1h):throw __x(_S[72],_S[69]),supported_parameters: m.$c(_S[70]) ?  (m[_S[70]] as _16).$m((e)=> _0.da(e, _7) as _7).$l : _V[10],pricing: m.$c(_S[71]) ? $NagaPricing.fromMap((m[_S[71]]) as _1h) : _V[11],);}
  _y copyWith({_7? id,_9? context_length,_19 resetContext_length=_F,_9? deltaContext_length,_z? architecture,_6? supported_parameters,_19 resetSupported_parameters=_F,_6? appendSupported_parameters,_6? removeSupported_parameters,_10? pricing,_19 resetPricing=_F,})=>_y(id: id??_H.id,context_length: deltaContext_length!=null?(context_length??_H.context_length)+deltaContext_length:resetContext_length?_V[9]:(context_length??_H.context_length),architecture: architecture??_H.architecture,supported_parameters: ((resetSupported_parameters?_V[10]:(supported_parameters??_H.supported_parameters)) as _6).$u(appendSupported_parameters,removeSupported_parameters),pricing: resetPricing?_V[11]:(pricing??_H.pricing),);
  static _y get newInstance=>_y(id: '',architecture: $NagaArchitecture.newInstance,);
}
extension $NagaArchitecture on _z{
  _z get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[73]:input_modalities.$m((e)=> _0.ea(e)).$l,_S[74]:output_modalities.$m((e)=> _0.ea(e)).$l,_S[75]:_0.ea(tokenizer),}.$nn;}
  static _27 get from=>_27(fromMap);
  static _z fromMap(_5 r){_;_5 m=r.$nn;return _z(input_modalities: m.$c(_S[73]) ?  (m[_S[73]] as _16).$m((e)=> _0.da(e, _7) as _7).$l : _V[10],output_modalities: m.$c(_S[74]) ?  (m[_S[74]] as _16).$m((e)=> _0.da(e, _7) as _7).$l : _V[10],tokenizer: m.$c(_S[75]) ?  _0.da(m[_S[75]], _7) as _7? : null,);}
  _z copyWith({_6? input_modalities,_19 resetInput_modalities=_F,_6? appendInput_modalities,_6? removeInput_modalities,_6? output_modalities,_19 resetOutput_modalities=_F,_6? appendOutput_modalities,_6? removeOutput_modalities,_7? tokenizer,_19 deleteTokenizer=_F,})=>_z(input_modalities: ((resetInput_modalities?_V[10]:(input_modalities??_H.input_modalities)) as _6).$u(appendInput_modalities,removeInput_modalities),output_modalities: ((resetOutput_modalities?_V[10]:(output_modalities??_H.output_modalities)) as _6).$u(appendOutput_modalities,removeOutput_modalities),tokenizer: deleteTokenizer?null:(tokenizer??_H.tokenizer),);
  static _z get newInstance=>_z();
}
extension $NagaPricing on _10{
  _10 get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[76]:_0.ea(prompt),_S[77]:_0.ea(completion),_S[78]:_0.ea(request),_S[79]:_0.ea(image),_S[80]:_0.ea(web_search),_S[81]:_0.ea(audio),_S[82]:_0.ea(internal_reasoning),}.$nn;}
  static _28 get from=>_28(fromMap);
  static _10 fromMap(_5 r){_;_5 m=r.$nn;return _10(prompt: m.$c(_S[76]) ?  _0.da(m[_S[76]], _7) as _7 : "0",completion: m.$c(_S[77]) ?  _0.da(m[_S[77]], _7) as _7 : "0",request: m.$c(_S[78]) ?  _0.da(m[_S[78]], _7) as _7 : "0",image: m.$c(_S[79]) ?  _0.da(m[_S[79]], _7) as _7 : "0",web_search: m.$c(_S[80]) ?  _0.da(m[_S[80]], _7) as _7 : "0",audio: m.$c(_S[81]) ?  _0.da(m[_S[81]], _7) as _7 : "0",internal_reasoning: m.$c(_S[82]) ?  _0.da(m[_S[82]], _7) as _7 : "0",);}
  _10 copyWith({_7? prompt,_19 resetPrompt=_F,_7? completion,_19 resetCompletion=_F,_7? request,_19 resetRequest=_F,_7? image,_19 resetImage=_F,_7? web_search,_19 resetWeb_search=_F,_7? audio,_19 resetAudio=_F,_7? internal_reasoning,_19 resetInternal_reasoning=_F,})=>_10(prompt: resetPrompt?"0":(prompt??_H.prompt),completion: resetCompletion?"0":(completion??_H.completion),request: resetRequest?"0":(request??_H.request),image: resetImage?"0":(image??_H.image),web_search: resetWeb_search?"0":(web_search??_H.web_search),audio: resetAudio?"0":(audio??_H.audio),internal_reasoning: resetInternal_reasoning?"0":(internal_reasoning??_H.internal_reasoning),);
  static _10 get newInstance=>_10();
}
extension $OpenRouterModelsListResponse on _11{
  _11 get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[67]:data.$m((e)=> e.toMap()).$l,}.$nn;}
  static _29 get from=>_29(fromMap);
  static _11 fromMap(_5 r){_;_5 m=r.$nn;return _11(data: m.$c(_S[67]) ?  (m[_S[67]] as _16).$m((e)=>$OpenRouterModel.fromMap((e) as _1h)).$l : _V[12],);}
  _11 copyWith({_2a? data,_19 resetData=_F,_2a? appendData,_2a? removeData,})=>_11(data: ((resetData?_V[12]:(data??_H.data)) as _2a).$u(appendData,removeData),);
  static _11 get newInstance=>_11();
}
extension $OpenRouterModel on _12{
  _12 get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{'id':_0.ea(id),_S[83]:_0.ea(canonical_slug),_S[41]:_0.ea(name),_S[84]:_0.ea(created),_S[68]:_0.ea(context_length),_S[69]:architecture.toMap(),_S[70]:supported_parameters.$m((e)=> _0.ea(e)).$l,_S[71]:pricing.toMap(),}.$nn;}
  static _2b get from=>_2b(fromMap);
  static _12 fromMap(_5 r){_;_5 m=r.$nn;return _12(id: m.$c('id')? _0.da(m['id'], _7) as _7:throw __x(_S[85],'id'),canonical_slug: m.$c(_S[83])? _0.da(m[_S[83]], _7) as _7:throw __x(_S[85],_S[83]),name: m.$c(_S[41])? _0.da(m[_S[41]], _7) as _7:throw __x(_S[85],_S[41]),created: m.$c(_S[84])? _0.da(m[_S[84]], _9) as _9:throw __x(_S[85],_S[84]),context_length: m.$c(_S[68])? _0.da(m[_S[68]], _9) as _9:throw __x(_S[85],_S[68]),architecture: m.$c(_S[69])?$OpenRouterArchitecture.fromMap((m[_S[69]]) as _1h):throw __x(_S[85],_S[69]),supported_parameters: m.$c(_S[70]) ?  (m[_S[70]] as _16).$m((e)=> _0.da(e, _7) as _7).$l : _V[10],pricing: m.$c(_S[71]) ? $OpenRouterPricing.fromMap((m[_S[71]]) as _1h) : _V[13],);}
  _12 copyWith({_7? id,_7? canonical_slug,_7? name,_9? created,_9? deltaCreated,_9? context_length,_9? deltaContext_length,_13? architecture,_6? supported_parameters,_19 resetSupported_parameters=_F,_6? appendSupported_parameters,_6? removeSupported_parameters,_14? pricing,_19 resetPricing=_F,})=>_12(id: id??_H.id,canonical_slug: canonical_slug??_H.canonical_slug,name: name??_H.name,created: deltaCreated!=null?(created??_H.created)+deltaCreated:created??_H.created,context_length: deltaContext_length!=null?(context_length??_H.context_length)+deltaContext_length:context_length??_H.context_length,architecture: architecture??_H.architecture,supported_parameters: ((resetSupported_parameters?_V[10]:(supported_parameters??_H.supported_parameters)) as _6).$u(appendSupported_parameters,removeSupported_parameters),pricing: resetPricing?_V[13]:(pricing??_H.pricing),);
  static _12 get newInstance=>_12(id: '',canonical_slug: '',name: '',created: 0,context_length: 0,architecture: $OpenRouterArchitecture.newInstance,);
}
extension $OpenRouterArchitecture on _13{
  _13 get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[86]:_0.ea(modality),_S[73]:input_modalities.$m((e)=> _0.ea(e)).$l,_S[74]:output_modalities.$m((e)=> _0.ea(e)).$l,_S[75]:_0.ea(tokenizer),}.$nn;}
  static _2c get from=>_2c(fromMap);
  static _13 fromMap(_5 r){_;_5 m=r.$nn;return _13(modality: m.$c(_S[86])? _0.da(m[_S[86]], _7) as _7:throw __x(_S[87],_S[86]),input_modalities: m.$c(_S[73]) ?  (m[_S[73]] as _16).$m((e)=> _0.da(e, _7) as _7).$l : _V[10],output_modalities: m.$c(_S[74]) ?  (m[_S[74]] as _16).$m((e)=> _0.da(e, _7) as _7).$l : _V[10],tokenizer: m.$c(_S[75])? _0.da(m[_S[75]], _7) as _7:throw __x(_S[87],_S[75]),);}
  _13 copyWith({_7? modality,_6? input_modalities,_19 resetInput_modalities=_F,_6? appendInput_modalities,_6? removeInput_modalities,_6? output_modalities,_19 resetOutput_modalities=_F,_6? appendOutput_modalities,_6? removeOutput_modalities,_7? tokenizer,})=>_13(modality: modality??_H.modality,input_modalities: ((resetInput_modalities?_V[10]:(input_modalities??_H.input_modalities)) as _6).$u(appendInput_modalities,removeInput_modalities),output_modalities: ((resetOutput_modalities?_V[10]:(output_modalities??_H.output_modalities)) as _6).$u(appendOutput_modalities,removeOutput_modalities),tokenizer: tokenizer??_H.tokenizer,);
  static _13 get newInstance=>_13(modality: '',tokenizer: '',);
}
extension $OpenRouterPricing on _14{
  _14 get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[76]:_0.ea(prompt),_S[77]:_0.ea(completion),_S[78]:_0.ea(request),_S[79]:_0.ea(image),_S[80]:_0.ea(web_search),_S[81]:_0.ea(audio),_S[82]:_0.ea(internal_reasoning),}.$nn;}
  static _2d get from=>_2d(fromMap);
  static _14 fromMap(_5 r){_;_5 m=r.$nn;return _14(prompt: m.$c(_S[76]) ?  _0.da(m[_S[76]], _7) as _7 : "0",completion: m.$c(_S[77]) ?  _0.da(m[_S[77]], _7) as _7 : "0",request: m.$c(_S[78]) ?  _0.da(m[_S[78]], _7) as _7 : "0",image: m.$c(_S[79]) ?  _0.da(m[_S[79]], _7) as _7 : "0",web_search: m.$c(_S[80]) ?  _0.da(m[_S[80]], _7) as _7 : "0",audio: m.$c(_S[81]) ?  _0.da(m[_S[81]], _7) as _7 : "0",internal_reasoning: m.$c(_S[82]) ?  _0.da(m[_S[82]], _7) as _7 : "0",);}
  _14 copyWith({_7? prompt,_19 resetPrompt=_F,_7? completion,_19 resetCompletion=_F,_7? request,_19 resetRequest=_F,_7? image,_19 resetImage=_F,_7? web_search,_19 resetWeb_search=_F,_7? audio,_19 resetAudio=_F,_7? internal_reasoning,_19 resetInternal_reasoning=_F,})=>_14(prompt: resetPrompt?"0":(prompt??_H.prompt),completion: resetCompletion?"0":(completion??_H.completion),request: resetRequest?"0":(request??_H.request),image: resetImage?"0":(image??_H.image),web_search: resetWeb_search?"0":(web_search??_H.web_search),audio: resetAudio?"0":(audio??_H.audio),internal_reasoning: resetInternal_reasoning?"0":(internal_reasoning??_H.internal_reasoning),);
  static _14 get newInstance=>_14();
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _d ||v == _e ||v == _f ||v == _g ||v == _h ||v == _i ||v == _j ||v == _k ||v == _l ||v == _m ||v == _n ||v == _o ||v == _p ||v == _q ||v == _r ||v == _s ||v == _t ||v == _u ||v == _v ||v == _w ||v == _x ||v == _y ||v == _z ||v == _10 ||v == _11 ||v == _12 ||v == _13 ||v == _14 ;
T $constructArtifact<T>() => T==_d ?$ChatRequest.newInstance as T :T==_e ?$ChatModel.newInstance as T :T==_f ?$ARational.newInstance as T :T==_g ?$ChatResult.newInstance as T :T==_h ?$ChatUsage.newInstance as T :T==_i ?$Content.newInstance as T :T==_j ?$AudioContent.newInstance as T :T==_k ?$ContentGroup.newInstance as T :T==_l ?$ImageContent.newInstance as T :T==_m ?$TextContent.newInstance as T :T==_n ?$Message.newInstance as T :T==_o ?$AgentMessage.newInstance as T :T==_p ?$SystemMessage.newInstance as T :T==_q ?$ToolMessage.newInstance as T :T==_r ?$UserMessage.newInstance as T :T==_s ?$ToolCall.newInstance as T :T==_t ?$ToolSchema.newInstance as T :T==_u ?$IChunk.newInstance as T :T==_v ?$ChatModelCapabilities.newInstance as T :T==_w ?$ChatModelCost.newInstance as T :T==_x ?$NagaModelsListResponse.newInstance as T :T==_y ?$NagaModel.newInstance as T :T==_z ?$NagaArchitecture.newInstance as T :T==_10 ?$NagaPricing.newInstance as T :T==_11 ?$OpenRouterModelsListResponse.newInstance as T :T==_12 ?$OpenRouterModel.newInstance as T :T==_13 ?$OpenRouterArchitecture.newInstance as T :T==_14 ?$OpenRouterPricing.newInstance as T : throw _c();
_5 $artifactToMap(Object o)=>o is _d ?o.toMap():o is _e ?o.toMap():o is _f ?o.toMap():o is _g ?o.toMap():o is _h ?o.toMap():o is _i ?o.toMap():o is _j ?o.toMap():o is _k ?o.toMap():o is _l ?o.toMap():o is _m ?o.toMap():o is _n ?o.toMap():o is _o ?o.toMap():o is _p ?o.toMap():o is _q ?o.toMap():o is _r ?o.toMap():o is _s ?o.toMap():o is _t ?o.toMap():o is _u ?o.toMap():o is _v ?o.toMap():o is _w ?o.toMap():o is _x ?o.toMap():o is _y ?o.toMap():o is _z ?o.toMap():o is _10 ?o.toMap():o is _11 ?o.toMap():o is _12 ?o.toMap():o is _13 ?o.toMap():o is _14 ?o.toMap():throw _c();
T $artifactFromMap<T>(_5 m)=>T==_d ?$ChatRequest.fromMap(m) as T:T==_e ?$ChatModel.fromMap(m) as T:T==_f ?$ARational.fromMap(m) as T:T==_g ?$ChatResult.fromMap(m) as T:T==_h ?$ChatUsage.fromMap(m) as T:T==_i ?$Content.fromMap(m) as T:T==_j ?$AudioContent.fromMap(m) as T:T==_k ?$ContentGroup.fromMap(m) as T:T==_l ?$ImageContent.fromMap(m) as T:T==_m ?$TextContent.fromMap(m) as T:T==_n ?$Message.fromMap(m) as T:T==_o ?$AgentMessage.fromMap(m) as T:T==_p ?$SystemMessage.fromMap(m) as T:T==_q ?$ToolMessage.fromMap(m) as T:T==_r ?$UserMessage.fromMap(m) as T:T==_s ?$ToolCall.fromMap(m) as T:T==_t ?$ToolSchema.fromMap(m) as T:T==_u ?$IChunk.fromMap(m) as T:T==_v ?$ChatModelCapabilities.fromMap(m) as T:T==_w ?$ChatModelCost.fromMap(m) as T:T==_x ?$NagaModelsListResponse.fromMap(m) as T:T==_y ?$NagaModel.fromMap(m) as T:T==_z ?$NagaArchitecture.fromMap(m) as T:T==_10 ?$NagaPricing.fromMap(m) as T:T==_11 ?$OpenRouterModelsListResponse.fromMap(m) as T:T==_12 ?$OpenRouterModel.fromMap(m) as T:T==_13 ?$OpenRouterArchitecture.fromMap(m) as T:T==_14 ?$OpenRouterPricing.fromMap(m) as T:throw _c();
