#!/bin/bash
# Wing3D run script

ESDL_ROOT="/usr/lib/erlang/lib/esdl"
WINGS_ROOT="/usr/lib/erlang/lib/wings"

erl -detached -pa $ESDL_ROOT/ebin $WINGS_ROOT/ebin -run wings_start start_halt
