library("rvest")
page <- read_html("https://cran.rstudio.com/web/packages/available_packages_by_name.html")
#第一种方法
pkg_table <- page %>% html_table(fill = T)  
class(pkg_table)
# 返回list，这个list应该包含了网页中的所有table
# 但因为整个网页就只有一个table，所以我们要找的表格就在第一个list中
pkg_table <- pkg_table %>% as.data.frame()
# 转化为数据框才能数据进行缺失值处理
head(pkg_table)
#第二种方法
pkg_table <- page %>% html_node('table') %>% html_table(fill=TRUE) 
class(pkg_table)
# 返回数据框
# 由于原表格没有表头(没有<th>标签)，因此数据框使用默认的表头X1,X2代替
# 使用fill=T，会自动填补行列中的缺失值，比如这里的第一行
dim(pkg_table)
# 删除缺失值
pkg_table <- pkg_table[complete.cases(pkg_table), ]
# 定义表头
colnames(pkg_table) <- c("name","title")
head(pkg_table,3)
