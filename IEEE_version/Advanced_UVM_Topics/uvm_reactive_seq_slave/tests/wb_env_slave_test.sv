//
// Template for UVM-compliant testcase

`ifndef TEST__SV
 `define TEST__SV

typedef class wb_env_env;

class wb_env_slave_test extends uvm_test;
   bit test_pass = 1;

   wb_config wb_master_config;
   wb_config wb_slave_config;

   `uvm_component_utils(wb_env_slave_test)

   wb_env_env env;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = wb_env_env::type_id::create("env", this);
      wb_master_config = new("wb_master_config");
      wb_slave_config = new("wb_slave_config");

      wb_master_config.max_n_wss = 10;
      wb_master_config.min_addr = 0;
      wb_master_config.max_addr = 10000000;

      wb_slave_config.max_n_wss = 10;
      wb_slave_config.min_addr = 0;
      wb_slave_config.max_addr = 10000000;

      begin: configure
	 uvm_config_db #(uvm_object_wrapper)::set(this, "env.master_agent.mast_sqr.run_phase", "default_sequence", sequence_1::get_type()); 
	 uvm_config_db #(uvm_object_wrapper)::set(this, "env.slave_agent.slv_seqr.run_phase", "default_sequence", ram_sequence::get_type()); 

	 uvm_config_db #(wb_config)::set(this, "env.master_agent", "config", wb_master_config); 
	 uvm_config_db #(wb_config)::set(this, "env.slave_agent", "config", wb_slave_config); 
      end 
   endfunction
   task run_phase(uvm_phase phase);
      uvm_phase phase_ = phase;
      uvm_objection obj_ = phase.get_objection();
      //set a drain-time for the environment if desired
      obj_.set_drain_time(this, 50);
   endtask : run_phase


endclass : wb_env_slave_test

`endif //TEST__SV

