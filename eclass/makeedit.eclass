# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/makeedit.eclass,v 1.2 2002/07/26 21:50:16 danarmak Exp $

# Author: Spider
# makeedit eclass, will remove -Wreturn-type and -Wall from compiling, this will reduce the RAM requirements.

# Debug ECLASS
ECLASS="makeedit"
INHERITED="$INHERITED $ECLASS"

INHERITED="$INHERITED $ECLASS"
export CFLAGS="${CFLAGS} -Wno-return-type"
export CXXFLAGS="${CXXFLAGS} -Wno-return-type"

edit_makefiles () {
	find . -iname makefile |while read MAKEFILE
		do einfo "parsing ${MAKEFILE}"
		cp ${MAKEFILE}  ${MAKEFILE}.old
		sed -e "s:-Wall:-Wall -Wno-return-type:g" \
			-e "s:-Wreturn-type:-Wno-return-type:g" \
			-e "s:-pedantic::g" ${MAKEFILE}.old > ${MAKEFILE}
	done
		
}
