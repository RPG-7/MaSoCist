# Module configuration for distribution:
#


# GHDLEX cosimulation module:

############################################################################

DEFCONFIGS = $(wildcard $(VENDOR)/defconfig_*)

CONFIG_FILES = $(notdir $(DEFCONFIGS))

DIST_PLATFORMS = $(CONFIG_FILES:defconfig_%=%)

############################################################################

# One unified work dir:
WORKDIR = work

GHDLEX_VERSION    = sim-0.1dev

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
DEVICENAME = nep430
endif

# New style default rules file:
# We no longer mess with variables, we define defaults:
ifdef CONFIG_NEO430
include $(TOPDIR)/hdl/neo430/neo430.mk
endif