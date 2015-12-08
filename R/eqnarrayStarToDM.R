removeSingleLineEqnarry = function(Lines){
  env = grep("^.*(\\\\begin|\\\\end)\\{eqnarray[*]*\\}.*$", Lines)
  changed = FALSE
  
  if(length(env) > 0){
    if(length(env) %%2 != 0)
      stop("Unequal lengths")
    
    nPairs = length(env) / 2  
    removeLines = NULL
    
    for(p in 1:nPairs){
      b = env[2 * p - 1]
      e = env[2 * p]
      
      block = paste0(Lines[b:e], collapse = "\n")
      m = length(grep("[\\]{2}", block))
      
      if(m==0){
        newBlock = gsub("\\\\begin\\{eqnarray[*]\\}", "\\\\[", block)
        newBlock = gsub("\\\\end\\{eqnarray[*]\\}", "\\\\]", newBlock)
        newBlock = gsub("\\\\begin\\{eqnarray\\}", "\\\\begin\\{equation\\}", newBlock)
        newBlock = gsub("\\\\end\\{eqnarray\\}", "\\\\end\\{equation\\}", newBlock)
        newBlock = gsub("\\&", " ", newBlock)
        newBlock = gsub("\\mathrm\\{([^}]+)\\}", "\\mbox{ \\1 }", newBlock)
        cat(paste0(b, ": ", block, "\n"))
        cat(paste0(b, ": ", newBlock, "\n"))
        Lines[b] = newBlock
        removeLines = c(removeLines, seq(from = b + 1, to = e)) ## keeps track of all the lines we need to discard
        changed = TRUE
      }
    }
  }
  
  if(!changed){
    cat("Nothing to do\n")
    return(FALSE)
  }
  ##else
  return(list(Lines = Lines, removeLines = removeLines, Changed = changed))
}

eqnarrayToEqn = function(rng = 1:20, dummyRun = FALSE, root = "D:/curran/Books/Bill/IntroBayes"){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0(root, "/Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    writeBackup(fName, path, dummyRun)
    
    result = removeSingleLineEqnarry(Lines)
       
    if(!is.logical(result) && !is.null(result$removeLines)){
      if(!dummyRun){
        with(result, {writeLines(Lines[-removeLines], fullName)})
      }
    }else{
      cat("No change\n")
    }
  }
}

findEqnarrayBlocks = function(Lines){
  env = grep("^.*(\\\\begin|\\\\end)\\{eqnarray[*]*\\}.*$", Lines)
  
  if(length(env) > 0){
    if(length(env) %%2 != 0)
      stop("Unequal lengths")
    
    nPairs = length(env) / 2  
 
    posnPairs = as.data.frame(matrix(env, nrow = nPairs, ncol = 2, byrow = TRUE))
    names(posnPairs) = c("begin","end")
    return(posnPairs)
  }else{
    return(NULL)
  }
}

removeEqnarray = function(Lines){
  changed = FALSE
  posnPairs = findEqnarrayBlocks(Lines)

  if(!is.null(posnPairs)){
    nPairs = nrow(posnPairs)
    removeLines = NULL
    
    for(p in 1:nPairs){
      b = posnPairs$begin[p]
      e = posnPairs$end[p]
      
      block = paste0(Lines[b:e], collapse = "\n")
      split.block = unlist(strsplit(block, "[\\]{2}"))
      m = length(split.block)
      
      if(m>=1){
        split.block = sapply(split.block, function(x)gsub("\\n","", x))
        cat(paste0("There are ", m, " lines in this block\n"))
        cat(paste0(split.block, "\n"))
#         newBlock = gsub("\\\\begin\\{eqnarray[*]\\}", "\\\\[", block)
#         newBlock = gsub("\\\\end\\{eqnarray[*]\\}", "\\\\]", newBlock)
#         newBlock = gsub("\\\\begin\\{eqnarray\\}", "\\\\begin\\{equation\\}", newBlock)
#         newBlock = gsub("\\\\end\\{eqnarray\\}", "\\\\end\\{equation\\}", newBlock)
#         newBlock = gsub("\\&", " ", newBlock)
#         newBlock = gsub("\\mathrm\\{([^}]+)\\}", "\\mbox{ \\1 }", newBlock)
#         cat(paste0(b, ": ", block, "\n"))
#         cat(paste0(b, ": ", newBlock, "\n"))
#         Lines[b] = newBlock
#         removeLines = c(removeLines, seq(from = b + 1, to = e)) ## keeps track of all the lines we need to discard
#         changed = TRUE
      }
    }
  }
  if(!changed){
    cat("Nothing to do\n")
    return(FALSE)
  }
  ##else
  return(list(Lines = Lines, removeLines = removeLines, Changed = changed))
}


eqnarrayToAlign = function(rng = 1:20, dummyRun = FALSE, root = "D:/curran/Books/Bill/IntroBayes"){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0(root, "/Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    removeEqnarray(Lines)
  }
}
    
