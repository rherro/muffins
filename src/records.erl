-module(records).

-export([make_record/0, use_record/0, record_argument/1, record_list/0]).

-record(name, {id = 0, field1 = 4, field2, field3 = {any, type}}).


make_record() ->
    io:format("The default record is ~p~n", [#name{}]),
    io:format("A different record is ~p~n",
        [#name{field1=a_different_type,
            field2="Hello World",
            field3=3.14159}]).

use_record() ->
    A = #name{field1 = happy},
    First = A#name.field1,
    B = A#name{field2="Goodbye Now!"},
    {A, First, B}.

record_argument(#name{field1 = First} = _Record) ->
    First.

record_list() ->
    [
        #name{id=1, field1="time", field3 = "money"},
        #name{id=2, field2="a good day"},
        #name{id=3, field3 = "money", field2=bob},
        #name{field1 = 4, id=5}
    ].
