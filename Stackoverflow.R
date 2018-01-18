stackflow <- function(page){
    url <- "http://stackoverflow.com/questions/tagged/"
    require(rvest)
    u <- paste(url,"r?page=",as.character(page),"&sort=votes&pagesize=15",sep="")
    html <- read_html(u)
    t <- list(title = html %>% html_nodes(xpath="//div[@class='summary']/h3") %>% html_text(),
               vote = html %>% html_nodes(".vote-count-post") %>% html_text() %>% as.numeric(),
               answer = html %>% html_nodes(xpath="//div[@class='stats']/div[2]/strong") %>% html_text() %>% as.numeric(),
               views = html %>% html_nodes(xpath="//div[@class='statscontainer']/div[3]") %>% 
                  html_attr("title") %>% str_extract_all(pattern="[\\d\\,]+") %>% 
                  str_replace_all(pattern="\\,+",replacement="") %>% as.numeric()
    )
    t <- as.data.frame(t)
    return(t)
}
lapply(1, stackflow)
