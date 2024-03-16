function fun = Fun0x1Grad(x)
% gradient of the rectifying function
        if x<0 || x>1
            fun = 0; 
        else
            fun = 1;
        end
end

