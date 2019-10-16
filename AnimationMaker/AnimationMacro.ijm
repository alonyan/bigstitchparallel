//close all open windows
close("*");
//optional - user input dir
dir=getDirectory("Select the directory"); 
//dir = "/RazorScopeData/RazorScopeSets/Jen/CorneaWound/CorneaWound_HetHet_2019Feb04/acq_2/Fused/";
//make list of all tif files in dir that match a pattern
strPattern = "tp_0_ch_1";
filesThatMatch=newArray(0); 
list=getFileList(dir); 

for(i=0;i<list.length;i++){ 
if(endsWith(list[i],".tif")&&indexOf(list[i],strPattern)>0){ 
        filesThatMatch=Array.concat(filesThatMatch,list[i]); 
        } 
} 


sortOrder=newArray(0);
minLength=lengthOf(filesThatMatch[0]);
maxLength=lengthOf(filesThatMatch[0]);
for(i=0;i<filesThatMatch.length;i++){
	sortOrder=Array.concat(sortOrder,0);
	minLength = minOf(minLength,lengthOf(filesThatMatch[i]));
	maxLength = maxOf(maxLength,lengthOf(filesThatMatch[i]));
}
print(minLength);
print(maxLength);
counter=0;

for(j=minLength; j<=maxLength; j++){
for(i=0;i<filesThatMatch.length;i++){
    if(lengthOf(filesThatMatch[i])==j){
	sortOrder[i]=counter;
	counter++;
}
}
}
filesThatMatchSorted = Array.copy(filesThatMatch);
for(i=0;i<filesThatMatch.length;i++){
	for(j=0;j<sortOrder.length;j++){
		if(i==sortOrder[j]){
			filesThatMatchSorted[i] = filesThatMatch[j];
		}		
	}
}
for(i=0;i<filesThatMatch.length;i++){
	print(filesThatMatchSorted[i]);
}



//run over all these files and do whatever animations. 
for(f=0;f<filesThatMatchSorted.length;f++){ 
	close("*");
        fName = filesThatMatchSorted[f]; 
 
fullpath = dir + fName;
open(fullpath);
selectWindow(fName);
nS = nSlices;

setSlice(round(nS/2));
//run("Brightness/Contrast...");    
setMinAndMax(38, 1000);
run("Apply LUT", "stack");
run("Enhance Contrast", "saturated=0.75");
run("Apply LUT", "stack");
//run("8-bit");


run("Batch Animation", "browse=/RazorScopeData/RazorScopeSets/Jen/CorneaWound/CorneaWound_HetHet_2019Feb04/acq_2/Fused/animationfiles/attempts.animation.txt animation=/RazorScopeData/RazorScopeSets/Jen/CorneaWound/CorneaWound_HetHet_2019Feb04/acq_2/Fused/animationfiles//attempts.animation.txt output_width=907 output_height=924 scalebar_position=[object - lower left front] scalebar=0 scalebar_offset=10 rendering_algorithm=[Independent transparency] ");
selectWindow(fName+".avi");
saveAs("Tiff", dir+"/animationfiles/"+substring(fName,0,lengthOf(fName)-4)+"_Animation.tif");
       
} 
