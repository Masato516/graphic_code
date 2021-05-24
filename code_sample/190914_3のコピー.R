#ggplot2の呼び出�?
library(ggplot2)

#�?ータ読み込み
x <- read.csv("190914_3.csv")
x <- transform(x,group=factor(group, levels=c("Sham","Den")))

#ベ�?�スの棒グラフ作�?? (fに収�?)
f <-ggplot(x,aes(x=x, y=y, fill=group))
  
f <- f + stat_summary(color="black",fun.y="mean",geom="bar", size=.3, width=.75, position="dodge")
f <- f + stat_summary(fun.data="mean_se",geom="errorbar",size=0.4,width=0.4, position=position_dodge(w=.8))
f <- f + geom_point(position=position_jitterdodge(jitter.width=.5, dodge.width=.8), size=.1)

#y軸の設�?
f <- f + scale_y_continuous(breaks=seq(0,1000,by=1), expand=c(0,0)) + coord_cartesian(ylim = c(0, 5.1))
#x軸のカ�?ゴリ要�?の�?番を変更
f <- f + scale_fill_manual(values=c("grey85","red"))
#背景、補助線消去、枠線�?�設�?
f <- f + theme_bw() + theme(panel.grid.major = element_blank()) + theme(panel.grid.minor = element_blank()) + theme(panel.border = element_blank(), axis.line = element_line(colour="black", size=0.5)) + theme(axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.ticks.y = element_line(colour="black", size=0.5))
#軸�?キスト�?�字体変更
f <- f + theme(axis.text=element_text(size=7, face="bold", family="Times", colour="black"))
#y軸�?キスト削除
f <- f + theme(axis.title.y=element_blank())+theme(axis.text.x=element_blank())
#凡�?
f <- f+theme(legend.position=c(.6,.75), legend.justification=c(0,0)) + theme(legend.title=element_blank()) + theme(legend.text=element_text(family="Times",size=7)) + theme(legend.key.height=unit(0.25,"cm"),legend.spacing=unit(0.5,"cm"))
#出�?
ggsave("190914_3_denervation 7 days_sol muscle_atrophy.tiff", width=4, height=3.5, units="cm")
