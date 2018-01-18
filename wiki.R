url <- "http://baike.baidu.com/item/%E8%8A%B1%E5%84%BF%E4%B8%8E%E5%B0%91%E5%B9%B4/13572794"
page <- read_html(url)
tables <- page %>% html_nodes("table[log-set-param=table_view]") %>% html_table(fill = T)
table <- tables[3][[1]]
cast <- as.data.frame(str_split_fixed(table[,1], pattern = "\n", 4))
cast <- cbind(cast, table[, 2])
cast$V4 <- str_replace_all(cast$V4, "\\d|\\[|\\]", "")
View(cast)
