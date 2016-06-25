findRE = function(pattern, rng = c(1:20, LETTERS[1:4], "S"), root, dummyRun = TRUE, replace = FALSE, collapse = FALSE){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    
    if(!collapse){
      if(is.logical(replace) && !replace){
        i = grep(pattern, Lines, perl = TRUE)
        cat(paste0(f$fName, "\n"))
        cat(paste0(i, ": ", Lines[i], "\n"))
      }else{
        if(!dummyRun){
          if(length(grep(pattern, Lines, perl = TRUE)) > 0){
            writeBackup(f$fName, f$path, dummyRun)
            Lines1 = gsub(pattern, replace, Lines, perl = TRUE)
            writeLines(Lines1, f$fullName)
          }
        }else{
          if(length(grep(pattern, Lines, perl = TRUE)) > 0){
            writeBackup(f$fName, f$path, dummyRun)
            repLines = grep(pattern, Lines, perl = TRUE)
            for(i in repLines){
              newLine = gsub(pattern, replace, Lines[i], perl = TRUE)
              cat(paste0(f$fName, ": ", Lines[i], "\n"))
              cat(paste0(f$fName, ": ", newLine, "\n"))
            }
          }
        }
      }
    }else{
      line = paste(Lines, collapse = "\n")
      r = gregexpr(pattern, line)
      
      if(length(r) > 0){
        lapply(regmatches(line, r), function(e){
          n = gsub("[,]+", "!", e);
          cat(paste(substr(e, 1, 50),"\n"));
        })
      }
    }
  }
}
    