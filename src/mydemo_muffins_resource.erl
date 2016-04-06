-module(mydemo_muffins_resource).
-export([init/1,
         to_html/2,
         allowed_methods/2,
         post_is_create/2,
         create_path/2,
         content_types_accepted/2,
         create_muffin/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Context) ->
  {{trace, "/tmp"}, Context}.

to_html(RequestData, Context) ->
  {"Get your muffins here!", RequestData, Context}.

allowed_methods(RequestData, Context) ->
  {['GET','POST','OPTIONS'], RequestData, Context}.

post_is_create(RequestData, Context) ->
  {true, RequestData, Context}.

create_path(RequestData, Context) ->
  {integer_to_list(muffin_gen_server:get_next_muffin_id()), RequestData, Context}.

content_types_accepted(RequestData, Context) ->
  {[{"text/html", create_muffin}], RequestData, Context}.

create_muffin(RequestData, Context) ->
  muffin_gen_server:create_muffin(wrq:req_body(RequestData)),
  {true, RequestData, Context}.
