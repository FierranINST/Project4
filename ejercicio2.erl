-module(ejercicio2).
-export([start/1, calculate_product/2]).

% Función principal que inicia el proceso concurrente
start(N) ->
    spawn(?MODULE, calculate_product, [self(), N]),
    receive
        {N, P, IsPerfectSquare} ->
            io:format("El producto de los enteros consecutivos es: ~p~n", [P]),
            if
                IsPerfectSquare -> io:format("~p + 1 es un cuadrado perfecto.~n", [P]);
                true -> io:format("~p + 1 NO es un cuadrado perfecto.~n", [P])
            end
    end.

% Proceso que calcula el producto de los enteros consecutivos y verifica si P + 1 es un cuadrado perfecto
calculate_product(ParentPid, N) ->
    P = N * (N + 1) * (N + 2) * (N + 3),
    IsPerfectSquare = is_perfect_square(P + 1),
    ParentPid ! {N, P, IsPerfectSquare}.

% Función que verifica si un número es un cuadrado perfecto
is_perfect_square(X) ->
    Sqrt = math:sqrt(X),
    Sqrt == round(Sqrt).
