function cellstrings=str_sep(strvect)

l=size(strvect,2);
k=1;
remain=strvect;
cellstrings{1}=strvect(1);

while isempty(remain)==0
    
    [token, remain] = strtok(remain);
    
    cellstrings{k}=token;
    k=k+1;
    
    
end


