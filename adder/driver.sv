class driver;
    int transactions_time;
    virtual intf vif;
    mailbox gen2driv;

    function new(virtual intf vif,mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task reset;
        wait(vif.reset);
        $display("[DRIVER] ------Reset Started-----");
        vif.a <= 0;
        vif.b <= 0;
        wait(!vif.reset);
        $display("[DRIVER] ------Reset Ended-----");
    endtask

    task main;
        forever begin
            transaction trans;
            gen2driv.get(trans);
            @(posedge vif.clk);
                vif.a <= trans.a;
                vif.b <= trans.b;
            @(posedge vif.clk);
                trans.c <= vif.c;
            @(posedge vif.clk);
            trans.display("[Driver]");
            transactions_time++;
        end
    endtask
endclass
