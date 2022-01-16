-- kernel.hs
module Kernel where
import System.Exit ( exitFailure , exitSuccess)
import Text.Printf
import System.Directory (createDirectoryIfMissing , doesFileExist)
import System.FilePath.Posix (takeDirectory)
import Control.Monad
import System.IO

error error = exitFailure

createAndWriteFile :: FilePath -> String -> IO ()
createAndWriteFile path content = do
  createDirectoryIfMissing True $ takeDirectory path

  writeFile path content

logic input = do
    if input == "" then do putStrLn "Error command can't be null"
    else if input == "exit" then do
        exitSuccess
    else if input == "about" then do
        putStrLn "Welcome to mOS"
        putStrLn "A weird operating system SYSTEM made in haskell"
        putStrLn "Run the 'help' command to well get help :D"
    else if input == "touch" then do
        putStr "Name of file to create: "
        fileName <- getLine
        putStrLn ""
        putStr "Content: "
        content <- getLine
        let filePath = "filesystem/userfiles/" ++ fileName
        createAndWriteFile filePath content
    else if input == "cat" then do
        putStr "Name of file: "
        fileName <- getLine 
        let foo = "filesystem/userfiles/" ++ fileName
        bar <- doesFileExist foo
        if bar then do
            handle <- openFile foo ReadMode
            contents <- hGetContents handle
            putStrLn contents
        else do printf "Error: file '%s' not found\n" fileName
    else if input == "help" then do
        putStrLn "[1] 'help' : Shows this command"
        putStrLn "[2] 'about' : Learn about the OS"
        putStrLn "[3] 'exit' : Exit the kernel"
        putStrLn "[4] 'touch' : Make a file"
        putStrLn "[5] 'cat' : Read a file"
    else
        printf "Error : command '%s' not found\n"  input

kernel = do
    putStr "> "
    input <- getLine
    logic input
    kernel
    

loadKernel = do
    putStr "\ESC[37m"
    putStrLn ""
    putStrLn "Loading kernel.... OK"
    putStrLn "Loading dependencies.... OK"
    putStrLn ""
    kernel