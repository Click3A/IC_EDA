UVM_HOME	= /home/ICer/Tool/uvm-1.1d
all: comp run

comp:
	$(VCS)  -f filelist.f  \
		-P ${LD_LIBRARY_PATH}/novas.tab  ${LD_LIBRARY_PATH}/pli.a  \
              |  tee  vcs.log  &

run:
	$(SIMV) +UVM_TESTNAME=test_2m_4s
	$(CHECK)

TEST = /usr/bin/test
N_ERRS = 0
N_FATALS = 0

VCS =	vcs -sverilog -timescale=1ns/1ns   -full64  -R  +vc  +v2k  -debug_all  \
	+acc +vpi \
	+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
	+incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
	$(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

SIMV = 	./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) -l vcs.log

URG  = urg -format text -dir simv.vdb

CHECK = \
	@$(TEST) \( `grep -c 'UVM_ERROR :    $(N_ERRS)' vcs.log` -eq 1 \) -a \
		 \( `grep -c 'UVM_FATAL :    $(N_FATALS)' vcs.log` -eq 1 \)

clean:
	rm -rf *~ core csrc simv* vc_hdrs.h ucli.key urg* *.log *.log  novas.* *.fsdb* verdiLog  64* DVEfiles *.vpd

verdi  :
	verdi -f filelist.f -ssf tb.fsdb &

