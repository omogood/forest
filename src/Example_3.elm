import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
    { name : String
    , age : String
    , password : String
    , passwordAgain : String
    , is_submit : Bool
    }


-- INIT

init : Model
init =
    Model "" "" "" "" False


-- UPDATE

type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String
    | Submit

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name, is_submit = False }

        Age age ->
            { model | age = age, is_submit = False  }

        Password password ->
            { model | password = password, is_submit = False  }

        PasswordAgain password ->
            { model | passwordAgain = password, is_submit = False }

        Submit ->
            { model | is_submit = True }

-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "text" "Age" model.age Age
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        , button [ onClick Submit ] [ text "Submit" ]
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
   if model.is_submit == True then
        checkPassWord model
   else if model.name /= "" && model.password /= "" && model.passwordAgain /= "" then
        div [ style "color" "Blue" ] [ text "Click Submit." ]
    else
        div [ style "color" "Black" ] [ text "Prease Typing." ]


checkPassWord : Model -> Html msg
checkPassWord model =
    let
        name = model.name
        password = model.password
        passwordAgain = model.passwordAgain
        len = String.length password
        range = { lower = 8, upper = 16 }
    in
    if name == "" || password == "" || passwordAgain == "" then
        div [ style "color" "Black" ] [ text "Prease Inputs." ]
    else
        if (len < range.lower || len > range.upper) then
            div [ style "color" "Red" ] [ text "Please Typing PassWord is 8 or More Characters, 16 Characters or less." ]
        else if (password /= passwordAgain) then
            div [ style "color" "Red" ] [ text "Passwords do not match!" ]
        else
            div [ style "color" "green" ] [ text "OK" ]
