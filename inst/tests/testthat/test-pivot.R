context("test pivot config")

path <- system.file("tests","data","testData.csv",package="rpivot")
testdata = read.csv(path,header=FALSE)

test_that("<Grand Total>", function() {

  q. = pivot$query(testdata)
  expect_false(is.null(q.$val(6)))

})
