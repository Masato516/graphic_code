library(ggplot2)
dat2<-read.csv("191101_3.csv")
attach(dat2)
p <- ggplot(dat2, aes(x=x, y=y))+geom_point(aes(shape=group), size=1)+stat_smooth(method=lm, colour="black", size=.5)
p <- p + facet_wrap(~x_title, scales="free_x", ncol=5)
p <- p + scale_y_continuous(breaks=seq(0,100000,by=0.4),expand=c(0,0),limits=c(.2, 1.4))
p <- p + theme(axis.text=element_text(size=7, face="bold", family="Times", colour="black"), panel.border=element_rect(fill=NA), panel.background=element_blank()) + theme(strip.text=element_text(size=0, face="bold", family="Times", colour="black"), legend.text=element_text(size=7, face="bold", family="Times", colour="black"), legend.title=element_blank())
p <- p + scale_shape_discrete(limits=c("Sham","Den"))
p <- p + theme(axis.title=element_blank())
p <- p+theme(legend.position=c(1,1), legend.justification=c(0,0)) + theme(legend.title=element_blank()) + theme(legend.text=element_text(family="Times",size=7)) + theme(legend.key.height=unit(0.25,"cm"),legend.key.height=unit(0.03,"cm"),legend.margin=unit(0.5,"cm"))
p

#出力
ggsave("191101_3_Correlation_mtco1 & average mito translation_den 7d_sol muscle.tiff", width=14.2, height=3.6, units="cm")

