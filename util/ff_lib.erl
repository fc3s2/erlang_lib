%%%-------------------------------------------------------------------
%%% @author blzbwl@163.com
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 七月 2020 0:03
%%%-------------------------------------------------------------------
-module(ff_lib).
-author("blzbwl@163.com").

-ifdef(use_specs).

%%-type error_handler() :: fun((atom(), any()) -> 'ok').
%%
%%-spec load_applications([atom()])                   -> 'ok'.
%%-spec start_applications([atom()])                  -> 'ok'.
%%-spec stop_applications([atom()])                   -> 'ok'.
%%-spec start_applications([atom()], error_handler()) -> 'ok'.
%%-spec stop_applications([atom()], error_handler())  -> 'ok'.
%%-spec app_dependency_order([atom()], boolean())     -> [digraph:vertex()].
%%-spec app_dependencies(atom())                      -> [atom()].
%%
%%-endif.

%% API
-export([get_y_m_d/0, get_day_of_month/0]).

-export([get_string/1, get_integer/1]).

-export([format_utc_timestamp/0]).
-export([get_random/1]).

get_y_m_d() ->
	{YMD, _} = calendar:local_time(),
	YMD.

get_day_of_month() ->
	{{_, _, TD}, {_, _, _}} = calendar:local_time(),
	TD.

format_utc_timestamp() ->
	TS = {_, _, Micro} = os:timestamp(),
	{{Year, Month, Day}, {Hour, Minute, Second}} =
		calendar:now_to_universal_time(TS),
	Mstr = element(Month, {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
		"Aug", "Sep", "Oct", "Nov", "Dec"}),
	io_lib:format("~2w ~s ~4w ~2w:~2..0w:~2..0w.~6..0w",
		[Day, Mstr, Year, Hour, Minute, Second, Micro]).


%% -----------------------------------------%%

get_string(A) ->
	if
		is_integer(A) ->
			integer_to_list(A);
		is_binary(A) ->
			binary_to_list(A);
		is_atom(A) ->
			atom_to_list(A);
		true ->
			A
	end.

get_integer(A) ->
	if
		is_integer(A) ->
			A;
		is_binary(A) ->
			binary_to_integer(A);
		true ->
			list_to_integer(A)
	end.


get_random(N) ->
	get_random(0, N).
get_random(Begin, End) ->
	{_, _, N0} = erlang:timestamp(),
	N = N0 rem (End - Begin),
	N + Begin.