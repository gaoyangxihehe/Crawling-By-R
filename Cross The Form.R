formurl <- "http://open.xmu.edu.cn/oauth2/authorize?client_id=1010&response_type=code"
session <- html_session(formurl) 
#创建会话
form <- html_form(session) 
#得到网页内的所有表单，以list形式返回
str(form)
form <- form[[1]] 
#提取我们想要的表单
UserName <- "*******" #这里填写你自己的学号
Password <- "*******" #这里把password替换成你自己的密码
form <- set_values(form,'UserName'=UserName,'Password'=Password) 
#填写表单内容
out_url <- submit_form(session,form,submit=NULL) 
#在会话中提交表单，实现表单穿越
class(out_url)
session2 <- follow_link(out_url,'Advanced Econometrics')
course.info <- session2 %>% html_nodes("ul.section") %>% html_text() 
#爬取属性为section的ul节点，获取其下面列表的所有文本内容
cat(course.info[1])
