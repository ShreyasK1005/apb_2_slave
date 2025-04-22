//import uvm_pkg::*;
//`include "uvm_macros.svh"
//`include "apb_sequence_item.sv"

class apb_driver extends uvm_driver #(apb_transaction);
  `uvm_component_utils(apb_driver)
  virtual apb_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "Failed to get virtual interface")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.transfer         <= req.transfer;
      vif.READ_WRITE       <= req.READ_WRITE;
      vif.apb_write_address <= req.apb_write_address;
      vif.apb_write_data   <= req.apb_write_data;
      vif.apb_read_addr    <= req.apb_read_addr;
      @(posedge vif.pclk);
      seq_item_port.item_done();
    end
  endtask
endclass

