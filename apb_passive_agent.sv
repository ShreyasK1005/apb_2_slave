import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "apb_monitor.sv"
//`include "apb_sequence_item.sv"

class apb_passive_agent extends uvm_agent;
  `uvm_component_utils(apb_passive_agent)

  apb_monitor m;

  function new(string name = "apb_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m = apb_monitor::type_id::create("m", this);
  endfunction
endclass

