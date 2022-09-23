module test;

   wire clk;
   reg rst_n;
   reg[3:0]data;
   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);
   end    
   // simple signal check OVL 
   ovl_zero_one_hot #( .width(4)) u_ovl_zero_one_hot ( 
	  
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (data)
			     );
   

   initial begin
   
      // Initialize values.
      rst_n = 1;
      data = 4'b0000;
      wait_clks(1);
      $display("ovl_zero_one_hot does not fire at rst_n");
      rst_n = 0;
      $display("---ovl_one_hot checker fired---");
      data =4'b1100;
      $display("ovl_one_hot has fired: test_expr value is :%d",data); 
      wait_clks(3);
      data = 4'b0111;
      $display("ovl_one_hot has fired: test_expr value is :%d",data);

      wait_clks(6);
      data = 4'b0x01;
      $display("ovl_one_hot has fired: test_expr value is :%d",data);

      wait_clks(5);
      data = 4'b1111;
      $display("ovl_one_hot has fired: tesr_expr value is :%d",data);
      wait_clks(7);
      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
