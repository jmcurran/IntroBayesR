
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
