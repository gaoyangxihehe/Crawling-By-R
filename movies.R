url <-'http://movie.douban.com/top250?format=text'
# 获取网页原代码，以行的形式存放在web 变量中
web <- readLines(url,encoding="UTF-8")
# 找到包含电影名称的行
name <- str_extract_all(string = web, pattern = '<span class="title">.+</span>')
movie.names_line <- unlist(name)
# 用正则表达式来提取电影名
movie.names <- str_extract(string = movie.names_line, pattern = ">[^&].+<") %>% 
    str_replace_all(string = ., pattern = ">|<",replacement = "")
movie.names <- na.omit(movie.names)
# 获取评价人数
Rating <- str_extract_all(string = web,pattern = '<span>[:digit:]+人评价</span>')
Rating.num_line <- unlist(Rating)
Rating.num <- str_extract(string = Rating.num_line, pattern = "[:digit:]+") %>% as.numeric(.)
# 获取评价分数
Score_line <- str_extract_all(string = web, 
                              pattern = '<span class="rating_num" property="v:average">[\\d\\.]+</span>')
Score_line <- unlist(Score_line)
Score <- str_extract(string = Score_line, pattern = '\\d\\.\\d') %>% as.numeric(.)
# 数据合并
MovieData <- data.frame(MovieName = movie.names,
                        RatingNum = Rating.num,Score = Score,
                        Rank = seq(1,25),stringsAsFactors = FALSE)
# 可视化
library(ggplot2)
ggplot(data = MovieData, aes(x = Rank,y = Score)) + 
    geom_point(aes(size = RatingNum)) + 
    geom_text(aes(label = MovieName),colour = "blue", size = 4, vjust = -0.6)





