function fun = Fun0x1(x)
% rectifying function
        if x<0
            fun = 0; 
        elseif x>1
            fun = 1;
        else
            fun = x;
        end
end

