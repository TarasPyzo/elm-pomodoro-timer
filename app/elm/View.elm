module View exposing (bodySection, convertCounterToPercentage, convertToString, formatTime, navbar, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Model exposing (..)
import Time exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , div [ class "container" ]
            [ div []
                (bodySection model)
            ]
        ]


navbar : Html msg
navbar =
    nav [ class "navbar navbar-expand-md navbar-dark bg-info" ]
        [ a [ class "navbar-brand", href "#" ]
            [ text "Elm Pomodoro Timer" ]
        ]


bodySection : Model -> List (Html Msg)
bodySection model =
    [ div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ h1 [ class "display-3 text-center" ]
                [ text (formatTime model.counter) ]
            ]
        ]
    , div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ p [ class "lead text-center" ]
                [ text
                    (case model.period of
                        InWorking ->
                            if model.counter > 0 then
                                "Time to work!"

                            else
                                "Time to take a break!"

                        InShortBreak ->
                            if model.counter > 0 then
                                "Relax!"

                            else
                                "Time to work again!"

                        InLongBreak ->
                            if model.counter > 0 then
                                "Relax!"

                            else
                                "Time to work again!"

                        InStopped ->
                            "You do nothing!"
                    )
                ]
            ]
        ]
    , div [ class "row justify-content-center mt-3" ]
        [ div [ class "col-md-10" ]
            [ div [ class "progress" ]
                [ div
                    [ classList
                        [ ( "progress-bar", True )
                        , ( "bg-info", model.period == InWorking || model.period == InShortBreak || model.period == InLongBreak )
                        ]
                    , attribute "style" (convertCounterToPercentage model.counter model.counterMax)
                    ]
                    []
                ]
            ]
        ]
    , div [ class "row mt-5" ]
        [ div [ class "col-md-3 mt-1" ]
            [ button
                [ classList
                    [ ( "btn btn-info btn-block", model.period == InWorking )
                    , ( "btn btn-outline-info btn-block", model.period /= InWorking )
                    ]
                , onClick Work
                ]
                [ text "Work" ]
            ]
        , div [ class "col-md-3 mt-1" ]
            [ button
                [ classList
                    [ ( "btn btn-info btn-block", model.period == InShortBreak )
                    , ( "btn btn-outline-info btn-block", model.period /= InShortBreak )
                    ]
                , onClick ShortBreak
                ]
                [ text "Short Break" ]
            ]
        , div [ class "col-md-3 mt-1" ]
            [ button
                [ classList
                    [ ( "btn btn-info btn-block", model.period == InLongBreak )
                    , ( "btn btn-outline-info btn-block", model.period /= InLongBreak )
                    ]
                , onClick LongBreak
                ]
                [ text "Long Break" ]
            ]
        , div [ class "col-md-3 mt-1" ]
            [ button
                [ classList
                    [ ( "btn btn-info btn-block", model.period == InStopped )
                    , ( "btn btn-outline-info btn-block", model.period /= InStopped )
                    ]
                , onClick Stop
                ]
                [ text "Stop" ]
            ]
        ]
    ]



-- HELPERS


formatTime : Float -> String
formatTime time =
    let
        minutes =
            floor (Time.inMinutes time) % 60

        seconds =
            floor (Time.inSeconds time) % 60
    in
    String.concat
        [ convertToString minutes
        , ":"
        , convertToString seconds
        ]


convertToString : Int -> String
convertToString num =
    if num < 10 then
        "0" ++ toString num

    else
        toString num


convertCounterToPercentage : Float -> Float -> String
convertCounterToPercentage currentTime totalTime =
    let
        percentage =
            (currentTime / totalTime) * 100
    in
    String.concat [ "width: ", toString percentage, "%" ]
