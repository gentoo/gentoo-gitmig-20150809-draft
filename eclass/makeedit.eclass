# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/makeedit.eclass,v 1.7 2004/10/19 19:51:12 vapier Exp $
#
# Author: Spider
#
# makeedit eclass, will remove -Wreturn-type and -Wall from compiling,
# this will reduce the RAM requirements.

# Debug ECLASS
ECLASS="makeedit"
INHERITED="$INHERITED $ECLASS"

export CFLAGS="${CFLAGS} -Wno-return-type -w"
export CXXFLAGS="${CXXFLAGS} -Wno-return-type -w"

edit_makefiles () {
	einfo "Parsing Makefiles ..."
	find . -iname makefile | while read MAKEFILE
	do
		cp ${MAKEFILE} ${MAKEFILE}.old
		# We already add "-Wno-return-type -w" to compiler flags, so
		# no need to replace "-Wall" and "-Wreturn-type" with them.
		sed -e 's:-Wall::g' \
			-e 's:-Wreturn-type::g' \
			-e 's:-pedantic::g' ${MAKEFILE}.old > ${MAKEFILE}
		rm -f ${MAKEFILE}.old
	done
	# Mozilla use .mk includes 
	find . -name '*.mk' | while read MAKEFILE
	do
		cp ${MAKEFILE} ${MAKEFILE}.old
		sed -e 's:-Wall::g' \
			-e 's:-Wreturn-type::g' \
			-e 's:-pedantic::g' ${MAKEFILE}.old > ${MAKEFILE}
		rm -f ${MAKEFILE}.old
	done
}
