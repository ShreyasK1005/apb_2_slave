
//import uvm_pkg::*;
//`include "uvm_macros.svh"
//`include "apb_active_agent.sv"
//`include "apb_passive_agent.sv"

class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)

  apb_active_agent agent_inst1;
  apb_passive_agent agent_inst2;
 // apb_scoreboard sco;

  function new(string name = "apb_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_inst1 = apb_active_agent::type_id::create("agent_inst1", this);
    agent_inst2 = apb_passive_agent::type_id::create("agent_inst2", this);
   // sco = apb_scoreboard::type_id::create("sco", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_inst1.m.mon_ap.connect(sco.recv);
    agent_inst2.m.mon_ap.connect(sco.recv);
  endfunction
endclass

