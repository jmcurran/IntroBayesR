setFileNames = function(i, root){
  part = path = fName = NULL
  
  i = match.arg(i, c(1:20, LETTERS[1:4], "S"))
  
  if(i %in% as.character(1:20)){
    i = as.numeric(i)
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = paste0(root, "/Chapter", part, "/")
    fName = paste0("Chapter", part, ".Rnw")
  }else if(grepl("[A-D]",i)){
    part = gsub("^.*([A-D]).*$", "\\1", i)
    path = paste0(root, "/Appendix", part, "/")
    fName = paste0("Appendix", part, ".Rnw")
  }else if(grepl("(S|Sel|sel)", i)){
    part = "SelectedAnswers"
    path = paste0(root, "/SelectedAnswers/")
    fName = "SelectedAnswers.Rnw"
  }
  
  if(is.null(fName)){
    stop(paste0("Input: ", i, " is invalid\n"))
  }
  
  l = list(part = part, path = path, fName = fName, 
           fullName = paste0(path, fName))
  class(l) = "fileInfo"
  
  return(l)
}