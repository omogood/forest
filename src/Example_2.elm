import Browser
import Html exposing (Html, Attribute, div, button, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- MAIN

main =
    Browser.sandbox {init = init, update = update, view = view}


-- MODEL

type alias Model =
    { content : String
    }

init : Model
init =
    {content = ""}


-- UPDATE

-- Change 関数は、String 型の引数を一つ取る
-- Clear 関数は引数を取らない（定数）
type Msg = Change String | Clear

update : Msg -> Model -> Model
update msg model =
    case msg of
        -- 入力された文字列で更新する
        Change newContent ->
            { model | content = newContent }
        -- 保持している文字列を削除する
        Clear ->
            { model | content = "" }


-- VIEW

view : Model -> Html Msg
view model =
    div []
    [ input [placeholder "入力された文字を反転", value model.content, onInput Change] []
    , button [ onClick Clear ] [ text "Clear" ]
    , div [] [text (String.reverse model.content)]
    ]