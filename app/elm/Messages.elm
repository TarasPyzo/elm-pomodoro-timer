module Messages exposing (Msg(..))

import Time exposing (Time)


type Msg
    = Tick Time
    | Work
    | ShortBreak
    | LongBreak
    | Stop
