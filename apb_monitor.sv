
import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "apb_sequence_item.sv"
class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  virtual apb_if vif;
  uvm_analysis_port #(apb_transaction) mon_ap;
  apb_transaction tr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_ap = new("mon_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      tr = apb_transaction::type_id::create("tr");
      @(posedge vif.pclk);
      tr.transfer           = vif.transfer;
      tr.READ_WRITE         = vif.READ_WRITE;
      tr.apb_write_paddr  = vif.apb_write_paddr;
      tr.apb_write_data     = vif.apb_write_data;
      tr.apb_read_paddr      = vif.apb_read_paddr;
      tr.apb_read_data_out  = vif.apb_read_data_out;
      mon_ap.write(tr);
    end
  endtask
endclass

