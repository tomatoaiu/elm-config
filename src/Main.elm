module Main exposing (Msg(..), main, update)

import Browser
import Browser.Navigation as Navigation
import Child
import Html exposing (..)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


init : flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url Child.init
    , Cmd.none
    )


type alias Model =
    { key : Navigation.Key
    , url : Url.Url
    , child : Child.Model
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ChildMsg Child.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )

        UrlChanged _ ->
            ( model, Cmd.none )

        ChildMsg childMsg ->
            Child.update childMsg { key1 = "1", key2 = "2" }
                |> Tuple.mapBoth
                    (\subModel -> { model | child = subModel })
                    (Cmd.map ChildMsg)


view : Model -> Browser.Document Msg
view _ =
    { title = "Hello"
    , body =
        [ Html.map ChildMsg <| Child.view { key1 = "1", key2 = "2" }
        ]
    }
