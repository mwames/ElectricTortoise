module Player (
    Player (..)
) where

data Player = Player {
    position :: (Double , Double ),
    health :: Integer
}
