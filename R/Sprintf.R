Sprintf = function(fmt, ...){
  strOut = sprintf(fmt, ...)
  if(any(grepl("^0\\..+$", strOut))){
    strOut = gsub("([^0-9])*0(\\.[0-9]+)", "\\1\\2", strOut)
  }
  return(strOut)
}