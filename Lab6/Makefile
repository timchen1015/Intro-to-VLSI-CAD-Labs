# set variable
VCS_CMD = vcs -R -sverilog tb.sv -debug_access+all -full64 +define+FSDB +neg_tchk
VCS_PLOT_CMD = vcs -R -sverilog tb.sv -debug_access+all -full64 +define+FSDB+plot +neg_tchk
VCS_COLOR_CMD = vcs -R -sverilog tb.sv -debug_access+all -full64 +define+FSDB+plot+color +neg_tchk
VCS_SYN_CMD = vcs -R -sverilog tb.sv -debug_access+all -full64 +define+FSDB+syn +neg_tchk
VCS_SYN_PLOT_CMD = vcs -R -sverilog tb.sv -debug_access+all -full64 +define+FSDB+plot+syn +neg_tchk
VCS_SYN_COLOR_CMD = vcs -R -sverilog tb.sv -debug_access+all -full64 +define+FSDB+plot+color+syn +neg_tchk

#TARGET_DIR = ProbA/fixedpoint
FSDB_FILE = cubic.fsdb
LINT_SCRIPT = superlint.tcl

# simulation
rtl:
	$(VCS_CMD)
rtl_plot:
	$(VCS_PLOT_CMD)
rtl_color:
	$(VCS_COLOR_CMD)

# open FSDB
nWave:
	nWave -ssf $(FSDB_FILE) &

# superlint
superlint:
	jg -superlint $(LINT_SCRIPT) &

# synthesize
syn:
	$(VCS_SYN_CMD)
syn_plot:
	$(VCS_SYN_PLOT_CMD)
syn_color:
	$(VCS_SYN_COLOR_CMD)

# clean simulation result
clean:
	rm -rf *.log \
	       *.fsdb \
	       *.vpd \
	       csrc \
	       jgproject \
	       simv* \
	       daidir\
	       ucli.key\
