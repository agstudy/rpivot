library(data.table)

## write.table(dat,"input.csv",row.names=FALSE,sep=",")
dump_date <- "2015-07-03"
dat <- fread("input.csv")

format.inout <-
  function(date,check)
    as.POSIXct(paste(date,gsub(".* (.*)","\\1",check)))


XX <- dat[nzchar(CHECKIN) & !is.na(Member.ID),
          list(ID=Member.ID,
               Date=Visit..Created.Date,
               Checkin= format.inout(Visit..Created.Date,CHECKIN),
               Checkout=format.inout(Visit..Created.Date,CHECKOUT))
          ]



format_checkout <-
  function(checkin,checkout){
    dd <- (checkout-checkin)
    replace(checkout,dd<0,checkout[dd<0]+24*60*60)

  }


DUMP <- XX[,Checkout := format_checkout(Checkin,Checkout)]




find_overlaps <-
  function(DUMP){
    if(nrow(DUMP)>0){
      btime <- as.POSIXct(paste(dump_date,"05:30:00"))
      etime <- as.POSIXct(paste(dump_date,"23:45:00"))
      start <- seq.POSIXt(btime,etime,by="15 mins")
      end <- start +15*60
      DX <- data.table(Checkin=start,Checkout=end)
      ##setkey(DX,Checkin,Checkout)
      setkey(DUMP,Checkin,Checkout)
      data.table(DX,
                 foverlaps(DX,DUMP,type="within",nomatch=0,which=TRUE)[,.N,by=xid])
    }
  }


RES <- XX[,find_overlaps(copy(.SD)),Date]
library(ggplot2)

ggplot(RES,aes(x=Checkin,y=N)) +
  geom_bar(,stat="identity",
           fill=rgb(0,0,1,0.5)) +
  theme_bw() +
  ggtitle(paste("Gym Occupancy \n" ,dump_date)) +
  xlab("checkin/checkout") + ylab("Occupancy") +
  geom_smooth()









