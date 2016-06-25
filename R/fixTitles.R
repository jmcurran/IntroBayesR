fixTitles = function(rng = 1:20, root, dummyRun = TRUE, collapse = FALSE){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    pattern = "\\\\(chapter|(sub)*section(\\*)*)\\{([^}]*)\\}"
    
    if(!collapse){
      # if(!dummyRun){
      #   if(length(grep(pattern, Lines, perl = TRUE)) > 0){
      #     writeBackup(f$fName, f$path, dummyRun)
      #     Lines1 = gsub(pattern, replace, Lines, perl = TRUE)
      #     writeLines(Lines1, f$fullName)
      #   }
      # }else{
      if(length(grep(pattern, Lines, perl = TRUE)) > 0){
        writeBackup(f$fName, f$path, dummyRun)
        Lines1 = Lines
        repLines = grep(pattern, Lines, perl = TRUE)
        for(i in repLines){
          secCmd = gsub(pattern, "\\1", Lines[i], perl = TRUE)
          newTitle = stringr::str_to_title(gsub(pattern, "\\4", Lines[i], perl = TRUE))
          newLine = paste0("\\", secCmd, "{", newTitle, "}")
          if(stringi::stri_cmp(newLine, Lines[i]) != 0){
            cat(paste0(f$fName, ": ", Lines[i], "\n"))
            cat(paste0(f$fName, ": ", newLine, "\n"))
            Lines1[i] = newLine
          }
        }
        if(!dummyRun){
          writeLines(Lines1, f$fullName)
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
    