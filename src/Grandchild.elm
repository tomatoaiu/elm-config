module Grandchild exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


init : Model
init =
    { key3 = "value3"
    , key4 = "value4"
    }


type alias Model =
    { key3 : String
    , key4 : String
    }


type Msg
    = Value3
    | Value4


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Value3 ->
            ( model, Cmd.none )

        Value4 ->
            ( model, Cmd.none )


type alias Config msg =
    { toMsg : Msg -> msg }


view : Config msg -> Html msg
view config =
    div []
        [ button [ onClick <| config.toMsg Value3 ] [ text "Some" ]
        , button [ onClick <| config.toMsg Value4 ] [ text "Thing" ]
        ]
