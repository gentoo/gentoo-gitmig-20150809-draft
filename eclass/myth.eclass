# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/myth.eclass,v 1.2 2004/09/10 17:34:30 aliz Exp $
#
# Author: Daniel Ahlberg <aliz@gentoo.org>
#

ECLASS=myth
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS src_unpack src_compile src_install

myth_src_unpack() {
	unpack ${A} ; cd ${S}

	sed -e "s:PREFIX = .*:PREFIX = /usr:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE = .*:QMAKE_CXXFLAGS_RELEASE = ${CXXFLAGS}:" \
		-e "s:QMAKE_CFLAGS_RELEASE = .*:QMAKE_CFLAGS_RELEASE = ${CFLAGS}:" \
		-i 'settings.pro' || die "Initial setup failed"

        if use debug ; then
		FEATURES="${FEATURES} nostrip"
                sed -e 's:#CONFIG += debug:CONFIG += debug:' \
                        -e 's:CONFIG += release:#CONFIG += release:' \
                        -i 'settings.pro' || die "enable debug failed"
	fi

	setup_pro
}

myth_src_compile() {
	qmake -o "Makefile" "${PN}.pro"
	emake || die
}

myth_src_install() {
	einstall INSTALL_ROOT="${D}"
	for doc in "AUTHORS COPYING FAQ UPGRADING ChangeLog README"; do
		test -e "${doc}" && dodoc ${doc}
	done
}
