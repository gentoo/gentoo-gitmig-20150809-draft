# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/makeedit.eclass,v 1.3 2002/08/04 16:22:34 spider Exp $

# Author: Spider
# makeedit eclass, will remove -Wreturn-type and -Wall from compiling, this will reduce the RAM requirements.

# Debug ECLASS
ECLASS="makeedit"
INHERITED="$INHERITED $ECLASS"

INHERITED="$INHERITED $ECLASS"
export CFLAGS="${CFLAGS} -Wno-return-type -w"
export CXXFLAGS="${CXXFLAGS} -Wno-return-type -w"

edit_makefiles () {
	find . -iname makefile |while read MAKEFILE
		do einfo "parsing ${MAKEFILE}"
		cp ${MAKEFILE}  ${MAKEFILE}.old
		sed -e "s:-Wall:-Wno-return-type:g" \
			-e "s:-Wreturn-type:-Wno-return-type:g" \
			-e "s:-pedantic::g" ${MAKEFILE}.old > ${MAKEFILE}
	done
		
}
