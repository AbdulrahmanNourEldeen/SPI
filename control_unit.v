module control_unit (
    output  reg    enable_clk,
    output  reg    shift,
    output  reg    load,
    output  reg    count,

    input   wire    clk,
    input   wire    rst,
    input   wire    data_valid,
    input   wire    overflow
);

    reg     [1:0]   current_state,
                    next_state;
    
    localparam [1:0]    IDLE    =   2'b00,
                        LOAD    =   2'b01,
                        TRANS   =   2'b10;
    
    //state transition
    always @(posedge clk or negedge rst) 
        begin
            if(!rst)
                begin
                    current_state <= IDLE;
                end
            else
                begin
                    current_state <= next_state;
                end
        end

    //output logic
    always @(*) 
        begin
            case(current_state)
                IDLE:
                    begin
                        enable_clk =    1'b0;
                        shift      =    1'b0;
                        load       =    1'b0;
                        count      =    1'b0;
                    end
                LOAD:
                    begin
                        enable_clk =    1'b0;
                        shift      =    1'b0;
                        load       =    1'b1;
                        count      =    1'b0;
                    end

                TRANS:
                    begin
                        enable_clk =    1'b1;
                        shift      =    1'b1;
                        load       =    1'b0;
                        count      =    1'b1;
                    end 

                default:
                    begin
                        enable_clk =    1'b0;
                        shift      =    1'b0;
                        load       =    1'b0;
                        count      =    1'b0;
                    end
            endcase
        end

    //next state logic
    always @(*) 
        begin
            case(current_state)
                IDLE:
                    begin
                        if(!data_valid)
                            begin
                                next_state = IDLE;
                            end
                        else
                            begin
                                next_state = LOAD;
                            end
                    end
                LOAD:
                    begin
                        next_state <= TRANS;
                    end

                TRANS:
                    begin
                        if(!overflow)
                            begin
                                next_state = TRANS;
                            end
                        else if (data_valid)
                            begin
                                next_state = LOAD;
                            end
                        else
                            begin
                                next_state = IDLE;
                            end
                    end 
                default:
                    begin
                        next_state = IDLE;
                    end
            endcase
        end
endmodule