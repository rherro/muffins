-module(mydemo_sup).
-behaviour(supervisor).

%% External exports
-export([
  start_link/0
]).

%% supervisor callbacks
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    Web = {webmachine_mochiweb,
           {webmachine_mochiweb, start, [mydemo_config:web_config()]},
           permanent, 5000, worker, [mochiweb_socket_server]},
    Muffin = {muffin_gen_server,
              {muffin_gen_server, start_link, []},
                permanent, 5000, worker, [muffin_gen_server]},
    Processes = [Web, Muffin],
    {ok, { {one_for_one, 10, 10}, Processes} }.
