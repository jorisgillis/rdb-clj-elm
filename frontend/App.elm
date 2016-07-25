module App exposing (..)

import Html exposing (Html, div, text, ul, li, p)
import Html.App
import Html.Attributes exposing (class)

import Recipe

-- Model
type alias Model =
    { recipes : Recipe.Model }

init : (Model, Cmd Msg)
init = (initialModel, Cmd.map RecipeMsg Recipe.fetchAll)

initialModel : Model
initialModel = { recipes = Recipe.initialModel }

-- MESSAGES
type Msg
    = RecipeMsg Recipe.Msg

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ showNavigation
        , div [ ]
              [ (Html.App.map RecipeMsg (Recipe.view model.recipes)) ]
        ]

showNavigation : Html Msg
showNavigation =
    div [ class "navbar navbar-default" ]
        [ div [class "container"]
              [ div [ class "navbarheader" ]
                    [ p [class "navbar-brand"] [ text "RecipeDB" ] ] ]
        ]

-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        RecipeMsg subMsg ->
            let (newRecipes, cmd) =
                    Recipe.update subMsg model.recipes
            in
                ( { model | recipes = newRecipes }, Cmd.map RecipeMsg cmd )
                
-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN
main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

