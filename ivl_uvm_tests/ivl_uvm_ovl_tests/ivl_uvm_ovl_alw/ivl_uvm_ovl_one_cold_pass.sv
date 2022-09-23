`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   reg[3:0]test_expr;
       
   // simple signal check OVL 
   ovl_one_cold u_ovl_cold ( 
	  
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (test_expr)
			     );
   

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 0;
      test_expr = 4'b0111;

      $display("ovl_one_cold does not fire at rst_n");
      test_expr =4'b0111;
      wait_clks(5);

      rst_n = 1;
      wait_clks(5);
      $display("Out of reset");

      test_expr = 4'b0111;
      $display("ovl_one_cold has fired: test_expr value is :%d",test_expr);

      wait_clks(5);
     test_expr = 4'b1011;
     $display("ovl_one_cold has fired: test_expr value is :%d",test_expr);
  
     wait_clks(5);
     test_expr = 4'b1101;
     $display("ovl_one_cold has fired: test_expr vaue is :%d",test_expr);

     wait_clks(5);
     test_expr = 4'b1110;
     $display("ovl_one_cold has fired: test_expr value is :%d",test_expr);

     wait_clks(10);

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


