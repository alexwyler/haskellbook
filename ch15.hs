module Ch15 where
  import Data.Monoid

  data Optional a = 
      Nada
    | Only a
    deriving (Eq, Show)

  instance Monoid a => Monoid (Optional a) where
    mempty = Nada

    mappend (Only a) (Only b) = Only (mappend a b)
    mappend (Only a) _        = Only a
    mappend _ (Only a)        = Only a
    mappend _ _               = Nada