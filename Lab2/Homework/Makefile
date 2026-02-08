# 設定變數
VCS_CMD_A = vcs -R -sverilog tb_ALU.v -debug_access+all -full64 +define+FSDB
VCS_CMD_B = vcs -R -sverilog tb_FFO.v -debug_access+all -full64 +define+FSDB
VCS_CMD_C = vcs -R -sverilog tb_MergeSort.v -debug_access+all -full64 +define+FSDB
TARGET_DIR_A = ProbA
TARGET_DIR_B = ProbB
TARGET_DIR_C = ProbC
FSDB_FILE_A = ALU.fsdb
FSDB_FILE_B = FFO.fsdb
FSDB_FILE_C = MergeSort.fsdb
LINT_SCRIPT = superlint.tcl

.PHONY: probC clean







# 執行 VCS 模擬
probA:
	cd $(TARGET_DIR_A) && $(VCS_CMD_A)
 
probB:
	cd $(TARGET_DIR_B) && $(VCS_CMD_B)
 
probC:
	cd $(TARGET_DIR_C) && $(VCS_CMD_C)
 
 
 
 
# 開啟 FSDB
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
 
 

# 清除 probC 內的模擬結果
clean:
	rm -rf $(TARGET_DIR_C)/*.log \
	       $(TARGET_DIR_C)/*.fsdb \
	       $(TARGET_DIR_C)/*.vpd \
	       $(TARGET_DIR_C)/csrc \
	       $(TARGET_DIR_C)/simv* \
	       $(TARGET_DIR_C)/daidir\
         $(TARGET_DIR_B)/*.log \
	       $(TARGET_DIR_B)/*.fsdb \
	       $(TARGET_DIR_B)/*.vpd \
	       $(TARGET_DIR_B)/csrc \
	       $(TARGET_DIR_B)/simv* \
	       $(TARGET_DIR_B)/daidir\
         $(TARGET_DIR_A)/*.log \
	       $(TARGET_DIR_A)/*.fsdb \
	       $(TARGET_DIR_A)/*.vpd \
	       $(TARGET_DIR_A)/csrc \
	       $(TARGET_DIR_A)/simv* \
	       $(TARGET_DIR_A)/daidir\
