library(clockify)
CLOCKIFY_API_KEY <- Sys.getenv("CLOCKIFY_API_KEY")
set_api_key(CLOCKIFY_API_KEY)

user()
users()

wksp <- workspaces()
workspace(as.character(subset(wksp, name == "Zivan Karaman's workspace", select = workspace_id)))
clients()
projects()
tags()
