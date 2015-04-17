changePicPaths = function(rng){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    writeLines(Lines, paste0(fName, ".bak"))
    
    ## remove eps
    incGraphics = grep("includegraphics", Lines)
    Lines[incGraphics] = gsub("\\.eps", "", Lines[incGraphics])
    
    chapter = paste0("Chapter", part)
    for(j in incGraphics){
      picName = gsub("^\\\\includegraphics\\*\\[[^]]+\\]\\{([^}]+)\\}.*$", "\\1", Lines[j])
      options = gsub("^\\\\includegraphics\\*\\[([^]]+)\\]\\{[^}]+\\}.*$", "\\1", Lines[j])
      trailing = gsub("^\\\\includegraphics\\*\\[[^]]+\\]\\{[^}]+\\}(.*$)", "\\1", Lines[j])
      picNewName = gsub("\\.", "-", picName)  
      newLine = paste0("\\includegraphics*[", options, "]{", chapter, "/figures/", picNewName, "}")
      if(nchar(trailing)>1)
        newLine = paste0(newLine, trailing)
      
      cat(paste(newLine, "\n"))
      Lines[j] = newLine
    }
    writeLines(Lines, fName)   
  }
}