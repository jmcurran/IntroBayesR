correctRefs = function(rng, root){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fName, f$path)
    
    refLines = grep('(Figure|Table)[ ]+([A-D0-9]{1,2}\\.[0-9]{1,2})', Lines)
    
    pattern = '(Figure|Table)[ ]+(([A-D0-9]{1,2})\\.([0-9]{1,2}))'
    for(line in refLines){
      tbl = grepl("Table", Lines[line])
      if(tbl)
        Lines[line] = gsub(pattern, "\\1 \\\\ref{tab:\\3-\\4}", Lines[line])
      else
        Lines[line] = gsub(pattern, "\\1 \\\\ref{fig:\\3-\\4}", Lines[line])
    }
    
    cat(paste0(refLines, ": ", Lines[refLines], "\n"))
    
    writeLines(Lines, f$fullName)
  }
}

addFigureLabels = function(rng, root){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fName, f$path)
    
    begin = grep('\\\\begin\\{figure', Lines)
    end = grep('\\\\end\\{figure', Lines)
    
    n = length(begin)
    removeLines = NULL
    
    figCtr = 1
    
    if(n > 0){
      for(k in 1:n){
        b = begin[k]
        e = end[k]
        block = paste(Lines[b:e], collapse = "\n")
        
        label = grepl("\\\\label", block)
        if(!label){
          figName = gsub("^\\\\includegraphics[^{]+\\{([^}]+)\\}.*$", "\\1", block)
          figNumber = figCtr
          
          if(grepl("^.*[Ff]igure[0]*([0-9]+)-[0]*([0-9]+).*$", figName)){
            figNumber = gsub("^.*[Ff]igure[0]*([0-9]+)-[0]*([0-9]+).*$", "\\1-\\2", figName)[1]
          }  
          ## insert the label after the caption
          pat = "\\\\caption(\\{([^{}]+|(?1))*\\})"
          m = gregexpr(pat, block, perl = T)
          capStart = attr(m[[1]], "capture.start", TRUE)[1]
          capLength = attr(m[[1]], "capture.length", TRUE)[1]
          
          strLabel = paste0("\\","label{fig:", figNumber, "}\n")
          newBlock = paste0(substr(block, 1, capStart + capLength),
                            strLabel,
                            substr(block, capStart + capLength + 1, nchar(block)))
          
          figCtr = figCtr + 1
          Lines[b] = newBlock
          Lines[(b+1):e] = ""
          removeLines = c(removeLines, seq(from = b + 1, to = e)) ## keeps track of all the lines we need to discard
        }
        #if(!grepl("\\\\label", block[cap + 1])){
        #  incLines = grep("^\\\\includegraphics", block)
        #  fName = gsub("^\\\\includegraphics[^{]+\\{([^}]+)\\}.*$", "\\1", block[incLines])
        #  fNumber = gsub("^.*[Ff]igure[0]*([0-9]+)-[0]*([0-9]+).*$", "\\1-\\2", fName)[1]
        #  capLine = paste0(block[cap], "\n\\\\label{fig:", fNumber, "}")
        #  cat(paste0(capLine, "\n"))
        #}
      }
    }
    
    if(!is.null(removeLines)){
      writeLines(Lines[-removeLines], f$fullName)
    }
    else
      writeLines(Lines, f$fullName)
  }
}

addTableLabels = function(rng, root){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fName, f$path)
    
    begin = grep('\\\\begin\\{table\\}', Lines)
    end = grep('\\\\end\\{table\\}', Lines)
    
    tblCtr = 1
    
    n = length(begin)
    removeLines = NULL
    
    if(n > 0){
      for(k in 1:n){
        b = begin[k]
        e = end[k]
        block = paste(Lines[b:e], collapse = "\n")
        label = grepl("\\\\label", block)
        
        if(!label){
          ## insert the label after the caption
          pat = "\\\\caption(\\{([^{}]+|(?1))*\\})"
          m = gregexpr(pat, block, perl = T)
          capStart = attr(m[[1]], "capture.start", TRUE)[1]
          capLength = attr(m[[1]], "capture.length", TRUE)[1]
          
          strLabel = paste0("\\label{tab:", i, "-", tblCtr, "}\n")
          newBlock = paste0(substr(block, 1, capStart + capLength),
                            strLabel,
                            substr(block, capStart + capLength + 1, nchar(block)))
          cat(newBlock, "\n")
          Lines[b] = newBlock
          Lines[(b+1):e] = ""
          removeLines = c(removeLines, seq(from = b + 1, to = e)) ## keeps track of all the lines we need to discard
        }
        tblCtr = tblCtr + 1
        
        #if(!grepl("\\\\label", block[cap + 1])){
        #  incLines = grep("^\\\\includegraphics", block)
        #  fName = gsub("^\\\\includegraphics[^{]+\\{([^}]+)\\}.*$", "\\1", block[incLines])
        #  fNumber = gsub("^.*[Ff]igure[0]*([0-9]+)-[0]*([0-9]+).*$", "\\1-\\2", fName)[1]
        #  capLine = paste0(block[cap], "\n\\\\label{fig:", fNumber, "}")
        #  cat(paste0(capLine, "\n"))
        #}
      }
    }
    #cat(paste(removeLines, "\n"))
    if(!is.null(removeLines))
      writeLines(Lines[-removeLines], f$fullName)
    else
      writeLines(Lines, f$fullName)
  }
}

correctChapterRefs = function(rng = 1:20){
  chLabels = NULL
  for(i in 1:20){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    labelLine = grep('^.*\\label\\{(ch:[^}]+)\\}.*$', Lines)
    
    chLabel = gsub("^.*\\label\\{(ch:[^}]+)\\}.*$", "\\1", Lines[labelLine])
    chLabels = c(chLabels, chLabel)
  }
  
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    refLines = grep('([Ii]n[ ]+Chapter[ ]+)([0-9]{1,2})', Lines)
    writeLines(Lines, paste0(fName, ".bak"))
    
    for(line in refLines){
      chNum = as.numeric(gsub('^.*([Ii]n[ ]+Chapter[ ]+)([0-9]{1,2}).*$', "\\2", Lines[line]))
      newLine = gsub('([Ii]n[ ]+Chapter[ ]+)([0-9]{1,2})', 
                     paste0("\\1","\\\\ref{", chLabels[chNum], "}"),
                     Lines[line])
      cat(paste0(Lines[line], "\n"))
      cat(paste0(newLine, "\n"))
    }
    
    writeLines(Lines, fName)
  }
}

correctSectionRefs = function(rng = 1:20){
  chLabels = NULL
  for(i in 1:20){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    labelLine = grep('^.*\\label\\{(ch:[^}]+)\\}.*$', Lines)
    
    chLabel = gsub("^.*\\label\\{(ch:[^}]+)\\}.*$", "\\1", Lines[labelLine])
    chLabels = c(chLabels, chLabel)
  }
  
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    refLines = grep('([Ii]n[ ]+Chapter[ ]+)([0-9]{1,2})', Lines)
    writeLines(Lines, paste0(fName, ".bak"))
    
    for(line in refLines){
      chNum = as.numeric(gsub('^.*([Ii]n[ ]+Chapter[ ]+)([0-9]{1,2}).*$', "\\2", Lines[line]))
      newLine = gsub('([Ii]n[ ]+Chapter[ ]+)([0-9]{1,2})', 
                     paste0("\\1","\\\\ref{", chLabels[chNum], "}"),
                     Lines[line])
      cat(paste0(Lines[line], "\n"))
      cat(paste0(newLine, "\n"))
    }
    
    writeLines(Lines, fName)
  }
}

