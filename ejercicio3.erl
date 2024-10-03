-module(ejercicio3).
-export([start/2, calculate_values/3]).

% Función principal que inicia el proceso
start(A, MaxX) ->
    spawn(?MODULE, calculate_values, [self(), A, MaxX]),
    receive
        Result -> io:format("Tabla de valores:~n~p~n", [Result])
    end.

% Proceso concurrente que calcula la tabla de valores
calculate_values(ParentPid, A, MaxX) ->
    Values = [{X, math:pow(A, X)} || X <- lists:seq(0, MaxX)],
    ParentPid ! Values.
