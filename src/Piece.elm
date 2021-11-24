module Piece exposing (..)

import CellGrid exposing (CellGrid, Dimensions)
import CellGrid.Render
import Color exposing (Color, rgb, rgb255)
import Html exposing (Html)


type Msg
    = NoOp


dimensions : Dimensions
dimensions =
    { rows = 3
    , columns = 4
    }


type alias Piece =
    { shape : CellGrid PiecePart
    , color : Color
    }


type PiecePart
    = Empty
    | Filled


pieces : List Piece
pieces =
    [ ( [ Filled, Filled, Filled, Filled, Empty, Empty, Empty, Filled, Empty, Empty, Empty, Empty ], rgb255 200 200 50 )
    , ( [ Filled, Filled, Filled, Empty, Filled, Empty, Filled, Empty, Empty, Empty, Empty, Empty ], rgb255 35 12 230 )
    , ( [ Filled, Filled, Filled, Empty, Filled, Filled, Empty, Empty, Empty, Empty, Empty, Empty ], rgb255 35 244 230 )
    , ( [ Filled, Filled, Filled, Empty, Empty, Empty, Filled, Filled, Empty, Empty, Empty, Empty ], rgb255 35 200 120 )
    , ( [ Filled, Empty, Empty, Empty, Filled, Filled, Filled, Empty, Empty, Empty, Filled, Empty ], rgb255 200 30 30 )
    , ( [ Filled, Filled, Filled, Filled, Empty, Filled, Empty, Empty, Empty, Empty, Empty, Empty ], rgb255 240 244 100 )
    , ( [ Filled, Filled, Filled, Empty, Filled, Empty, Empty, Empty, Filled, Empty, Empty, Empty ], rgb255 230 100 230 )
    , ( [ Filled, Filled, Filled, Empty, Filled, Filled, Filled, Empty, Empty, Empty, Empty, Empty ], rgb255 145 100 10 )
    ]
        |> List.map
            (\( shapeParts, color ) ->
                { shape =
                    CellGrid.fromList dimensions shapeParts |> Maybe.withDefault CellGrid.empty
                , color = color
                }
            )


view : Piece -> Html Msg
view piece =
    CellGrid.Render.asHtml { width = 200, height = 150 }
        { cellWidth = 50
        , cellHeight = 50
        , toColor =
            \cell ->
                if cell == Empty then
                    rgb255 255 255 255

                else
                    piece.color
        , gridLineWidth = 1
        , gridLineColor = rgb255 0 255 255
        }
        piece.shape
        |> Html.map (\_ -> NoOp)
