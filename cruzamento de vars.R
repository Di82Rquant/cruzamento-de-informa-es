#cruzamento de informações
require(quantmod)
require(data.table)
require(PerformanceAnalytics)
require(TTR)
startDate <- as.Date("2018-08-02")
endDate   <- as.Date("2019-12-12")
tickers   <-  c("^BVSP","PETR4.SA")
    getSymbols(tickers,src = "yahoo",from = startDate, to = endDate)
# criando var corpo
    BVSP$corpo <- BVSP$BVSP.Close - BVSP$BVSP.Open
summary(BVSP$corpo)    
#separando por quartis
BVSP$corpoCategorias <- ifelse(BVSP$corpo > 800.00,"3rd_quart.","< 3rd_quart.")
# separando por volume
BVSP$BVSP.VolumeCategorias <- ifelse(BVSP$BVSP.Volume > 4922400,
    "vol3rd_quartil.","< vol3rd_quartil")
# cruzando as informações
table(BVSP$BVSP.VolumeCategorias,BVSP$corpoCategorias)
#proporção

#coluna horizontal
tablela <- table(BVSP$BVSP.VolumeCategorias,BVSP$corpoCategorias)
prop.table(tablela)
#coluna vertical
 prop.table(tablela,2)
# organizando as casas decimais
 round(prop.table(tablela,1)*100,2)#100 para porcentagem e 2 para n: de casas decimais
#observando chi square contribution com cross.table
 require(gmodels)
CrossTable(BVSP$BVSP.VolumeCategorias,BVSP$corpoCategorias,digits = 2,expected = T) 
