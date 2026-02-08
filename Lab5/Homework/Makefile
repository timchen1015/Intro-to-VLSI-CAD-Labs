# set variable
VCS_CMD_A = vcs -R tb_det_seq.v -debug_access+all -full64 +define+FSDB
VCS_CMD_B = vcs -R tb_factorial.v -debug_access+all -full64 +define+FSDB
VCS_CMD_C = vcs -R tb_WashingMachine.v -debug_access+all -full64 +define+FSDB
VCS_SYN_CMD_A = vcs -R tb_det_seq.v -debug_access+all -full64 +define+FSDB+syn +neg_tchk
VCS_SYN_CMD_B = vcs -R tb_factorial.v -debug_access+all -full64 +define+FSDB+syn +neg_tchk
VCS_SYN_CMD_C = vcs -R tb_WashingMachine.v -debug_access+all -full64 +define+FSDB+syn +neg_tchk
TARGET_DIR_A = ProbA
TARGET_DIR_B = ProbB
TARGET_DIR_C = ProbC
FSDB_FILE_A = det_seq.fsdb
FSDB_FILE_B = factorial.fsdb
FSDB_FILE_C = WashingMachine.fsdb
LINT_SCRIPT = superlint.tcl

# simulation
probA:
	cd $(TARGET_DIR_A) && $(VCS_CMD_A)
probB:
	cd $(TARGET_DIR_B) && $(VCS_CMD_B)
probC:
	cd $(TARGET_DIR_C) && $(VCS_CMD_C)
# open FSDB
nWaveA:
	cd $(TARGET_DIR_A) && nWave -ssf $(FSDB_FILE_A) &
nWaveB:
	cd $(TARGET_DIR_B) && nWave -ssf $(FSDB_FILE_B) &
nWaveC:
	cd $(TARGET_DIR_C) && nWave -ssf $(FSDB_FILE_C) &
# superlint
superlintA:
	cd $(TARGET_DIR_A) && jg -superlint $(LINT_SCRIPT) &
superlintB:
	cd $(TARGET_DIR_B) && jg -superlint $(LINT_SCRIPT) &
superlintC:
	cd $(TARGET_DIR_C) && jg -superlint $(LINT_SCRIPT) &

# synthesize
probA_syn:
	cd $(TARGET_DIR_A) && $(VCS_SYN_CMD_A)
probB_syn:
	cd $(TARGET_DIR_B) && $(VCS_SYN_CMD_B)
probC_syn:
	cd $(TARGET_DIR_C) && $(VCS_SYN_CMD_C)

# clean simulation result
clean:
	rm -rf $(TARGET_DIR_C)/*.log \
	       $(TARGET_DIR_C)/*.fsdb \
	       $(TARGET_DIR_C)/*.vpd \
	       $(TARGET_DIR_C)/csrc \
	       $(TARGET_DIR_C)/jgproject \
	       $(TARGET_DIR_C)/simv* \
	       $(TARGET_DIR_C)/daidir\
	       $(TARGET_DIR_C)/ucli.key\
		   $(TARGET_DIR_B)/*.log \
	       $(TARGET_DIR_B)/*.fsdb \
	       $(TARGET_DIR_B)/*.vpd \
	       $(TARGET_DIR_B)/csrc \
           $(TARGET_DIR_B)/jgproject \
           $(TARGET_DIR_B)/simv* \
	       $(TARGET_DIR_B)/daidir\
	       $(TARGET_DIR_B)/ucli.key\
           $(TARGET_DIR_A)/*.log \
	       $(TARGET_DIR_A)/*.fsdb \
	       $(TARGET_DIR_A)/*.vpd \
	       $(TARGET_DIR_A)/csrc \
	       $(TARGET_DIR_A)/jgproject \
	       $(TARGET_DIR_A)/simv* \
	       $(TARGET_DIR_A)/daidir\
	       $(TARGET_DIR_A)/ucli.key\