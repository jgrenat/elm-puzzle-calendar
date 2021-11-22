module Main exposing (main)

import Browser
import Html exposing (Html, h1, text)


type alias Model =
    {}


type Msg
    = NoOp


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init () =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    h1 [] [ text "Calendar Puzzle" ]
