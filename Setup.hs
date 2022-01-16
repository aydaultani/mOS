-- Setup.hs
module Setup where
import System.Directory (createDirectoryIfMissing, doesFileExist)
import System.FilePath.Posix (takeDirectory)

main :: IO ()


createAndWriteFile :: FilePath -> String -> IO ()
createAndWriteFile path content = do
  createDirectoryIfMissing True $ takeDirectory path

  writeFile path content

main = do
    putStr "Making filesystem checker...."
    createAndWriteFile "filesystem/DONE" "Working."
    putStrLn "OK"
    putStr "Making filesystem userfiles...."
    createDirectoryIfMissing True "filesystem/userfiles"
    putStrLn "OK"
    putStrLn "Welcome to mOS, setup complete!"
    