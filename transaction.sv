class transaction;
    rand bit [3:0]a;
    rand bit [3:0]b;
    bit[6:0]c;

function void display(string name_1);
    $display("-----------------");
    $display("-%s",name_1);
    $display("-----------------");
    $display("a = %0d, b = %0d",a,b);
    //
