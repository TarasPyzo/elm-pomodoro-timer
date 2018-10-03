module Main exposing (main, subscriptions)

import Html exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Time exposing (..)
import Update exposing (..)
import View exposing (..)



-- MAIN


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick
