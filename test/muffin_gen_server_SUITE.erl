-module(muffin_gen_server_SUITE).

-include_lib("common_test/include/ct.hrl").

-compile(export_all).

all() ->
  [
    create_a_muffin
  ].

init_per_suite(Config) ->
  NewConfig = [{mydemo_deps,
    [crypto, inets, asn1, public_key, ssl, xmerl, compiler, syntax_tools, mochiweb, webmachine, mydemo]}
      |Config],

    lists:foreach(fun(Application) -> application:start(Application) end, proplists:get_value(mydemo_deps, NewConfig)),
  % application:start(crypto),
  % application:start(inets),
  % application:start(asn1),
  % application:start(public_key),
  % application:start(ssl),
  % application:start(xmerl),
  % application:start(compiler),
  % application:start(syntax_tools),
  % application:start(mochiweb),
  % application:start(webmachine),
  % application:start(mydemo),
  NewConfig.

end_per_suite(Config) ->
  lists:foreach(fun(Application) -> application:stop(Application) end, lists:reverse(proplists:get_value(mydemo_apps, Config))),
  % application:stop(mydemo),
  % application:stop(webmachine),
  % application:stop(mochiweb),
  % application:stop(syntax_tools),
  % application:stop(compiler),
  % application:stop(xmerl),
  % application:stop(ssl),
  % application:stop(public_key),
  % application:stop(asn1),
  % application:stop(inets),
  % application:stop(crypto),
  ok.

create_a_muffin(_Config) ->
  Result = muffin_gen_server:create_muffin("test123"),
  ct:log("muffin_gen_server:create_muffin Result = ~p~n", [Result]),
  1 = Result.
