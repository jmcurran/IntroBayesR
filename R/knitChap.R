knitChap = function(rng = 1:20, root = "D:/Curran/Books/Bill/IntroBayes"){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = paste0(root, "/Chapter", part, "/")
    knitrfName = paste0(path, "Chapter", part, ".Rnw")
    texfName = paste0(path, "Chapter", part, ".tex")
    knit(knitrfName, texfName)
  }
}
