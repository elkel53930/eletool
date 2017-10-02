import CSV
import Data.Map hiding (foldl,map)
import Data.List
import System.Environment
import System.FilePath.Posix

counting :: [[String]] -> [[String]]
counting = sortBy (\x y -> head x `compare` head y)
         . map (\(val,refs) -> [unwords $ sort refs, val, show $ length refs]) -- タプルからリストに戻す
         . toAscList -- マップからリストに戻す :: [(Value,[Reference])]
         . fromListWith (++) -- 重複が発生したらリファレンスを追加しながらmap化 :: Map Value [Reference]
         . foldl (\acc (x:xs) -> (head xs,[x]) : acc ) [] -- リストの先頭を取り出してタプルに変換 :: [(Value,[Reference])]

addPostfix :: String -> FilePath -> FilePath
addPostfix p file = takeBaseName file ++ p ++ takeExtension file

main = do
  args <- getArgs
  let file = head args
  csv <- readCSV file
  case csv of
    Right c -> writeCSV (addPostfix "_cntd" file )
             . ([["Ref","Value","Qty."]] ++)
             . counting
             $ tail c
    Left err -> print err
