module Update exposing (update)

import Messages exposing (..)
import Model exposing (..)
import Time exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            let
                newCounter =
                    if model.active && model.counter > 0 then
                        model.counter - second

                    else
                        model.counter
            in
            ( { model | counter = newCounter }, Cmd.none )

        Work ->
            ( { model | active = True, counter = 25 * minute, counterMax = 25 * minute, period = InWorking }, Cmd.none )

        ShortBreak ->
            ( { model | active = True, counter = 5 * minute, counterMax = 5 * minute, period = InShortBreak }, Cmd.none )

        LongBreak ->
            ( { model | active = True, counter = 15 * minute, counterMax = 15 * minute, period = InLongBreak }, Cmd.none )

        Stop ->
            ( { model | active = False, counter = 0 * minute, counterMax = 0 * minute, period = InStopped }, Cmd.none )
