library(clockify)
CLOCKIFY_API_KEY <- Sys.getenv("CLOCKIFY_API_KEY")
set_api_key(CLOCKIFY_API_KEY)

# get tags
wksp <- workspaces()
workspace(as.character(subset(wksp, name == "Zivan Karaman's workspace", select = workspace_id)))
my_tags <- tags()

# copy tags to new workspace
workspace(as.character(subset(wksp, name == "KfW", select = workspace_id)))
for (i in 1:nrow(my_tags)) {
  tag_create(my_tags$name[i])
}
tags()

# # copy tags to new workspace
# workspace(as.character(subset(wksp, name == "Elia", select = workspace_id)))
# for (i in 1:nrow(my_tags)) {
#   tag_create(my_tags$name[i])
# }
# tags()
