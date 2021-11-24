module Board exposing (..)

import CellGrid exposing (CellGrid)
import CellGrid.Render
import Color exposing (rgb255)
import Html exposing (Html)
import Piece exposing (Piece, PiecePart)


type alias Board =
    CellGrid BoardPart


type Msg
    = NoOp


type BoardPart
    = Empty
    | Forbidden
    | Filled Piece


type alias PiecePosition =
    { row : Int
    , column : Int
    }


init =
    CellGrid.fromList
        { rows = 7
        , columns = 7
        }
        [ -- row 1
          Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Forbidden

        -- row 2
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Forbidden

        -- row 3
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty

        -- row 4
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty

        -- row 5
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty

        -- row 6
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty
        , Empty

        -- row 7
        , Empty
        , Empty
        , Empty
        , Forbidden
        , Forbidden
        , Forbidden
        , Forbidden
        ]
        |> Maybe.withDefault CellGrid.empty


view : Board -> List ( Piece, PiecePosition ) -> Html Msg
view board pieces =
    List.foldl displayPieceOnGrid board pieces
        |> CellGrid.Render.asHtml
            { width = 350, height = 350 }
            { cellWidth = 50
            , cellHeight = 50
            , toColor =
                \cell ->
                    case cell of
                        Empty ->
                            rgb255 200 200 200

                        Forbidden ->
                            rgb255 255 255 255

                        Filled piece ->
                            piece.color
            , gridLineWidth = 1
            , gridLineColor = rgb255 0 255 255
            }
        |> Html.map (\_ -> NoOp)


displayPieceOnGrid : ( Piece, PiecePosition ) -> CellGrid BoardPart -> CellGrid BoardPart
displayPieceOnGrid ( piece, piecePosition ) board =
    CellGrid.indexedMap
        (\x y piecePart ->
            ( { row = piecePosition.row + x, column = piecePosition.column + y }, piecePart )
        )
        piece.shape
        |> CellGrid.foldl
            (\( position, piecePart ) currentBoard ->
                CellGrid.set position
                    (if piecePart == Piece.Empty then
                        CellGrid.get position currentBoard
                            |> Maybe.withDefault Empty

                     else
                        Filled piece
                    )
                    currentBoard
            )
            board
