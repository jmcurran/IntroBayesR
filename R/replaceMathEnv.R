alignStarToDM = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0("../Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    writeBackup(Lines, fName, path)
    
    env = grep("^.*(\\\\begin|\\\\end)\\{eqnarray[*]\\}.*$", Lines)
    
    if(length(env) %%2 != 0)
      stop("Unequal lengths")
    
    nPairs = length(env) / 2  
    removeLines = NULL
    
    for(p in 1:nPairs){
      b = env[2 * p - 1]
      e = env[2 * p]
      
      block = paste0(Lines[b:e], "\n")
      m = length(grep("[\\]{2}", block))
      
      if(m==0){
        newBlock = gsub("\\\\begin\\{eqnarray\\*\\}", "\\\\[", block)
        newBlock = gsub("\\\\end\\{eqnarray\\*\\}", "\\\\]", newBlock)
        newBlock = gsub("\\&", " ", newBlock)
        newBlock = gsub("\\mathrm\\{([^}]+)\\}", "\\mbox{ \\1 }", newBlock)
        cat(paste0(b, ": ", block, "\n"))
        cat(paste0(b, ": ", newBlock, "\n"))
        Lines[b] = newBlock
        removeLines = c(removeLines, seq(from = b + 1, to = e)) ## keeps track of all the lines we need to discard
      }
    }
    
    if(!is.null(removeLines)){
      writeLines(Lines[-removeLines], fullName)
    }
  }
}

displayMath = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0("../Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    writeBackup(Lines, fName, path)
    
    env = grep("^.*(\\\\begin|\\\\end)\\{displaymath\\}.*$", Lines)
    Lines[env] = gsub("\\\\begin\\{displaymath\\}", "\\\\[", Lines[env])
    Lines[env] = gsub("\\\\end\\{displaymath\\}", "\\\\]", Lines[env])
    cat(paste0(env, ": ", Lines[env], "\n"))
    
    writeLines(Lines, fullName)
  }
}

statOps = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0("../Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    writeBackup(Lines, fName, path)
    
    pat = "(E|Var|Cov|Cor(r)*|Bias)\\(([^()]+)\\)"
    m = grep(pat, Lines)    
    Lines[m] = gsub(pat, "\\\\\\1[\\3]", Lines[m], perl = TRUE)
    cat(paste0(m, ": ", Lines[m], "\n"))
    
    writeLines(Lines, fullName)
  }
}

MSE = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    writeLines(Lines, paste0(fName, ".bak"))
    cat(fName, "\n")
    
    Lines = readLines(fName)
    
    pat = "(P)*MS\\(([^()]+)\\)"
    m = grep(pat, Lines)    
    Lines[m] = gsub(pat, "\\\\\\1MSE[\\2]", Lines[m], perl = TRUE)
    cat(paste0(m, ": ", Lines[m], "\n"))
    
    writeLines(Lines, fName)
  }
}
  

binom = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    writeLines(Lines, paste0(fName, ".bak"))
    cat(fName, "\n")
    
    Lines = readLines(fName)
    
    pat = "\\left\\(.*\\\\begin\\{array\\}\\{c\\}.*\\\\right\\)"
    m = grep(pat, Lines)    
    cat(paste0(m, ": ", Lines[m], "\n"))
  }
}
