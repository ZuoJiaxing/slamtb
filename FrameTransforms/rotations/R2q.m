function q = R2q(R)

% R2Q  rotation matrix to quaternion conversion
%
%   See also QUATERNION, Q2R, Q2E, Q2V.


T = trace(R) + 1;

if isa(T,'sym') || ( T > 0.00000001 )  % to avoid large distortions!

    S = 2 * sqrt(T);
    a = 0.25 * S;
    b = ( R(2,3) - R(3,2) ) / S;
    c = ( R(3,1) - R(1,3) ) / S;
    d = ( R(1,2) - R(2,1) ) / S;

else
    if ( R(1,1) > R(2,2) && R(1,1) > R(3,3) ) 
        % Column 1:
        % tested with R2 = diag([1 -1 -1])
        
        S  = 2 * sqrt( 1.0 + R(1,1) - R(2,2) - R(3,3) );
        a = (R(2,3) - R(3,2) ) / S;
        b = 0.25 * S;
        c = (R(1,2) + R(2,1) ) / S;
        d = (R(3,1) + R(1,3) ) / S;
        
    elseif ( R(2,2) > R(3,3) )               
        % Column 2:
        % tested with R3 = [0 1 0;1 0 0;0 0 -1]
        
        S  = 2 * sqrt( 1.0 + R(2,2) - R(1,1) - R(3,3) );
        a = (R(3,1) - R(1,3) ) / S;
        b = (R(1,2) + R(2,1) ) / S;
        c = 0.25 * S;
        d = (R(2,3) + R(3,2) ) / S;
        
    else
        % Column 3:
        % tested with R4 = [-1 0 0;0 0 1;0 1 0]
        
        S  = 2 * sqrt( 1.0 + R(3,3) - R(1,1) - R(2,2) );
        a = (R(1,2) - R(2,1) ) / S;
        b = (R(3,1) + R(1,3) ) / S;
        c = (R(2,3) + R(3,2) ) / S;
        d = 0.25 * S;

    end
end

q = [a -b -c -d]';
