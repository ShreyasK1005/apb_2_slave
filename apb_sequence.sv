
//import uvm_pkg::*;
//`include "uvm_macros.svh"
//`include "apb_sequence_item.sv"
class apb_sequence extends uvm_sequence #(apb_transaction);
  `uvm_object_utils(apb_sequence)

  function new(string name = "apb_sequence");
    super.new(name);
  endfunction

  task body();
    apb_transaction tr;
    
    // WRITE
    `uvm_do_with(tr, {
      transfer == 1;
      READ_WRITE == 1;
      apb_write_paddr inside {[0:10]};
      apb_write_data inside {[20:40]};
    })

    // READ
    `uvm_do_with(tr, {
      transfer == 1;
      READ_WRITE == 0;
      apb_read_paddr == tr.apb_write_paddr;
    })
  endtask
endclass

