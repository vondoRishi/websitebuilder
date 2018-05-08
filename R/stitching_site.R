#' Prepares the site
#'
#' Generates navigation bar as defined in ymlFile , inserts the navigation bar of every local html files defined in yml file and available inside htmlFilePath.
#'
#' @param ymlFile path to yml file which defines the site
#' @param htmlFilePath directory path to all html files ( default current working directory)
#'
#' @return Generates html files with navigation bar in the output_dir as defined in yml file
#' @export
#'
#' @examples prepareSite(ymlFile = "site.yml")
prepareSite<-function(ymlFile,htmlFilePath=getwd()){
  inputPath<<-htmlFilePath
  config<<-yaml::yaml.load_file(input = ymlFile)
  createDir(config$output_dir)
  navHtml<<-mySite_generator(config)
  if(!is.null(config$navbar$left))
    buildHtml(config$navbar$left)
  if(!is.null(config$navbar$right))
    buildHtml(config$navbar$right)

  rm(navHtml,inputPath,config,envir = globalenv())
}

createDir<-function(dirPath){
  if(dir.exists(dirPath)){
    stop("Output directory already exists!!!")
  }else{
    dir.create(dirPath)
  }
}

buildHtml<-function(side){ ## Insert navbar and footer

  for(i in 1:length(side)){
    htmlText <- getHtml(side[[i]])
    if(!is.null(htmlText)){
      copyToSiteDir(side[[i]]$href,htmlText)
    }
  }

}

copyToSiteDir<-function(fileName,htmlText){
  body_ind <- grep("<body>",htmlText)
  pandoc_ind <- grep("pandoc",htmlText) ## is it a pandoc genereted html which may include bootstrap library already
  print(paste(fileName,pandoc_ind,length(pandoc_ind)>0))
  finalFile<- c(htmlText[0:body_ind],navHtml,htmlText[(body_ind+1):length(htmlText)])
  writeLines(finalFile,con=file.path(config$output_dir,fileName))
}

getHtml<-function(confiText){

  # print(confiText$text)
  if(is.null(confiText$menu)){
    return((
      if(!is.null(confiText$href) && file.exists(confiText$href)){
        prepareHtml(confiText$href)
      }
      ))
  } else {
    buildHtml(confiText$menu)
    return(NULL)
  }
}

prepareHtml <- function(fileName){
  x<-readLines(file.path(inputPath,fileName))
  return(x)

}

