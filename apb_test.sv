
//import uvm_pkg::*;
//`include "uvm_macros.svh"

//`include "apb_environment.sv"
//`include "apb_sequence.sv"
class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)

  apb_env e;
  apb_sequence seq;

  function new(string name = "apb_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = apb_env::type_id::create("e", this);
    seq = apb_sequence::type_id::create("seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(e.agent_inst1.seqr);
    phase.drop_objection(this);
  endtask
endclass

