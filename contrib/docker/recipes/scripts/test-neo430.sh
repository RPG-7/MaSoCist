#!/bin/bash

# Run small check to see if neo430 is properly booting
# and spitting out stuff on the virtual UART
#
MASOCIST=$HOME/src/vhdl/masocist-opensource

make -C $MASOCIST virtual_neo430-main sim
make -C $MASOCIST/test/virtual_neo430 all


