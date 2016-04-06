-module(muffin_gen_server_tests).

-include_lib("eunit/include/eunit.hrl").

-import(muffin_gen_server, [handle_call/3]).

create_muffin_test() ->
    ?assertEqual({reply, 1, [{1,muffin}]}, handle_call({create_muffin, muffin}, who_cares, [])).

get_muffin_test() ->
    State = [{1,muffin},{2,nota_muffin}],
    ?assertEqual({reply, muffin, State}, handle_call({get_muffin, 1}, who_cares, State)).

get_non_existent_muffin_test() ->
    State = [{1,muffin},{2,nota_muffin}],
    ?assertEqual({reply, undefined, State}, handle_call({get_muffin, 3}, who_cares, State)).

get_next_muffin_id_test_() ->
    [
      ?_assertEqual({reply, 1, []}, handle_call(get_next_muffin_id, who_cares, [])),
      ?_assertEqual({reply, 2, [{1,a_muffin}]}, handle_call(get_next_muffin_id, who_cares, [{1,a_muffin}])),
      ?_assertEqual({reply, 3, [{2,a_muffin}]}, handle_call(get_next_muffin_id, who_cares, [{2,a_muffin}]))
    ].

ete_mffn_test_() ->
    [
      ?_assertEqual({reply, ok, [{1,a_muffin}, {3, c_muffin}]}, handle_call({eat_muffin, 2}, who_cares, [{1,a_muffin}, {2, b_muffin}, {3, c_muffin}])),
      ?_assertEqual({reply, ok, [{1,a_muffin}, {2, b_muffin}, {3, c_muffin}]}, handle_call({eat_muffin, 4}, who_cares, [{1,a_muffin}, {2, b_muffin}, {3, c_muffin}]))
    ].
