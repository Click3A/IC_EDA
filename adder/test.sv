program test(intf intf);
    environment env;

    initial begin
        env = new(intf);
        env.gen.repeat_time = 10;
        env.run();
    end
endprogram

