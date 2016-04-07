-module(muffin_conversion).
-include("include/muffin.hrl").

-export([convert_json_to_record/1]).

convert_json_to_record(Json) ->
  DecodedJson = mochijson2:decode(Json),
  #muffin{type=ej:get({"muffin", "type"}, DecodedJson),
          owner=ej:get({"muffin", "owner"}, DecodedJson),
          purchaser=ej:get({"muffin", "purchaser"}, DecodedJson)}.
