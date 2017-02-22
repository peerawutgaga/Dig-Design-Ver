module cpu(
input clock,
input reset,
input start
);
//Notice! We use address of 4-byte word here.
// This means that each address contains 32-bit data and PC should increment by 1 not 4 as in class's slide.
// We can convert this back to byte address by appending 2 zeroes to the LSB.
parameter inst_addr_bit=10;
parameter data_addr_bit=10;
//start-stop control
reg running;
reg stop;
always@(posedge clock)
begin
    if(reset)running=0;
    else if (start) running=1;
    else if (stop) running=0;
end
wire [31:0]signExtendImm;
//internal instruction memory, async read
reg [31:0]inst_mem[0:(1<<inst_addr_bit)-1];
parameter FILE1 ="instmem.txt";
integer i3;
initial begin
    for(i3=0;i3<(1<<inst_addr_bit);i3=i3+1)inst_mem[i3]=32'hFFFFFFFF;   //fill with FFFFFFFF
    $readmemb(FILE1, inst_mem);
end
reg [inst_addr_bit-1:0] PC;
wire [31:0]Instr = inst_mem[PC]; //current instruction 
always@(posedge clock)
begin
//Please complete the block below, PC needs to be changed for BEQ instruction.
///////////////////////////////////////////////////////////////////////////
    if(branch & zero)
    begin
        PC = PC + signExtendImm;
    end   
///////////////////////////////////////////////////////////////////////////
//Notice! PC increments even after branching.
    if(running)PC=PC+1;
    else PC=0;  
    if(jump)
    begin
    	PC = targetAddress;	
    end
end
//internal data memory
reg [31:0]data_mem[0:(1<<data_addr_bit)-1];
parameter FILE2 ="datamem.txt";
//init data_mem
initial begin
    for(i=0;i<(1<<data_addr_bit);i=i+1)data_mem[i]=32'h0;   //zero fill
    $readmemh(FILE2, data_mem);
end
//readport for data_mem
//Notice! Read is asynchronous, write is synchronous and
// address port is shared with data_mem read.
wire [data_addr_bit-1:0]data_mem_addr;
wire [31:0]data_mem_read_data = data_mem[data_mem_addr];//get data from memory from data_mem_read_data
//writeport for data memory
reg data_mem_write;
wire [31:0]data_mem_write_data;
integer i;
always@(posedge clock)
begin
    if(data_mem_write)
    begin
        $monitor("addr: %d, data: %d \n", data_mem_addr, data_mem_write_data);
        data_mem[data_mem_addr]<=data_mem_write_data;
    end
end

//register file
//Again, read is asynchronous and write is synchronous
reg [31:0]regFile[0:31];
//readports for regFile
//RD1 mapped to rs in instruction 
//RD2 mapped to rt in instruction
wire [31:0]RD1 = regFile[rs];
wire [31:0]RD2 = regFile[rt];
assign data_mem_write_data = RD2;
//writeport for regFile
//Note that A3 is not always mapped to rd in the instruction.
reg [4:0]A3;
reg [31:0]WD3;
reg WE3;
integer i2;
always@(posedge clock)
begin
    if(reset)begin
        for(i2=0;i2<32;i2=i2+1) regFile[i2]=32'h0;    //clear regFile
    end     
    else if(WE3)regFile[A3]<=WD3;
