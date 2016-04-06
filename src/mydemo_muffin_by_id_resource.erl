-module(mydemo_muffin_by_id_resource).
-export([init/1,
         to_html/2,
         allowed_methods/2,
         delete_resource/2
         ]).

-include_lib("webmachine/include/webmachine.hrl").

init(Context) ->
  {{trace, "/tmp"}, Context}.

to_html(RequestData, Context) ->
  MuffinId = list_to_integer(wrq:path_info(muffin_id, RequestData)),
  Result = io_lib:format("Here is the muffin you requested.  Muffin: ~p", [muffin_gen_server:get_muffin(MuffinId)]),
  {Result, RequestData, Context}.

allowed_methods(RequestData, Context) ->
  {['GET', 'DELETE'], RequestData, Context}.

delete_resource(RequestData, Context) ->
  MuffinId = list_to_integer(wrq:path_info(muffin_id, RequestData)),
  muffin_gen_server:ete_mffn(MuffinId),
  {true, RequestData, Context}.
