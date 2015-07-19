library(rpivot)
fields = list(
  list(name= '0', caption= 'Entity' ),
  list(name= '1', caption= 'Product' ),
  list( name= '2', caption= 'Manufacturer', sort= list( order= 'asc' ) ),
  list( name= '3', caption= 'Class' ),
  list( name= '4', caption= 'Category', sort= list( order= 'desc' ) ),
  list( name= '5', caption= 'Quantity' ),
  list(
    name= '6',
    caption= 'Amount',
    dataSettings= list(
      aggregateFunc= 'avg'
    )
  )
)

path <- system.file("tests","data","testData.csv",package="rpivot")
data = read.csv(path,header=FALSE,stringsAsFactors=FALSE)


rpivot(data,fields=fields)
