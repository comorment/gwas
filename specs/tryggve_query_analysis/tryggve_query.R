library(pracma)
library(stringr)
library(rmarkdown)

#run.arguments <- c("--queryAnalysis=a")

# Get the run arguments
run.arguments <- commandArgs(TRUE)

# Set the valid run parameters
valid.run.parameters <- c( "queryAnalysis","pheno","cont_var","bin_var","output", "help")

help_indicator<-0 # 1 for help 

#initialize variables

contVar=c()

# Loop each argument
for ( i in 1:length( run.arguments ) ) {
  
  # Validate if it has the --parameter=argument structure
  if ( strcmpi( substr( run.arguments[i], 1, 2 ), "--" ) & grepl( "=", run.arguments[i], fixed = TRUE) ) {
  
    # Identify which is the parameter or argument from the --parameter=argument pattern
    key.pair <- str_split( run.arguments[i], "=", simplify=TRUE )
    
    # Get the parameter from the --parameter=argument pattern
    run.parameter <- gsub( "--", "", key.pair[1] )
    
    # Get the argument from the --parameter=argument pattern
    run.argument <- key.pair[2]
    cat("a")
    # Validate if the parameter is among the valid run parameters
    if ( run.parameter %in% valid.run.parameters ) {
    
 
      if ( run.parameter=="queryAnalysis"){
      
      trait  <- run.argument  
      
      #cat(trait)
     
      }
      
      if ( run.parameter=="pheno"){
        
        phenoPath  <- run.argument  
        
        #cat(trait)
        
      }
      
      if ( run.parameter=="output"){
        
        outputName  <- run.argument  
        
        #cat(trait)
        
      }
      
      if ( run.parameter=="cont_var"){
        
        contVar  <- run.argument  
       
        #cat(trait)
        
      }
      
      if ( run.parameter=="bin_var"){
        
        binVar  <- run.argument  
        
        #cat(trait)
        
      }
      
      
      
      
    }
    

    
    
  }
  
  # Validate if it has the --argument structure
  else if ( strcmpi( substr( run.arguments[i], 1, 2 ), "--" ) ) {
    run.argument <- gsub( "--", "", run.arguments[i] )
    
    

    
    help_indicator=1;
    
  }
  
}


if (help_indicator==0){
  outputFile<- paste0(outputName,".Rmd")
  unlink(outputFile)
  file.copy('tryggve.query1.v2.Rmd',outputFile)  
render(outputFile,params=list(arg1='/INPUT',arg2='NOR',arg3=trait,arg4=phenoPath,arg5=contVar,arg6=binVar))
unlink(outputFile)
} else{
  render('tryggve.query1.v2_help.Rmd',params=list(arg1='/INPUT',arg2='NOR'))
  cat("\n \n \n \n")
  cat(" tryggve_query.R for Query Analysis of binary and quantative traits \n")
  cat("\n")
  cat("Help page is opened since you either typed '--help' OR you did not obey the basic usege rules. See below \n")
  cat("\n")
  cat("Usage:")
  cat("\n")
  cat("Rscript tryggve_query.R --queryAnalysis='Trait variable in phenoFile' --pheno='path/of/masterfile --cont_var='continious variable name seperated with comma and without tab' --bin_var='binary variable name seperated with comma and without tab'  --out=yourOutputName  \n ")
  cat("\n")
  cat("Example:")
  cat("\n")
  print(" Rscript tryggve_query.R --queryAnalysis='AnyF32' --pheno='/INPUT/NOR.tryggve.master.file.tsv' --cont_var='PC1,PC2,Age' --bin_var='AnyF33,AnyF32' --output=myout9 ")
  cat("\n")
  cat("NOTES")
  cat("\n")
  cat("-For this version --queryAnalysis only accepts binary trait. If you have a continious trait you can add it to --cont_var")
  cat("\n")
  cat("\n")
  cat("-Make sure that there is not any space between variables-> accepted format is 'PC1,PC2' not 'PC1, PC2'  ")
  cat("\n")
  cat("\n")
  cat("-Query output is created as a .html file in current directory (getwd())")
  cat("\n")
  cat("\n")
  cat("-Specifications of the masterfile have been explained in help.html file")
  cat("\n")
}