# Module configuration for distribution:
#


# GHDLEX cosimulation module:

############################################################################

DEFCONFIGS = $(wildcard $(VENDOR)/defconfig_*)

CONFIG_FILES = $(notdir $(DEFCONFIGS))

DIST_PLATFORMS = $(CONFIG_FILES:defconfig_%=%)

DIST_PLATFORMS = $(CONFIG_FILES:defconfig_%=%)

TEST_PLATFORMS = virtual-demo virtual_riscv-main virtual_neo430-main

############################################################################

# One unified work dir:
WORKDIR = work

GHDLEX_VERSION    = sim-0.1dev
# We have the tap library:
MODULE_TAPLIB = $(CONFIG_HAVE_VTAP)

# The build duties - in the opensource, we only build sw and sim
BUILD_DUTIES = sw sim

# Simulation library uses a default:
BUILD_SIMLIB_OPTIONS = DEVICEFILE=boards/test.xml
BUILD_SIMLIB_OPTIONS += all-libsim 


DISTFILES += $(TOPDIR)/syn/lattice/breakout/breakout-opensource.ldf
DISTFILES += $(TOPDIR)/syn/lattice/breakout/breakout.lpf
DISTFILES += $(TOPDIR)/syn/lattice/breakout/Speed.sty
DISTFILES += $(TOPDIR)/syn/lattice/breakout/breakout/breakout.xcf

# Special IPcore files:
DISTFILES += $(TOPDIR)/syn/lattice/ngo/TAP_Lattice_Glue.ngo

DISTFILES += $(TOPDIR)/syn/xilinx/papilio/papilio-lcd.ucf
DISTFILES += $(TOPDIR)/syn/xilinx/papilio/Makefile
DISTFILES += $(TOPDIR)/syn/xilinx/papilio/papilio_top_full.bit
DISTFILES += $(TOPDIR)/syn/xilinx/papilio/bscan_spi.bit
DISTFILES += $(TOPDIR)/syn/xilinx/papilio/beatrix.bmm
# FIXME: bring back project files
# DISTFILES += $(TOPDIR)/syn/xilinx/papilio/zpu/zpu.gise
# DISTFILES += $(TOPDIR)/syn/xilinx/papilio/zpu/zpu.xise

############################################################################
# Opensource platform config specifics:
#
ifdef CONFIG_virtual_neo430
PLATFORM = virtual_neo430
DEVICENAME = neo430
endif

ifdef CONFIG_virtual_rv32ui
PLATFORM = virtual_riscv
endif

# New style default rules file:
# We no longer mess with variables, we define defaults:
ifdef CONFIG_NEO430
include $(TOPDIR)/hdl/neo430/neo430.mk
endif

ifdef CONFIG_RISCV_ARCH
CROSS_COMPILE = riscv32-unknown-elf-
endif

SRCFILES-$(CONFIG_RISCV_PYRV32) += riscv/pyrv32/pyrv32_cpu.vhd
SRCFILES-$(CONFIG_RISCV_PYRV32) += pck_myhdl_011.vhd

ifdef CONFIG_RISCV_POTATO
include $(TOPDIR)/hdl/riscv/potato.mk
endif

REQUIRE_LIBSLAVE = y

ifdef CONFIG_GHDLEX_DEFAULT
CONFIG_LIBSIM = "ghdlex-netpp"
endif

ifdef CONFIG_DUMMYTAP
CONFIG_LIBSIM = "ghdlex"
endif

# Look for libraries in GHDLEX dir:
GHDL_LDFLAGS += -Wl,-L$(GHDLEX)/src

# Use this path to look for libraries:
# OLD_LD_LIBRARY_PATH=$(shell echo $$LD_LIBRARY_PATH)
# LD_LIBRARY_PATH=$(OLD_LD_LIBRARY_PATH):$(HOME)/lib:$(GHDLEX)/src
# export LD_LIBRARY_PATH