end
//dissect current instruction
wire [5:0]opcode = Instr[31:26];
//for R type instruction
wire [4:0]rs = Instr[25:21];
wire [4:0]rt = Instr[20:16];
wire [4:0]rd = Instr[15:11];
wire [4:0]shamt = Instr[10:6];
wire [5:0]funct = Instr[5:0];
//for I type instruction
wire [15:0]immediate = Instr[15:0];
//for J type instruction
wire [25:0]targetAddress = Instr[25:0];
assign signExtendImm = immediate[15]?{16'hFFFF,immediate}:{16'h0000,immediate};
//control parts
// data_mem_write
// WE3 (register file write)
// A3 (written register, Note that it is not the same in every instruction)
reg branch;
reg jump;
always@(*)
begin
    WD3=32'hFFFFFFFF;
    A3=5'h1F;
    WE3=0;
    data_mem_write=0;
    branch=0;
    jump = 0;
    case(opcode)
    6'h23:  //Load Word
    begin
        WE3=1;
        WD3=data_mem_read_data;
        A3=rt;
    end
    6'h2b:  //Store Word
    begin
        data_mem_write=1;
    end
    //Add control signal for other instructions
    /////////////////////////////////////////////////
    6'h00:  //special
    begin
    	WD3 = ALUResult;
    	A3 = rd;
    	WE3 = 1;
    end
    6'h02:
    begin
    	jump = 1;
    end
    6'h20:
    begin
    	A3 = rd;
    	WD3 = ALUResult;
    	WE3 = 1;
    end
    6'h04:  //beq
    begin
    	branch = 1;
    end
    6'h25:  //lhu
    begin
    	WD3 = {16'b0, data_mem_read_data};
    	A3 = rt;
    	WE3 = 1;
    end
    6'h0F:  //lui
    begin
    	WD3 = {immediate, 16'b0};
    	A3 = rt;
    	WE3 = 1;
    end 
    6'h08:  //addi
    begin
    	A3 = rt;
    	WD3 = ALUResult;
    	WE3 = 1;
    end
    /////////////////////////////////////////////////
    endcase
end
reg [31:0]ALUResult;
reg zero;
reg [31:0]SrcA;
reg [31:0]SrcB;
assign data_mem_addr = ALUResult;
//ALUControl and input control
// This can be included in control block above but 
reg [5:0]ALUControl;
always@(*)
begin
    ALUControl=6'h0;
    SrcA=RD1;
    SrcB=RD2;
    stop=0;
    case(opcode)
        6'h23:begin //lw
            SrcA=RD1;
            SrcB=signExtendImm;
            ALUControl=6'h21;//calculate effectice load address
        end
        6'h2b:begin //sw
            SrcA=RD1;
            SrcB=signExtendImm;
            ALUControl=6'h21;//calculate effectice store address
        end
        6'h00:begin
            SrcA=RD1;
            SrcB=RD2;
            ALUControl=funct;
        end
        //to be done...
        /////////////////////////////////////////////////////
        6'h04:begin //beq
            SrcA = RD2;
            SrcB = RD1;
            ALUControl = 6'h23;
        end
        6'h0f:begin //lui
        end
        6'h20: //add
        begin
        	SrcA = RD1;
        	SrcB = RD2;
        	ALUControl = 6'h20;
        end
        6'h25:begin //lhu	
        end
        6'h08:begin //addi
        	SrcA = RD1;
        	SrcB = signExtendImm;
        	ALUControl = 6'h20;
        end
        6'h02:begin   	
        end
        /////////////////////////////////////////////////////
        default: stop=1;  //should stop 
    endcase
end
//ALU
always@(*)
begin
    ALUResult=32'hFFFFFFFF;
    case(ALUControl)
        6'h20:ALUResult=(SrcA+SrcB);  //ADD
        6'h21:ALUResult=(SrcA+SrcB);  //ADDU
        //add more functions
        // add, addi, sll, srl, may need more?
        ////////////////////////////////////////////////////
        6'h23: ALUResult=(SrcA-SrcB);//SUBU
        6'h24: ALUResult=(SrcA & SrcB);//AND
        6'h25: ALUResult=(SrcA | SrcB);//OR
        6'h00: ALUResult=SrcB << shamt;//SLL
        6'h02: ALUResult=SrcB >>> shamt;//SRL Somehow, in MIPS's ref, ">>>", arithmetic shift is used. Logical shift left should use >> operator.
        6'h05: ALUResult=(SrcA*SrcB);
        ////////////////////////////////////////////////////
    endcase
    zero = ALUResult==0;
end
endmodule