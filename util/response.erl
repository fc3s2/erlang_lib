%%%-------------------------------------------------------------------
%%% @author blzbwl@163.com
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 十月 2020 1:06
%%%-------------------------------------------------------------------
-module(response).
-author("blzbwl@163.com").

%% API
-export([http_get/1]).
-export([replace_str/3]).

http_get(Url) ->
	Result = inets:start(),
	case Result =:= ok orelse Result =:= {error, {already_started, inets}} of
		true ->
			try httpc:request(get, {Url, [{"connection", "keep-alive"}]}, [{timeout, 3000}], []) of
				{ok, {{Xieyi, ReCode, Type}, NetArg, Body}} when ReCode >= 200, ReCode < 400 ->
					{ok, Body};
				E ->
					E
			catch
				R2:Reason ->
					{R2, Reason}
			end;
		false -> {503, [{url, Url}, {error, Result}]}
	end.

http_get1(Url) ->
	case http_get(Url) of
		{ok, Result} -> pass;
		Error ->
			Error
	end.


replace_str(L, Str, Str1) ->
	NL = re:split(L, Str),
	replace_append(Str1, NL, []).
replace_append(Item, [], Str) ->
	Str;
replace_append(Str, [H | T], []) ->
	replace_append1(Str, T, string:concat(binary_to_list(H), Str));
replace_append(Str, [H | T], NewStr) ->
	replace_append1(Str, T, string:concat(NewStr, Str)).

replace_append1(Str, [], NewStr) ->
	NewStr;
replace_append1(Str, [H | T], NewStr) ->
	replace_append(Str, T, string:concat(NewStr, binary_to_list(H))).
