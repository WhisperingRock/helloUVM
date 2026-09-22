
|- Factory
|
|- config_db
|
|- uvm_test_1
    |
    |- uvm_env
        |
        |- uvm_scoreboard -->
        |
        |- --> virtual sequencer -->
        |
        |- --> uvm_agent <-->
        |   |
        |   |- uvm_sequencer -->
        |   |
        |   |- uvm_driver --> (DUT)
        |   |
        |   |- (DUT) --> uvm_monitor
        |
        |- <--> DUT
 
