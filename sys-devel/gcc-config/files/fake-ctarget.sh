#!/bin/bash
export ABI="custom"
export CFLAGS_custom="@@CFLAGS@@"
@@EXEC@@ "${@}"
