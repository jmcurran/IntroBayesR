writeBackup = function(src, path, dummyRun = FALSE){
  ## get all the backup files
  bkupFiles = list.files(path = path, pattern = paste0("^", src, "\\.*bak[0-9]*"))
  bkupNum = 1
  
  if(any(grepl("^.*bak[0-9]+$", bkupFiles))){
    bkupFiles = bkupFiles[grepl("^.*bak[0-9]+$", bkupFiles)]
    bkupNum = max(as.numeric(gsub("^.*bak([0-9]+)$", "\\1", bkupFiles))) + 1
  }
  
  dest = paste0(path, src, ".bak", bkupNum)
  src = paste0(path, src)
  cmd = paste0("cp ", src, " ", dest)
  cat(paste0(cmd, "\n"))
  if(!dummyRun)
    system(cmd)
}
