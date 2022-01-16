-- main.hs
module Main where
import Prelude hiding (init)
import System.Exit ( exitFailure )
import System.Directory
import Kernel

cpuRunnable = True
init = do
    let max_mem = 512
    filesystem_working <- doesFileExist "filesystem/DONE"
    if cpuRunnable then do
        
        putStrLn $ "\ESC[32mSuccess: This OS is runnable on this CPU"
        
        if max_mem == 512
            then do
                putStrLn $ "\ESC[32mSuccess: max memory cap set"
        else do
            putStrLn $ "\ESC[31mError : Problem establishing max memory cap"
            exitFailure
        
        if filesystem_working then do
            putStrLn $ "\ESC[32mSuccess : filesystem found"
        else do
            putStrLn $ "\ESC[31mError : Problem finding filesystem. Run setup script to make one."
            exitFailure

    else do
        putStrLn $ "\ESC[31mError : This OS is not runnable on this CPU"
        exitFailure

main = do
    init
    Kernel.loadKernel
    