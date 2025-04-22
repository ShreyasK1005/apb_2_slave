
//import uvm_pkg::*;
//`include "uvm_macros.svh"
//`include "apb_driver.sv"
//`include "apb_sequencer.sv"
//`include "apb_monitor.sv"
//`include "apb_sequence_item.sv"

class apb_active_agent extends uvm_agent;
  `uvm_component_utils(apb_active_agent)

  apb_driver d;
  apb_sequencer seqr;
  apb_monitor m;

  function new(string name = "apb_active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d = apb_driver::type_id::create("d", this);
    seqr = apb_sequencer::type_id::create("seqr", this);
    m = apb_monitor::type_id::create("m", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    d.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass

