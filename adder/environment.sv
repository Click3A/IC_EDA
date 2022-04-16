class environment;
    generator gen;
    driver driv;
    mailbox gen2driv;
    virtual intf vif;

    function new(virtual intf vif);
        this.vif = vif;
        gen2driv = new();
        gen      = new(gen2driv);
        driv     = new(vif,gen2driv);//连顺序都不能换
    endfunction

    task pre_test();
        driv.reset();
    endtask

    task test();
        fork
        gen.main();
        driv.main();
        join_any
    endtask

    task post_test();
        wait(gen.repeat_time==driv.transactions_time);
    endtask

    task run;
        pre_test();
        test();
        post_test();
        $finish;
    endtask
endclass
