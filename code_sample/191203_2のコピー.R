library(ggplot2)
#データの読み込み
x<-read.csv("191203_2.csv")
#groupをfactorに変更（データに合わせてgroup nameを入力する）
x<-transform(x,group=factor(group, levels=c("Sham","Den")))
#キャンパスの用意、fに格納
f<-ggplot(data=x, aes(x=group, y=y, fill=group))
#violin
f<-f+geom_violin(color="grey65",size=.5)+scale_fill_manual(values=c("white","grey92"))
# line
f<-f+geom_line(aes(group=individual),size=.2)
#individual plot
f<-f+geom_point(size=.1)
#theme_classicを設定
f<-f+theme_classic()
#xy軸
f<-f+theme(axis.line = element_line(colour="black", size=.5))
#軸の目盛り(ticks)
f<-f+theme(axis.ticks.x = element_blank(), axis.ticks.y = element_line(colour="black", size=.5))
#軸のテキスト
f<-f+ theme(axis.title = element_blank(),axis.text.y=element_text(size=7, face="bold", family="Times", colour="black"), axis.text.x=element_blank())
#facetで変数xごとにわける, facet間隔の設定 & xのタイトル表示を削除
f<-f+facet_grid(.~x)+theme(panel.spacing.x=unit(.2,"lines"))+theme(strip.text=element_blank()) 
#x軸の設定
f <- f + scale_x_discrete(expand=c(.4,.4))
#y軸の設定(データに合わせて上限と目盛り間隔を設定する)
f <- f + scale_y_continuous(breaks=seq(0,10000,by=1), expand=c(0,0)) + coord_cartesian(ylim = c(0, 2.1))
#凡例の字
f<-f+theme(legend.title=element_blank(),legend.text=element_text(family="Times",size=7,colour="black",face="bold"))
#凡例の大きさ、字とのスペース、グラフとのスペース
f<-f+theme(legend.key.height=unit(.1,"cm"),legend.key.width=unit(.3,"cm"),legend.spacing.x=unit(.1,"cm"), legend.box.spacing=element_blank())
#凡例の位置
f<-f+theme(legend.position="top")
#確認
f
#出力
ggsave("191203_2_paired violinplot_wb mito translation_den 7.tiff", width=10, height=4.5, units="cm")

