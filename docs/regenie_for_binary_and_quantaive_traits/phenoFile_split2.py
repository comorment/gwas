#!/usr/bin/python

import sys, getopt
import pandas as pd

def main(argv):
   masterfile = ''
   sep = ''
   trait = ''

   try:
      opts, args = getopt.getopt(argv,"m:s:t:o",["masterfile=","seperator=","columns=","outname="])
   except getopt.GetoptError:
      print ('Example')
      print("  python phenoFile_split.py  --masterfile='NOR2.tryggve.master.file.tsv' --seperator='tab'  --columns='Sex','tcb_mddLife','PC1' --outname='myout'   ")
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print ('test.py -i <inputfile> -o <outputfile>')
         sys.exit()
      elif opt in ("-m","--masterfile"):
         masterfile = arg
      
      elif opt in ("-s", "--seperator"):
         sep = arg   
      
      elif opt in ("-t", "--columns"):
         trait = arg   
         
      elif opt in ("-o", "--outname"):
         outs = arg   
           
         dm=pd.read_csv(masterfile, delimiter='\t')
         for i, x in enumerate(dm.tcb_pheno):
           folder= dm.tcb_folder[i] 
           famfile=dm.tcb_folder[i]+ '/' +dm.tcb_plink[i]+ '.fam'
           phenofile=dm.tcb_folder[i]+'/'+dm.tcb_pheno[i]
           if sep=='tab': 
               seperator='\t' 
               phenoextract(folder,famfile,phenofile,trait,seperator,outs)
           if sep=='comma': 
               seperator=',' 
               phenoextract(folder,famfile,phenofile,trait,seperator,outs)
       
        
def phenoextract(folder,famfile,phenofile,trait,seperator,outs):
    
    df1=pd.read_csv((phenofile), delimiter=seperator)
    df2=pd.read_csv((famfile), names=['FID', 'IID', 'c','d', 'e', 'f'], delimiter=" ")
    dff=pd.merge(df1,df2, on='IID', how='inner')
    
    dff2=dff['IID']
    
    
    cols = list(dff)   
    
    for i in range(len(cols)):
        if cols[i]=='FID_x': dff=dff.rename(columns={"FID_x": "FID"}) 
    
    #print(type(trait))
    trait=trait.split(",")
    
    for i in range(len(trait)):
      dff2=pd.concat([dff2,dff[trait[i]]],axis=1)

    import shutil
    backup=phenofile+'backup'+'.txt'
    shutil.copyfile(phenofile,backup)
    #import os
    #os.remove(phenofile)
    

    cols=list(dff2)

    
    



    dff3=dff2
    
    cols.remove('IID')
    cols.remove('FID')
    
    cols.insert(0,'IID')
    cols.insert(0,'FID')
    
    

    dff3=dff3.reindex(columns=cols)
    
    df_reorder=dff3.reindex(columns=cols)

    outfile=folder+'/'+outs+'.txt'
    df_reorder.to_csv(outfile, header=True, index=False, sep='\t', mode='a')
    
      #output=outs+'.txt'
      #dff2.to_csv(output, header=True, index=False, sep='\t', mode='a')
    
if __name__ == "__main__":
   main(sys.argv[1:])
