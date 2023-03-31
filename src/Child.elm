module Child exposing (..)

import Grandchild
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


init : Model
init =
    { key1 = "value1"
    , key2 = "value2"
    }


type alias Model =
    { key1 : String
    , key2 : String
    }


type Msg
    = Value1
    | Value2
    | GrandchildMsg Grandchild.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Value1 ->
            ( model, Cmd.none )

        Value2 ->
            ( model, Cmd.none )

        GrandchildMsg grandchildMsg ->
            let
                ( _, grandchildCmd ) =
                    Grandchild.update grandchildMsg Grandchild.init
            in
            ( model, Cmd.map GrandchildMsg grandchildCmd )


view : Model -> Html Msg
view _ =
    div []
        [ button [ onClick Value1 ] [ text "Some" ]
        , Grandchild.view { toMsg = GrandchildMsg }
        ]
