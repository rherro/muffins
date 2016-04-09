-module(mydemo_muffin_by_id_resource).
-export([init/1,
         malformed_request/2,
         to_html/2,
         allowed_methods/2,
         delete_resource/2
         ]).

-include_lib("webmachine/include/webmachine.hrl").

init(Context) ->
  {{trace, "/tmp"}, Context}.

malformed_request(RequestData, Context) ->
  MuffinId = wrq:path_info(muffin_id, RequestData),
  {re:run(MuffinId, element(2,re:compile("^\\d+$"))) == nomatch, RequestData, Context}.

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
