# 設定變數
VCS_CMD_A = vcs -R -sverilog tb_top.v -debug_access+all -full64 +define+FSDB
VCS_CMD_B_1 = vcs -R -sverilog tb_FIFO.v -debug_access+all -full64 +define+FSDB
VCS_CMD_B_2 = vcs -R -sverilog tb_top.v -debug_access+all -full64 +define+FSDB

TARGET_DIR_A = ProbA
TARGET_DIR_B_1 = ProbB/ProbB_1
TARGET_DIR_B_2 = ProbB/ProbB_2

FSDB_FILE_A = top.fsdb
FSDB_FILE_B_1 = FIFO.fsdb
FSDB_FILE_B_2 = top.fsdb

LINT_SCRIPT = superlint.tcl

# 執行 VCS 模擬
probA:
	cd $(TARGET_DIR_A) && $(VCS_CMD_A)

probB_1:
	cd $(TARGET_DIR_B_1) && $(VCS_CMD_B_1)

probB_2:
	cd $(TARGET_DIR_B_2) && $(VCS_CMD_B_2)

# 開啟 FSDB
nWaveA:
	cd $(TARGET_DIR_A) && nWave -ssf $(FSDB_FILE_A) &

nWaveB_1:
	cd $(TARGET_DIR_B_1) && nWave -ssf $(FSDB_FILE_B_1) &

nWaveB_2:
	cd $(TARGET_DIR_B_2) && nWave -ssf $(FSDB_FILE_B_2) &

# superlint
superlintA:
	cd $(TARGET_DIR_A) && jg -superlint $(LINT_SCRIPT) &

superlintB_1:
	cd $(TARGET_DIR_B_1) && jg -superlint $(LINT_SCRIPT) &

superlintB_2:
	cd $(TARGET_DIR_B_2) && jg -superlint $(LINT_SCRIPT) &

# 清除模擬結果
clean:
	rm -rf $(TARGET_DIR_A)/*.log \
	       $(TARGET_DIR_A)/*.fsdb \
	       $(TARGET_DIR_A)/*.vpd \
	       $(TARGET_DIR_A)/csrc \
	       $(TARGET_DIR_A)/simv* \
	       $(TARGET_DIR_A)/daidir \
	       $(TARGET_DIR_B_1)/*.log \
	       $(TARGET_DIR_B_1)/*.fsdb \
	       $(TARGET_DIR_B_1)/*.vpd \
	       $(TARGET_DIR_B_1)/csrc \
	       $(TARGET_DIR_B_1)/simv* \
	       $(TARGET_DIR_B_1)/daidir \
	       $(TARGET_DIR_B_2)/*.log \
	       $(TARGET_DIR_B_2)/*.fsdb \
	       $(TARGET_DIR_B_2)/*.vpd \
	       $(TARGET_DIR_B_2)/csrc \
	       $(TARGET_DIR_B_2)/simv* \
	       $(TARGET_DIR_B_2)/daidir
