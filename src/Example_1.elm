port module Example_1 exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

main =
    Browser.sandbox {init = init, update = update, view = view}


-- MODEL

type alias Model = Int

init : Model
init =
    0


-- UPDATE

-- Msg をユニオン型で定義
type Msg = Increment | Decrement | Reset

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [text "+"]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick Reset ] [ text "Reset" ]
        ]



