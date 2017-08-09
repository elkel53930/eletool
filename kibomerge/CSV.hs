module CSV (readCSV, writeCSV) where

import Text.ParserCombinators.Parsec hiding(Line)
import Text.Parsec.Char
import System.IO
import Data.List

type CSV = [Line]
type Line = [String]
type Cell = String

readCSV :: FilePath -> IO ( Either ParseError CSV )
readCSV f = do
  source <- readFile f
  return $ parse csv f source

writeCSV :: FilePath -> CSV -> IO()
writeCSV f csv = writeFile f $ csv2string csv

csv2string :: CSV -> String
csv2string = intercalate "\n" . map line2string

line2string :: Line -> String
line2string = intercalate ","

csv :: Parser CSV -- [[String]]
csv = endBy line eol

line :: Parser Line -- [String]
line = sepBy cell $ char ','

cell :: Parser Cell -- String
cell = many $ noneOf ",\n"

eol :: Parser String
eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
