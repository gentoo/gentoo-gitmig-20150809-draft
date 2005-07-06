# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/makeedit.eclass,v 1.9 2005/07/06 20:20:04 agriffis Exp $
#
# Author: Spider
#
# To use this eclass, do 2 things:
#   1. append-flags "$MAKEEDIT_FLAGS".  If you filter-flags, make sure to do
#      the append-flags afterward, otherwise you'll lose them.
#   2. after running configure or econf, call edit_makefiles to remove
#      extraneous CFLAGS from your Makefiles.
#
# This combination should reduce the RAM requirements of your build, and maybe
# even speed it up a bit.

INHERITED="$INHERITED $ECLASS"

MAKEEDIT_FLAGS="-Wno-return-type -w"

edit_makefiles() {
	# We already add "-Wno-return-type -w" to compiler flags, so
	# no need to replace "-Wall" and "-Wreturn-type" with them.
	einfo "Parsing Makefiles ..."
	find . -iname makefile -o -name \*.mk -o -name GNUmakefile -print0 | \
		xargs -0 sed -i \
		-e 's:-Wall::g' \
		-e 's:-Wreturn-type::g' \
		-e 's:-pedantic::g'
}
