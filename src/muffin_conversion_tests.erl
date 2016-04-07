-module(muffin_conversion_tests).

-include_lib("eunit/include/eunit.hrl").

-include("include/muffin.hrl").

-import(muffin_conversion, [convert_json_to_record/1]).

convert_muffin_json_test_() ->
  Json = <<"{\"muffin\":{\"type\":\"pistachio\",\"owner\":\"grant\",\"purchaser\":\"lulu\"}}">>,
  Muffin = convert_json_to_record(Json),
  [
    {"convert type field", ?_assertEqual(<<"pistachio">>, Muffin#muffin.type)},
    {"convert owner field", ?_assertEqual(<<"grant">>, Muffin#muffin.owner)},
    {"convert purchaser field", ?_assertEqual(<<"lulu">>, Muffin#muffin.purchaser)},
    {"id defaults to undefined", ?_assertEqual(undefined, Muffin#muffin.id)}
  ].










% convert_muffin_json_to_record_test() ->
%   Json = <<"{\"muffin\":{\"type\":\"pistachio\",\"owner\":\"bob\",\"purchaser\":\"sean\"}}">>,
%   ActualResult = convert_json_to_record(Json),
%   ExpectedResult = #muffin{type = <<"pistachio">>, id = undefined, purchaser = <<"sean">>, owner = <<"bob">>},
%   ?assertEqual(ExpectedResult, ActualResult).
