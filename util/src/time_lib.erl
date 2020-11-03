%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 11月 2020 10:33
%%%-------------------------------------------------------------------
-module(time_lib).
-description().
-author("blzbwl@163.com").
%%%=======================STATEMENT====================

%%%=======================EXPORT=======================
-export([now_second/0]).

-export([calc_day/2]).
%%%=======================INCLUDE======================

%%%=======================DEFINE======================
-define(WEEKEND, 7).
-define(MINUTE_SECOND, 60).
-define(SECONDS_PER_DAY, 86400).
-define(DAYS_FROM_0_TO_1970, 719528).
-define(DIFFERENCE_TIME, server_difference_time).%差异时间

%%%=======================RECORD=======================

%%%=======================TYPE=========================

%%%=================EXPORTED FUNCTIONS=================

%% -----------------------------------------------------------------
%%@doc 计算时间是否过天，返回0表示在同一天，否则表示跨天
%% @spec calc_day(OldTime, FixTime) -> return()
%% where
%%  return() = 0 | Now
%%@end
%% -----------------------------------------------------------------
calc_day(OldTime, FixTime) ->
    calc_day(OldTime, time_lib:now_second(), FixTime).

%% -----------------------------------------------------------------
%%@doc 计算时间是否过天，返回0表示在同一天，否则表示跨天
%% @spec calc_day(OldTime, NowTime, FixTime) -> return()
%% where
%%  return() = 0 | NowTime
%%@end
%% -----------------------------------------------------------------
calc_day(OldTime, NowTime, FixTime) when OldTime < FixTime ->
    NowTime;
calc_day(OldTime, NowTime, FixTime) ->
    {NowDay, _} = second_to_localtime(NowTime - FixTime),
    case second_to_localtime(OldTime - FixTime) of
        {Day, _} when Day < NowDay -> NowTime;
        _ -> 0
    end.


%%%===================LOCAL FUNCTIONS==================

%% -----------------------------------------------------------------
%%@doc 操作系统当前的秒
%% @spec now_second() -> integer()
%%@end
%% -----------------------------------------------------------------
-spec now_second() ->
    integer().
%% -----------------------------------------------------------------
now_second() ->
    {M, S, _} = os:timestamp(),
    M * 1000000 + S.

second_to_localtime(Sec) ->
    erlang:universaltime_to_localtime
    ({
        calendar:gregorian_days_to_date(Sec div ?SECONDS_PER_DAY + ?DAYS_FROM_0_TO_1970),
        calendar:seconds_to_time(Sec rem ?SECONDS_PER_DAY)
    }).