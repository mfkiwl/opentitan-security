// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// The following exclusions were manually added.
//
// In dm_mem.sv, a location that can be read is at WhereToAddr. This is supposed to contain a JAL
// instruction that points at the first instruction of the current abstract command. This location
// is either the start of the program buffer or the start of the abstract command. Deciding which is
// done with the current command's cmdtype. But it turns out that this is always dm::AccessRegister,
// because this is the only supported command. Waive coverage of a situation where the command is
// not that value.
INSTANCE: tb.dut.u_dm_top.i_dm_mem
ANNOTATION: "Cannot have running command other than AccessRegister"
Condition 5 "3588663374" "((cmd_i.cmdtype == AccessRegister) && ((!ac_ar.transfer)) && ac_ar.postexec) 1 -1" (1 "011")
Condition 6 "3885215629" "(cmd_i.cmdtype == AccessRegister) 1 -1" (1 "0")

// In dmi_jtag.sv, we never expect to see error_q == DMIOPFailed. The only way of having that happen
// would be if error_dmi_op_failed was 1. That, in turn, needs a dm::DTM_ERR response for the DMI
// request that the dap makes of dm_top. Such a response would come from dm_csrs, but this can never
// construct a dm::DTM_ERR response.
INSTANCE: tb.dut.dap
Fsm error_q "2073559246"
State DMIOPFailed "2"
Transition DMINoError->DMIOPFailed "0->2"
Transition DMIOPFailed->DMINoError "2->0"

// In tlul_lc_gate, there is an FSM state called StFlush. The intention is that when the gate is
// open (in state StActive), a flush request causes us to go into the StFlush state, where we block
// commands. The u_tlul_lc_gate_sba instance has the flush_req_i input wired to zero but UNR doesn't
// mark the StFlush state as unreachable. We could get there by disabling and enabling debug on two
// consecutive cycles (going through states StActive, StOutstanding, StFlush, StActive). Disabling
// debug a second time on the third cycle would replace the last state (StActive) with StError.
//
// While this sequence is theoretically possible, the "glitchy" transition between StActive and
// StError doesn't really correspond to something we expect to see. We're testing this state and its
// transitions for other instances of the module (where flush_req_i is not always zero), so we don't
// have any risk of a bug in the module not being seen.
INSTANCE: tb.dut.u_tlul_lc_gate_sba
Fsm state_q "3443824386"
State StFlush "76"
Transition StFlush->StActive "76->289"
Transition StFlush->StError "76->186"
Transition StOutstanding->StFlush "231->76"

// The code being waived here is from tlul_rsp_intg_gen.sv and gets run if the EnableRspIntgGen
// or EnableDataIntgGen parameters are zero. They aren't, so we need to waive this line coverage.
INSTANCE: tb.dut.u_reg_regs.u_reg_if.u_rsp_intg_gen
Block 1 "461445014" "assign rsp_intg = tl_i.d_user.rsp_intg;"
Block 2 "2643129081" "assign data_intg = tl_i.d_user.data_intg;"

