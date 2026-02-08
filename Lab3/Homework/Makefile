# set variable
VCS_CMD_A_1 = vcs -R -sverilog tb_fixedpoint.v -debug_access+all -full64 +define+FSDB
VCS_CMD_A_2 = vcs -R -sverilog tb_fixedpoint_s.v -debug_access+all -full64 +define+FSDB
VCS_CMD_B = vcs -R -sverilog tb_log.v -debug_access+all -full64 +define+FSDB
VCS_CMD_C = vcs -R -sverilog tb_ALU.v -debug_access+all -full64 +define+FSDB
VCS_SYN_CMD_A_1 = vcs -R -sverilog tb_fixedpoint.v -debug_access+all -full64 +define+FSDB+syn
VCS_SYN_CMD_A_2 = vcs -R -sverilog tb_fixedpoint_s.v -debug_access+all -full64 +define+FSDB+syn
VCS_SYN_CMD_B = vcs -R -sverilog tb_log.v -debug_access+all -full64 +define+FSDB+syn
VCS_SYN_CMD_C = vcs -R -sverilog tb_ALU.v -debug_access+all -full64 +define+FSDB+syn
TARGET_DIR_A_1 = ProbA/fixedpoint
TARGET_DIR_A_2 = ProbA/fixedpoint_s
TARGET_DIR_B = ProbB
TARGET_DIR_C_1 = ProbC/ALU_gate
TARGET_DIR_C_2 = ProbC/ALU_behavior
FSDB_FILE_A_1 = fixedpoint.fsdb
FSDB_FILE_A_2 = fixedpoint_s.fsdb
FSDB_FILE_B = log.fsdb
FSDB_FILE_C = ALU.fsdb
LINT_SCRIPT = superlint.tcl

# simulation
probA_1:
	cd $(TARGET_DIR_A_1) && $(VCS_CMD_A_1)
probA_2:
	cd $(TARGET_DIR_A_2) && $(VCS_CMD_A_2)

probB:
	cd $(TARGET_DIR_B) && $(VCS_CMD_B)
 
probC_1:
	cd $(TARGET_DIR_C_1) && $(VCS_CMD_C)
probC_2:
	cd $(TARGET_DIR_C_2) && $(VCS_CMD_C)

# open FSDB
nWaveA_1:
	cd $(TARGET_DIR_A_1) && nWave -ssf $(FSDB_FILE_A_1) &
nWaveA_2:
	cd $(TARGET_DIR_A_2) && nWave -ssf $(FSDB_FILE_A_2) &

nWaveB:
	cd $(TARGET_DIR_B) && nWave -ssf $(FSDB_FILE_B) &
 
nWaveC_1:
	cd $(TARGET_DIR_C_1) && nWave -ssf $(FSDB_FILE_C) &
nWaveC_2:
	cd $(TARGET_DIR_C_2) && nWave -ssf $(FSDB_FILE_C) &

# superlint
superlintA_1:
	cd $(TARGET_DIR_A_1) && jg -superlint $(LINT_SCRIPT) &
superlintA_2:
	cd $(TARGET_DIR_A_2) && jg -superlint $(LINT_SCRIPT) &

superlintB:
	cd $(TARGET_DIR_B) && jg -superlint $(LINT_SCRIPT) &

superlintC_1:
	cd $(TARGET_DIR_C_1) && jg -superlint $(LINT_SCRIPT) &
superlintC_2:
	cd $(TARGET_DIR_C_2) && jg -superlint $(LINT_SCRIPT) &

# synthesize
probA_1_syn:
	cd $(TARGET_DIR_A_1) && $(VCS_SYN_CMD_A_1)
probA_2_syn:
	cd $(TARGET_DIR_A_2) && $(VCS_SYN_CMD_A_2)

probB_syn:
	cd $(TARGET_DIR_B) && $(VCS_SYN_CMD_B)
 
probC_1_syn:
	cd $(TARGET_DIR_C_1) && $(VCS_SYN_CMD_C)
probC_2_syn:
	cd $(TARGET_DIR_C_2) && $(VCS_SYN_CMD_C)

# clean simulation result
clean:
	rm -rf $(TARGET_DIR_C_1)/*.log \
	       $(TARGET_DIR_C_1)/*.fsdb \
	       $(TARGET_DIR_C_1)/*.vpd \
	       $(TARGET_DIR_C_1)/csrc \
	       $(TARGET_DIR_C_1)/jgproject \
	       $(TARGET_DIR_C_1)/simv* \
	       $(TARGET_DIR_C_1)/daidir\
	       $(TARGET_DIR_C_1)/ucli.key\
		     $(TARGET_DIR_C_2)/*.log \
	       $(TARGET_DIR_C_2)/*.fsdb \
	       $(TARGET_DIR_C_2)/*.vpd \
	       $(TARGET_DIR_C_2)/csrc \
	       $(TARGET_DIR_C_2)/jgproject \
	       $(TARGET_DIR_C_2)/simv* \
	       $(TARGET_DIR_C_2)/daidir\
	       $(TARGET_DIR_C_2)/ucli.key\
         $(TARGET_DIR_B)/*.log \
	       $(TARGET_DIR_B)/*.fsdb \
	       $(TARGET_DIR_B)/*.vpd \
	       $(TARGET_DIR_B)/csrc \
         $(TARGET_DIR_B)/jgproject \
         $(TARGET_DIR_B)/simv* \
	       $(TARGET_DIR_B)/daidir\
	       $(TARGET_DIR_B)/ucli.key\
         $(TARGET_DIR_A_1)/*.log \
	       $(TARGET_DIR_A_1)/*.fsdb \
	       $(TARGET_DIR_A_1)/*.vpd \
	       $(TARGET_DIR_A_1)/csrc \
	       $(TARGET_DIR_A_1)/jgproject \
	       $(TARGET_DIR_A_1)/simv* \
	       $(TARGET_DIR_A_1)/daidir\
	       $(TARGET_DIR_A_1)/ucli.key\
         $(TARGET_DIR_A_2)/*.log \
	       $(TARGET_DIR_A_2)/*.fsdb \
	       $(TARGET_DIR_A_2)/*.vpd \
	       $(TARGET_DIR_A_2)/csrc \
	       $(TARGET_DIR_A_2)/jgproject \
	       $(TARGET_DIR_A_2)/simv* \
	       $(TARGET_DIR_A_2)/daidir\
	       $(TARGET_DIR_A_2)/ucli.key\