
interface apb_if(input logic pclk);

  // APB Signals (Declared as logic)
  logic presetn;
  logic transfer;
  logic READ_WRITE;

  logic [7:0] apb_write_paddr;
  logic [7:0] apb_write_data;
  logic [7:0] apb_read_paddr;
  logic [7:0] apb_read_data_out;

  // Clocking block for DRIVER
  clocking drv_cb @(posedge pclk);
    default input #0 output #0;

    output transfer;
    output READ_WRITE;
    output apb_write_paddr;
    output apb_write_data;
    output apb_read_paddr;

    input  apb_read_data_out;
    input  presetn;

  endclocking

  // Clocking block for MONITOR
  clocking mon_cb @(posedge pclk);
    default input #0 output #0;

    input  transfer;
    input  READ_WRITE;
    input  apb_write_paddr;
    input  apb_write_data;
    input  apb_read_paddr;
    input  apb_read_data_out;
    input  presetn;

  endclocking

  // Modport for Driver
  modport DRV (clocking drv_cb);

  // Modport for Monitor
  modport MON (clocking mon_cb);

endinterface

