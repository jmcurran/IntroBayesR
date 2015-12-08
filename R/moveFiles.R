# for(i in 1:20){
#   cmd = paste0("mkdir Chapter_", ifelse(i < 10, "0", ""), i)
#   system(cmd)
#   cmd = paste0(cmd, "/figures")
#   system(cmd)
# }
# 
# for(i in 1:20){
#   f1 = paste0("3eChapter", ifelse(i < 10, "0", ""), i, ".tex")
#   path = paste0("Chapter_", ifelse(i < 10, "0", ""), i)
#   f2 = paste0("Chapter", ifelse(i < 10, "0", ""), i, ".tex")
#   cmd = paste0("mv ", f1, " ", path, "/", f2)
#   cat(paste(cmd, "\n"))
#   system(cmd)
# }
# 
# Files = list.files(pattern = "^([Nn]ew)*[Ff]igure.*(ps|eps|mgf|pdf)$")
# 
# for(f1 in Files){
#   chapter = gsub("^([Nn]ew)*[Ff]igure([0-9]{2}).*(ps|eps|mgf|pdf)$", "\\2", f1)
#   appendix = gsub("^([Nn]ew)*[Ff]igure([BAa]).*(ps|eps|mgf|pdf)$", "\\2", f1)
#   
#   isChapter = FALSE
#   isAppendix = FALSE
#   
#   if(grepl("^[0-9]{2}$", chapter) && !grepl("^[BAa]$", appendix)){
#     isChapter = TRUE
#   }else{
#     isAppendix = TRUE
#   }
#   
#   cmd = ""
#   
#   if(isChapter & !isAppendix){
#     path = paste0("Chapter", chapter, "/figures")
#     f2 = paste0(gsub("\\.", "-", gsub("(^.*)\\.pdf", "\\1", f1)), ".pdf")
#     cmd = paste0("mv ", f1, " ", path, "/", f2)
#     cat(paste(cmd, "\n"))
#   }else if(isAppendix & !isChapter){
#     path = paste0("Appendix", appendix, "/figures")
#     f2 = paste0(gsub("\\.", "-", gsub("(^.*)\\.pdf", "\\1", f1)), ".pdf")
#     cmd = paste0("mv ", f1, " ", path, "/", f2)
#     cat(paste(cmd, "\n"))
#   }else{
#     cat(paste0("Error ", f1, "\n"))
#   }
#   
#   system(cmd)
# }
# 
# 
