-module(muffin_conversion).
-include("include/muffin.hrl").

-export([convert_json_to_record/1, convert_record_to_json/1]).

convert_json_to_record(Json) ->
  DecodedJson = mochijson2:decode(Json),
  #muffin{type=ej:get({"muffin", "type"}, DecodedJson),
          owner=ej:get({"muffin", "owner"}, DecodedJson),
          purchaser=ej:get({"muffin", "purchaser"}, DecodedJson)}.

convert_record_to_json(#muffin{id=Id, type=Type, owner=Owner}) ->
  Muffin = ej:set_p({"muffin", "id"}, {[]}, Id),
  MuffinWithType = ej:set({"muffin", "type"}, Muffin, Type),
  MuffinWithOwner = ej:set({"muffin", "owner"}, MuffinWithType, Owner),
  list_to_binary(mochijson2:encode(MuffinWithOwner)).
