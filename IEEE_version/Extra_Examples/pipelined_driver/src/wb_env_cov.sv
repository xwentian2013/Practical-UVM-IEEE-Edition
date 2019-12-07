`ifndef WB_ENV_COV__SV
 `define WB_ENV_COV__SV

class wb_env_cov extends uvm_component;
   event cov_event;
   wb_transaction tr;
   uvm_analysis_imp #(wb_transaction, wb_env_cov) cov_export;
   `uvm_component_utils(wb_env_cov)
   
   covergroup cg_trans @(cov_event);
      coverpoint tr.kind;
      coverpoint tr.address {
	 bins low = {[0:10]};
	 bins mid = {[10:100]};
	 bins high = {[100:$]};
      }
      coverpoint tr.lock ;
      
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      cov_export = new("Coverage Analysis",this);
   endfunction: new

   virtual function write(wb_transaction tr);
      this.tr = tr;
      -> cov_event;
   endfunction: write

endclass: wb_env_cov

`endif // WB_ENV_COV__SV
