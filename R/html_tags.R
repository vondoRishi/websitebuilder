mySite_generator <- function(site_config){

  return(paste(
    '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script> 
  function loadbootStrap(){
    var script = document.createElement("script");
    script.src = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js";
    document.body.appendChild(script);
  }
  if( typeof jQuery === "undefined" ) {
    var script = document.createElement("script");
    script.src = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js";
    script.onload = function () {
      loadbootStrap();
    };
    document.body.appendChild(script);
  }
</script>

<script> 
  if( typeof $.fn.dropdown === "undefined" ) {
    loadbootStrap();
  }
</script>
    ',
    '<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
    ',
    '<div class="navbar navbar-default  navbar-fixed-top" role="navigation">
    <div class="container">',
    getNavHeader(site_config$navbar), # navbar-header
    getNavbar(site_config$navbar), # div navbar < includes left and right
    '  </div><!--/.container -->
    </div><!--/.navbar -->',
    '<style type="text/css">
    /* padding for bootstrap navbar */
    body {
    padding-top: 51px;
    padding-bottom: 40px;
    }
    /* offset scroll position for anchor links (for fixed navbar)  */
    .section h1 {
    padding-top: 56px;
    margin-top: -56px;
    }

    .section h2 {
    padding-top: 56px;
    margin-top: -56px;
    }
    .section h3 {
    padding-top: 56px;
    margin-top: -56px;
    }
    .section h4 {
    padding-top: 56px;
    margin-top: -56px;
    }
    .section h5 {
    padding-top: 56px;
    margin-top: -56px;
    }
    .section h6 {
    padding-top: 56px;
    margin-top: -56px;
    }
    </style>
    ',
    sep = ""
  ))

}

getNavHeader<-function(navbar){
  return(
    paste('<div class="navbar-header">
          <a class="navbar-brand" href="',navbar$left[[1]]$href,'">',navbar$title,'</a>
          </div>',sep = "")
    )
}

getNavbar<-function(navbar){
  return(paste(
    '<div id="navbar" class="navbar-collapse collapse">',
    getUL(navbar$left," "),
    getUL(navbar$right,"navbar-right"),
    '</div><!--/.nav-collapse -->'
    ,sep = ""))
}

getUL<-function(side,sideClass){

  return(paste(
    '<ul class="nav navbar-nav ',sideClass,' ">
    ',
    getListText(side),#lapply(side,getText),
    '
    </ul>'
    ,sep = ""))
}

getListText <- function(side) {
  listText <- '';
  for(i in 1:length(side)){
    listText <- paste(listText,getText(side[[i]]))
  }
  return(listText)
}

getText<-function(confiText){
  if(is.null(confiText$menu)){
    return((
      ifelse(is.null(confiText$href),
             paste(' <li>
                   <span class="fa ',confiText$icon,'"></span>',confiText$text,
           '
           </li>',sep=""),
      paste(' <li>
            <a href="',confiText$href, '">',
      '<span class="fa ',confiText$icon,'"></span>',confiText$text,
  '
  </a>
  </li>',sep = ""))
    ))
  } else {
    return(paste(
      '<li class="dropdown">
      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
      <span class="fa ',confiText$icon,'"></span>',confiText$text,
          '<span class="caret"></span>
      </a>
      <ul class="dropdown-menu" role="menu">',
      getListText(confiText$menu),
        '</ul>
      </li>'
      ,sep = ""))
  }
}
