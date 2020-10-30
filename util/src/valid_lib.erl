-module(valid_lib).
%%%=======================EXPORT=======================
-export([check_valib/1]).


%%%=================EXPORTED FUNCTIONS=================
-spec check_valib(list()) -> boolean().
check_valib([]) ->
    true;
check_valib([TypeAndValue | Rest]) ->
    case check_valid_(TypeAndValue) of
        true ->
            check_valib(Rest);
        _ ->
            false
    end.

%%%===================LOCAL FUNCTIONS==================
check_valid_({'range', CurValue, {Min, Max}}) ->%中间
    Min =< CurValue andalso CurValue =< Max;
check_valid_({'equal', CurValue, ComValue}) ->%等于
    CurValue =:= ComValue;
check_valid_({'unequal', CurValue, ComValue}) ->%不等于
    CurValue =/= ComValue;
check_valid_({'gt', CurValue, ComValue}) ->%大于
    CurValue > ComValue;
check_valid_({'ge', CurValue, ComValue}) ->%大于等于
    CurValue >= ComValue;
check_valid_({'lt', CurValue, ComValue}) ->%小于
    CurValue < ComValue;
check_valid_({'le', CurValue, ComValue}) ->%小于等于
    CurValue =< ComValue;
check_valid_({'exist', CurValue, List}) -> %存在于表中
    lists:member(CurValue, List);
check_valid_(_) ->
    true.
