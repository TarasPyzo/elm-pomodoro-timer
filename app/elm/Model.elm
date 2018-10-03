module Model exposing (Model, Period(..), init)

import Messages exposing (..)


type alias Model =
    { counter : Float
    , counterMax : Float
    , active : Bool
    , period : Period
    }


type Period
    = InWorking
    | InShortBreak
    | InLongBreak
    | InStopped


init : ( Model, Cmd Msg )
init =
    ( { counter = 0
      , counterMax = 0
      , active = False
      , period = InStopped
      }
    , Cmd.none
    )
