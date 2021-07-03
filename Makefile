# -*- makefile -*-

# RV32IM is default
XLEN		?= 32
ifeq ($(XLEN), 32)
CROSS_COMPILE 	= riscv32-unknown-elf-
ASFLAGS		+= -march=rv32ima -mabi=ilp32
CFLAGS		+= -march=rv32ima -mabi=ilp32
TEST_PREFIX	= rv32-
endif

ifeq ($(XLEN), 64)
CROSS_COMPILE 	= riscv64-unknown-elf-
ASFLAGS		+= -march=rv64ima -mabi=lp64
CFLAGS		+= -march=rv64ima -mabi=lp64
TEST_PREFIX	= rv64-
endif

TOPDIR		?= .
SUBDIRS          = vicky \ # Here we have to use the name of diractory where my assembly code exists.

# cross compile programs
AR     		= $(CROSS_COMPILE)ar
CC              = $(CROSS_COMPILE)gcc
LD              = $(CROSS_COMPILE)ld
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
STRIP           = $(CROSS_COMPILE)strip

ifneq (,$(findstring s,$(MAKEFLAGS)))
ARFLAGS         = crs
else
ARFLAGS         = crsv
endif

ASFLAGS         += -g -I$(TOPDIR)/lib
CFLAGS          += -g -I$(TOPDIR)/lib

SRC_EXT      	= S s
EXTRA_EXT       = text
CLEAN_EXTRA_EXT = map

TARGETS_SKIP    =

TARGETS         = $(filter-out $(TARGETS_SKIP),$(foreach subdir,$(SUBDIRS),$(foreach srcext,$(SRC_EXT),$(patsubst %.$(srcext),%,$(wildcard $(subdir)/*.$(srcext))))))
TARGETS_EXTRA   = $(foreach ext,$(EXTRA_EXT), $(addsuffix .$(ext), $(TARGETS)))
CLEAN_EXTRA     = $(foreach ext,$(CLEAN_EXTRA_EXT), $(addsuffix .$(ext), $(TARGETS)))

LDFLAGS         += -fpic
LDFLAGS         += -nostdlib
LDFLAGS         += -nostartfiles
LDFLAGS         += -L$(TOPDIR)/lib
LDFLAGS         += -T$(TOPDIR)/lib/bare.lds
LDFLAGS         += -Wl,-e0
LDFLAGS         += -Wl,--strip-debug
ASFLAGS         += -Wa,-Ilegacy
LDLIBS          += -lm
LDFLAGS         += -Wl,-Map,$@.map

default:all

all: $(TARGETS) $(TARGETS_EXTRA)

install:
	$(foreach subdir,$(SUBDIRS), mv $(subdir)/$(subdir) ./$(TEST_PREFIX)$(subdir);)
	$(foreach subdir,$(SUBDIRS), mv $(subdir)/$(subdir).text ./$(TEST_PREFIX)$(subdir).text;)


clean:
	$(RM) $(TARGETS) $(TARGETS_EXTRA) $(CLEAN_EXTRA)

full_clean: clean
	$(foreach subdir,$(SUBDIRS), $(RM) ./$(TEST_PREFIX)$(subdir);)
	$(foreach subdir,$(SUBDIRS), $(RM) ./$(TEST_PREFIX)$(subdir).text;)

%.elf: %.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LOADLIBES) $(LDLIBS)

%.text: %
	$(OBJDUMP) --disassemble $^ > $@

.PHONY: default all clean distclean
