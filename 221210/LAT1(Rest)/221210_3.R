# 作業ディレクトリの確認
getwd()
# ggplot2の呼び出し
library(ggplot2)
# データ読み込み
Dataset <- read.csv("221210.csv")
# timingをfactorに変更（棒グラフの並び順をPre->Post設定）
Dataset <- transform(Dataset,
                     timing = factor(timing,
                                   levels = c("Pre","Post")))
# groupをfactorに変更（棒グラフの並び順をPla->Wheyに設定）
Dataset <- transform(Dataset,
                     group = factor(group,
                                    levels = c("Pla","Whey")))
# ベース（縦軸ラベル名、横軸名ラベル名、キャンパス）の作成、fに格納
f <- ggplot(data=Dataset,
            aes(x    = timing,
                y    = measurement,
                fill = timing))
# TODO: facetのラベルが消せない!!
# group(Pla, Whey)毎に分ける
f <- f + facet_wrap(~group)
# bar graphの設定
f <- f + stat_summary(color    = "black",
                      fun      = "mean",
                      geom     = "bar",
                      size     = .5,
                      width    = .75,
                      position = "dodge2")
# bar graphの色
f <- f + scale_fill_manual(values=c("white", "grey60"))
# # error barの設定
# f <- f + stat_summary(fun.data = "mean_sdl",
#                       # defaultでは2*SDになるので、1*SDになるよう設定
#                       fun.args = list(mult = 1),
#                       geom     = "errorbar",
#                       size     = 0.4,
#                       width    = 0.4)
# individual plot
f <- f + geom_point(size=1.2,
                    shape=16)
# line
f <- f + geom_line(aes(group=id), size=.2)
# 背景、補助線消去、枠線の設定
f <- f + theme_bw() +
         theme(panel.grid.major = element_blank(),
               panel.grid.minor = element_blank(),
               panel.border     = element_blank(),
               axis.line        = element_line(colour="black", size=0.5),
               axis.ticks.x     = element_blank(),
               axis.title.x     = element_blank(),
               axis.ticks.y     = element_line(colour="black", size=0.5))
# 軸のテキストの字体変更
f <- f + theme(axis.text=element_text(size   = 10,
                                      face   = "bold",
                                      family = "Times",
                                      colour = "black"))
# y軸のテキスト削除
f <- f + theme(axis.title.y = element_blank(),
               axis.text.x  = element_blank())
# y軸の設定
f <- f + scale_y_continuous(breaks = seq(0, 1000, by=0.5),
                            expand = c(0,0)) +
         coord_cartesian(ylim = c(0, 5.1))
# 凡例の字
f <- f + theme(legend.title = element_blank(),
               legend.text  = element_text(family = "Times",
                                           size   = 8,
                                           colour = "black",
                                           face   = "bold"))
# # 凡例の設定(大きさ、字とのスペース、グラフとのスペース、位置)
# f <- f + theme(legend.position    = "top"#,
#                # legend.key.height  = unit(0.25, "cm"),
#                # legend.key.width   = unit(0.8, "cm"),
#                # legend.spacing.x   = unit(0.5, "cm")#,
#                # legend.box.spacing = element_blank()
#                )
# 確認
f
# 保存
ggsave("221210_Fig.tiff")
