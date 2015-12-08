print.fileInfo = function(x, ...){
  cat(paste0("Part: ", x$part, "\n"), ...)
  cat(paste0("Path: ", x$path, "\n"), ...)
  cat(paste0("File Name: ", x$fName, "\n"), ...)
  cat(paste0("Fully qualified file path: ", x$fullName, "\n"), ...)
}