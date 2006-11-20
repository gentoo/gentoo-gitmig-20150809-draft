#!/bin/sh

LD_LIBRARY_PATH="/opt/vlnx:${LD_LIBRARY_PATH}" exec /opt/vlnx/uvscan ${@+"$@"}