// The following exclusions were generated by UNR.
//
//==================================================
// This file contains the Excluded objects
// Generated By User: miguelosorio
// Format Version: 2
// Date: Thu Aug  1 16:04:51 2024
// ExclMode: default
//==================================================
CHECKSUM: "2345259249 2478537381"
INSTANCE: tb.dut.dap.i_dmi_jtag_tap
ANNOTATION: "VC_COV_UNR"
Block 69 "637783920" ";"
CHECKSUM: "1794274355 4209686271"
INSTANCE: tb.dut.u_tlul_lc_gate_sba.u_tlul_err_resp
ANNOTATION: "VC_COV_UNR"
Condition 1 "1610943811" "(err_rsp_pending && tl_h_i.d_ready) 1 -1" (2 "10")
ANNOTATION: "VC_COV_UNR"
Condition 2 "4156730590" "(tl_h_i.a_valid && tl_h_o_int.a_ready) 1 -1" (2 "10")
CHECKSUM: "1519521893 1155107467"
INSTANCE: tb.dut
ANNOTATION: "VC_COV_UNR"
Condition 2 "254063376" "(ndmreset_ack && ndmreset_pending_q) 1 -1" (2 "10")
ANNOTATION: "VC_COV_UNR"
Condition 4 "1831429135" "(ndmreset_ack && lc_rst_pending_q) 1 -1" (2 "10")
ANNOTATION: "VC_COV_UNR"
Condition 9 "3864289575" "(regs_intg_error | rom_intg_error | sba_gate_intg_error | rom_gate_intg_error) 1 -1" (2 "0001")
ANNOTATION: "VC_COV_UNR"
Condition 9 "3864289575" "(regs_intg_error | rom_intg_error | sba_gate_intg_error | rom_gate_intg_error) 1 -1" (3 "0010")
ANNOTATION: "VC_COV_UNR"
Condition 13 "879101139" "(ndmreset_pending_q && lc_rst_pending_q && ((!ndmreset_req)) && ((!lc_rst_asserted)) && reset_req_en) 1 -1" (1 "01111")
CHECKSUM: "1519521893 1864293086"
INSTANCE: tb.dut
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 regs_tl_d_o.d_user.rsp_intg [6] "logic regs_tl_d_o.d_user.rsp_intg[6:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 regs_tl_d_o.d_user.rsp_intg [6] "logic regs_tl_d_o.d_user.rsp_intg[6:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 regs_tl_d_o.d_sink [0] "logic regs_tl_d_o.d_sink[0:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 regs_tl_d_o.d_sink [0] "logic regs_tl_d_o.d_sink[0:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 regs_tl_d_o.d_param [0] "logic regs_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 regs_tl_d_o.d_param [0] "logic regs_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 regs_tl_d_o.d_param [1] "logic regs_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 regs_tl_d_o.d_param [1] "logic regs_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 regs_tl_d_o.d_param [2] "logic regs_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 regs_tl_d_o.d_param [2] "logic regs_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 mem_tl_d_o.d_user.rsp_intg [6] "logic mem_tl_d_o.d_user.rsp_intg[6:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 mem_tl_d_o.d_user.rsp_intg [6] "logic mem_tl_d_o.d_user.rsp_intg[6:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 mem_tl_d_o.d_sink [0] "logic mem_tl_d_o.d_sink[0:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 mem_tl_d_o.d_sink [0] "logic mem_tl_d_o.d_sink[0:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 mem_tl_d_o.d_param [0] "logic mem_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 mem_tl_d_o.d_param [0] "logic mem_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 mem_tl_d_o.d_param [1] "logic mem_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 mem_tl_d_o.d_param [1] "logic mem_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 mem_tl_d_o.d_param [2] "logic mem_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 mem_tl_d_o.d_param [2] "logic mem_tl_d_o.d_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_user.rsvd [0] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_user.rsvd [0] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_user.rsvd [1] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_user.rsvd [1] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_user.rsvd [2] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_user.rsvd [2] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_user.rsvd [3] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_user.rsvd [3] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_user.rsvd [4] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_user.rsvd [4] "logic sba_tl_h_o.a_user.rsvd[4:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_address [0] "logic sba_tl_h_o.a_address[31:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_address [0] "logic sba_tl_h_o.a_address[31:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_address [1] "logic sba_tl_h_o.a_address[31:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_address [1] "logic sba_tl_h_o.a_address[31:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [0] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [0] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [1] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [1] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [2] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [2] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [3] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [3] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [4] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [4] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [5] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [5] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [6] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [6] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_source [7] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_source [7] "logic sba_tl_h_o.a_source[7:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_size [0] "logic sba_tl_h_o.a_size[1:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_size [0] "logic sba_tl_h_o.a_size[1:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_param [0] "logic sba_tl_h_o.a_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_param [0] "logic sba_tl_h_o.a_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_param [1] "logic sba_tl_h_o.a_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_param [1] "logic sba_tl_h_o.a_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 0to1 sba_tl_h_o.a_param [2] "logic sba_tl_h_o.a_param[2:0]"
ANNOTATION: "VC_COV_UNR"
Toggle 1to0 sba_tl_h_o.a_param [2] "logic sba_tl_h_o.a_param[2:0]"
CHECKSUM: "2709971803 591200431"
INSTANCE: tb.dut.u_dm_top.i_dm_mem
ANNOTATION: "VC_COV_UNR"
Block 33 "2798412932" ";"
ANNOTATION: "VC_COV_UNR"
Block 61 "2723844228" "if ((dc < (dm::DataCount - 1)))"
ANNOTATION: "VC_COV_UNR"
Block 62 "2398373540" "data_bits[(dc + 1)][((i - 4) * 8)+:8] = wdata_i[(i * 8)+:8];"
ANNOTATION: "VC_COV_UNR"
Block 106 "2684304032" "err_d = 1'b1;"
CHECKSUM: "4224194069 2881513198"
INSTANCE: tb.dut.u_tlul_lc_gate_sba
ANNOTATION: "VC_COV_UNR"
Block 36 "3828992405" "err_o = 1'b1;"
CHECKSUM: "4224194069 2881513198"
INSTANCE: tb.dut.u_tlul_lc_gate_rom
ANNOTATION: "VC_COV_UNR"
Block 36 "3828992405" "err_o = 1'b1;"
CHECKSUM: "1340377389 4238305272"
INSTANCE: tb.dut.u_dm_top.i_dm_sba
ANNOTATION: "VC_COV_UNR"
Block 46 "2865494160" "state_d = Idle;"
CHECKSUM: "74367784 3785313510"
INSTANCE: tb.dut.u_reg_regs.u_reg_if
ANNOTATION: "VC_COV_UNR"
Condition 18 "3340270436" "(addr_align_err | malformed_meta_err | tl_err | instr_error | intg_error) 1 -1" (5 "01000")
CHECKSUM: "74367784 3656090703"
INSTANCE: tb.dut.i_tlul_adapter_reg
ANNOTATION: "VC_COV_UNR"
Condition 15 "3340270436" "(addr_align_err | malformed_meta_err | tl_err | instr_error | intg_error) 1 -1" (5 "01000")
CHECKSUM: "4224194069 639524789"
INSTANCE: tb.dut.u_tlul_lc_gate_sba
ANNOTATION: "VC_COV_UNR"
Condition 7 "121936459" "(tl_h2d_i.d_ready & tl_d2h_o.d_valid) 1 -1" (1 "01")
CHECKSUM: "4224194069 639524789"
INSTANCE: tb.dut.u_tlul_lc_gate_rom
ANNOTATION: "VC_COV_UNR"
Condition 1 "1380914983" "(a_ack && ((!d_ack))) 1 -1" (2 "10")
ANNOTATION: "VC_COV_UNR"
Condition 2 "2824798557" "(d_ack && ((!a_ack))) 1 -1" (2 "10")
CHECKSUM: "7115036 3679981882"
INSTANCE: tb.dut.u_dm_top.i_dm_csrs.i_fifo
ANNOTATION: "VC_COV_UNR"
Condition 3 "786039886" "(wvalid_i & wready_o & ((~gen_normal_fifo.under_rst))) 1 -1" (3 "110")
ANNOTATION: "VC_COV_UNR"
Condition 4 "1324655787" "(rvalid_o & rready_i & ((~gen_normal_fifo.under_rst))) 1 -1" (3 "110")
CHECKSUM: "2709971803 889438022"
INSTANCE: tb.dut.u_dm_top.i_dm_mem
ANNOTATION: "VC_COV_UNR"
Condition 2 "1851980116" "(resumereq_aligned[hartsel] && ((!resuming_q_aligned[hartsel])) && ((!haltreq_aligned[hartsel])) && halted_q_aligned[hartsel]) 1 -1" (2 "1011")
ANNOTATION: "VC_COV_UNR"
Condition 12 "788256892" "((32'(ac_ar.aarsize) < MaxAar) && ac_ar.transfer && ((!ac_ar.write))) 1 -1" (3 "110")
CHECKSUM: "1340377389 1421269835"
INSTANCE: tb.dut.u_dm_top.i_dm_sba
ANNOTATION: "VC_COV_UNR"
Branch 2 "4269836655" "state_q" (7) "state_q Read ,-,-,-,0,-,-,-,-,-,-,-,-"
ANNOTATION: "VC_COV_UNR"
Branch 2 "4269836655" "state_q" (20) "state_q default,-,-,-,-,-,-,-,-,-,-,-,-"
CHECKSUM: "487869288 3696802595"
INSTANCE: tb.dut.u_dm_top.i_dm_csrs
ANNOTATION: "VC_COV_UNR"
Branch 0 "3574190413" "(hartsel_idx0 < 15'((((NrHarts - 1) / (2 ** 5)) + 1)))" (1) "(hartsel_idx0 < 15'((((NrHarts - 1) / (2 ** 5)) + 1))) 0"
ANNOTATION: "VC_COV_UNR"
Branch 1 "1789205363" "(hartsel_idx1 < 10'((((NrHarts - 1) / (2 ** 10)) + 1)))" (1) "(hartsel_idx1 < 10'((((NrHarts - 1) / (2 ** 10)) + 1))) 0"
ANNOTATION: "VC_COV_UNR"
Branch 2 "4150080586" "(hartsel_idx2 < 5'((((NrHarts - 1) / (2 ** 15)) + 1)))" (1) "(hartsel_idx2 < 5'((((NrHarts - 1) / (2 ** 15)) + 1))) 0"
ANNOTATION: "VC_COV_UNR"
Branch 4 "3849421052" "((dmi_req_ready_o && dmi_req_valid_i) && (dtm_op == DTM_WRITE))" (3) "((dmi_req_ready_o && dmi_req_valid_i) && (dtm_op == DTM_WRITE)) 1,Data0 DataEnd ,0,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-"
ANNOTATION: "VC_COV_UNR"
Branch 12 "1524828153" "(selected_hart <= 1'((NrHarts - 1)))" (1) "(selected_hart <= 1'((NrHarts - 1))) 0"
CHECKSUM: "2345259249 3039402680"
INSTANCE: tb.dut.dap.i_dmi_jtag_tap
ANNOTATION: "VC_COV_UNR"
Branch 11 "1673691078" "tap_state_q" (32) "tap_state_q default,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-"
CHECKSUM: "4224194069 3219254590"
INSTANCE: tb.dut.u_tlul_lc_gate_sba
ANNOTATION: "VC_COV_UNR"
Branch 2 "1850090820" "state_q" (8) "state_q StFlush ,-,-,-,0,0,-,-"
ANNOTATION: "VC_COV_UNR"
Branch 2 "1850090820" "state_q" (13) "state_q default,-,-,-,-,-,-,-"
CHECKSUM: "4224194069 3219254590"
INSTANCE: tb.dut.u_tlul_lc_gate_rom
ANNOTATION: "VC_COV_UNR"
Branch 2 "1850090820" "state_q" (13) "state_q default,-,-,-,-,-,-,-"
CHECKSUM: "704952876 424853"
INSTANCE: tb.dut.dap.i_dmi_cdc.i_cdc_resp.u_prim_sync_reqack
ANNOTATION: "VC_COV_UNR"
Branch 2 "3560579867" "gen_rz_hs_protocol.dst_fsm_q" (1) "gen_rz_hs_protocol.dst_fsm_q LoSt ,1,0,-"
CHECKSUM: "2709971803 2063590459"
INSTANCE: tb.dut.u_dm_top.i_dm_mem
ANNOTATION: "VC_COV_UNR"
Branch 2 "2494332144" "state_q" (11) "state_q default,-,-,-,-,-,-"
ANNOTATION: "VC_COV_UNR"
Branch 9 "2350155233" "req_i" (11) "req_i 1,-,1"
