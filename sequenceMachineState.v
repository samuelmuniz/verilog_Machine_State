module sequenceMachineState;
// This description tries to track the sequence '1011'
    input in,clk,rst;
    output reg out;

    parameter
    state0 = 3'b000,    //state where the input didn't received the first 1
    state1 = 3'b001,    //state where the input received the first 1
    state2 = 3'b010,    //state where the input received the 1 and 0
    state3 = 3'b011,    //state where the input received the 1 , 0 and 1
    state4 = 3'b100;    //state where the input received the full sequence

    reg [2:0] stateNow, stateNext; // state registers

    assign out = stateNow == state4 ? 1 : 0;

    always @ (posedge clk) //verifies if the the "reset" signal was recieved
    begin
      if  (rst!)
      stateNow <= state0;
      else 
        stateNow <= stateNext; 
    end
    
    always @ (stateNow or in) // state machine
    begin
        case (stateNow)
            state0 :
            begin
                if (in) stateNext = state1;
                else stateNext = state0;
            end

            state1 :
            begin
                if (in) stateNext = state0;
                else stateNext = state2;
            end

            state2 :
            begin
                if (in) stateNext = state3;
                else stateNext = state0;
            end

            state3 :
            begin
                if (in) stateNext = state4;
                else stateNext = state0;
            end

            state4 :
            begin
                stateNext = state0;
            end
        endcase
    end
      

endmodule