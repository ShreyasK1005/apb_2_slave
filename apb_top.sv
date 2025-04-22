
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_package.sv"
module tb;
  bit pclk;
  apb_if vif(pclk);

  apb_protocol dut (
    .pclk(pclk),
    .presetn(vif.presetn),
    .transfer(vif.transfer),
    .READ_WRITE(vif.READ_WRITE),
    .apb_write_address(vif.apb_write_address),
    .apb_write_data(vif.apb_write_data),
    .apb_read_addr(vif.apb_read_addr),
    .apb_read_data_out(vif.apb_read_data_out)
  );

  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk;
  end

  initial begin
    vif.presetn = 0;
    #10 vif.presetn = 1;
  end

  initial begin
    uvm_config_db#(virtual apb_if)::set(null, "*", "vif", vif);
    run_test("apb_test");
  end
endmodule

