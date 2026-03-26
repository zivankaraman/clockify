library(clockify)
set_api_key(Sys.getenv("KFW_CLOCKIFY_API_KEY"))
# set_api_key(Sys.getenv("ELIA_CLOCKIFY_API_KEY"))

from <- as.Date("2026-01-01")
to <- as.Date("2026-03-31")
worked_entries <- time_entries(start = from, end = to, concise = FALSE)

all_projects <- projects(concise = TRUE)
worked_projects <- subset(all_projects, project_id %in% unique(worked_entries$project_id))

l <- lapply(worked_projects$project_id, \(p) tasks(project_id = p))
prj_tasks <- do.call(rbind, l)
worked_tasks <- subset(prj_tasks, task_id %in% worked_entries$task_id)

worked_tasks <- worked_tasks[, c("project_id", "task_id", "name")]
names(worked_tasks) <- c("project_id", "task_id", "task_name")

worked_projects <- worked_projects[, c("project_id", "project_name")]
merge(worked_projects, worked_tasks)

# worked_entries <- worked_entries[, c("project_id", "task_id", "description", "time_start", "time_end", "duration")]
detail <- worked_entries[, c("project_id", "task_id",  "duration")]
detail$duration <- detail$duration / 60
aggreg <- aggregate(duration ~ ., data = detail, FUN = sum)
final <- merge(merge(worked_projects, worked_tasks), aggreg)
final <- final[, c("project_name", "task_name", "duration")]
names(final) <- c("Milestone", "Issue", "Hours_worked")
# openxlsx::write.xlsx(final, "hours_worked.xlsx", asTable = TRUE)
