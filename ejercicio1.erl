-module(ejercicio1).
-export([start/3, solve_inequality/4]).

% Función principal que inicia el proceso concurrente
start(A, B, C) ->
    spawn(?MODULE, solve_inequality, [self(), A, B, C]),
    receive
        Result -> io:format("Resultado: ~p~n", [Result])
    end.

% Proceso concurrente que resuelve la desigualdad Ax + B > C
solve_inequality(ParentPid, A, B, C) ->
    X = (C - B) / A,
    ParentPid ! {A, B, C, X, "x > " ++ float_to_list(X)}.
