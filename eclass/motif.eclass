# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/motif.eclass,v 1.4 2004/09/15 23:10:21 kugelfang Exp $
#
# Heinrich Wednel <lanius@gentoo.org>

inherit eutils

ECLASS=motif
INHERITED="$INHERITED $ECLASS"

LESSTIF_INC_DIR="/usr/X11R6/include/lesstif"
LESSTIF_LIB_DIR="/usr/X11R6/$(get_libdir)/lesstif"
LESSTIF_BIN_DIR="/usr/X11R6/bin/lesstif"
