module Main exposing (main)

import Board exposing (Board, PiecePosition)
import Browser
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)
import Piece exposing (Piece)


type alias Model =
    { board : Board
    , pieces : List PieceWithPosition
    }


type PieceWithPosition
    = NotInBoard Piece
    | InBoard PiecePosition Piece


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
    ( { board = Board.init
      , pieces = Piece.pieces |> List.map (InBoard { row = 1, column = 1 })
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        inBoardPieces =
            List.filterMap
                (\pieceWithPosition ->
                    case pieceWithPosition of
                        InBoard position piece ->
                            Just ( piece, position )

                        NotInBoard _ ->
                            Nothing
                )
                model.pieces
    in
    div []
        [ h1 [] [ text "Calendar Puzzle" ]
        , Board.view model.board inBoardPieces |> Html.map (\_ -> NoOp)
        , List.filterMap
            (\pieceWithPosition ->
                case pieceWithPosition of
                    NotInBoard piece ->
                        Just piece

                    _ ->
                        Nothing
            )
            model.pieces
            |> List.map Piece.view
            |> List.map (\pieceHtml -> div [ style "margin" "5px" ] [ pieceHtml ])
            |> div [ style "display" "flex", style "flex-wrap" "wrap" ]
            |> Html.map (\_ -> NoOp)
        ]
