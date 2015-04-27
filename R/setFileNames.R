setFileNames = function(i, root){
  part = path = fName = NULL
  
  if(is.numeric(i)){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = paste0(root, "/Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
  }else if(is.character(i) & grep("[A-D]",i)){
    part = gsub("^.*([A-D]).*$", "\\1", i)
    path = fName = paste0(root, "/Appendix", part, "/")
    fName = paste0("Appendix", part, ".tex")
  }
  
  if(is.null(fName)){
    stop(paste0("Input: ", i, " is invalid\n"))
  }
  
  l = list(part = part, path = path, fName = fName, 
           fullName = paste0(path, fName))
  class(l) = "fileInfo"
  
  return(l)
}