module Grandchild exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task


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


type alias UpdateConfig msg =
    { toMsg : Msg -> msg
    }


update : UpdateConfig msg -> Msg -> Model -> ( Model, Cmd msg )
update config msg model =
    case msg of
        Value3 ->
            ( model, Cmd.map config.toMsg (Task.perform identity (Task.succeed Value4)) )

        Value4 ->
            ( model, Cmd.none )


type alias ViewConfig msg =
    { toMsg : Msg -> msg }


view : ViewConfig msg -> Html msg
view config =
    div []
        [ button [ onClick <| config.toMsg Value3 ] [ text "Some" ]
        , Html.map config.toMsg <| button [ onClick <| Value4 ] [ text "Thing" ]
        ]
