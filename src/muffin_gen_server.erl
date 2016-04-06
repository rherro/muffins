-module(muffin_gen_server).
-behavior(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, create_muffin/1, get_muffin/1, get_next_muffin_id/0, ete_mffn/1]).

-define(SERVER, ?MODULE).

%% API (client process functions)
start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

create_muffin(Muffin) ->
  gen_server:call(?MODULE, {create_muffin, Muffin}).

get_muffin(MuffinId) ->
  gen_server:call(?MODULE, {get_muffin, MuffinId}).

get_next_muffin_id() ->
  gen_server:call(?MODULE, get_next_muffin_id).

ete_mffn(MuffinId) ->
  gen_server:call(?MODULE, {eat_muffin, MuffinId}).

%% gen_server callbacks  (server process functions)
init(_) ->
  {ok, []}.

handle_call({eat_muffin, MuffinId}, _From, State) ->
  {reply, ok, proplists:delete(MuffinId, State)};
handle_call(get_next_muffin_id, _From, State) ->
  {reply, next_muffin_id(State), State};
handle_call({get_muffin, MuffinId}, _From, State) ->
  {reply, proplists:get_value(MuffinId, State), State};
handle_call({create_muffin, Muffin}, _From, State) ->
  MuffinId = next_muffin_id(State),
  {reply, MuffinId, [{MuffinId, Muffin}|State]};
handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

% INTERNAL %

next_muffin_id([]) ->
  1;
next_muffin_id(State) ->
  lists:max(
    lists:map(
      fun({Id, _Muffin}) -> Id end,
      State
    )
  ) + 1.
