# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nictools/nictools-20030719.ebuild,v 1.5 2004/01/05 11:32:04 robbat2 Exp $

DESCRIPTION="nictools - diagnostic tools for a variety of ISA and PCI network cards"
HOMEPAGE="http://www.scyld.com/diag/index.html"
# The tarball is a slightly modified version compiled of the _latest_ versions
# of the files from all of the debian package, and the entirely of the Scyld
# website.
# It has a vastly modified Makefile to make it easy to build on Gentoo
SRC_URI="mirror://gentoo/${P}.tbz2
		 mirror://gentoo/${P}-gcc33-multilinestring.patch"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="static"
DEPEND=""

S=${WORKDIR}/${P}

nictools_grabvar() {
	gmake VAR="${1}" printvar
}

nictools_setupcards() {
	if [ -z "${NICTOOLS_CARDS}" ]; then
		NICTOOLS_CARDS="pci isa"
	fi
	for card in ${NICTOOLS_CARDS}; do
		UPPER=`echo ${card} | tr '[:lower:]' '[:upper:]'`
		NICTOOLS_INSTALL="${NICTOOLS_INSTALL} `nictools_grabvar ${UPPER}`"
		NICTOOLS_INSTALL="${NICTOOLS_INSTALL} `nictools_grabvar ${card}`"
	done
	NICTOOLS_INSTALL="${NICTOOLS_INSTALL} `nictools_grabvar UTILS`"
	NICTOOLS_INSTALL="`echo ${NICTOOLS_INSTALL} | xargs -n1 | sort | uniq |xargs`"
}

pkg_setup() {
	einfo "If you want the configuration tools for only PCI or ISA cards, "
	einfo "do: 'NICTOOLS_CARDS=\"pci\" emerge nictools' or 'NICTOOLS_CARDS=\"isa\" emerge nictools'"
}

src_unpack() {
	unpack ${P}.tbz2
	epatch ${DISTDIR}/${P}-gcc33-multilinestring.patch
}

src_compile() {
	nictools_setupcards
	use static && CFLAGS="${CFLAGS} -static"
	emake ${NICTOOLS_INSTALL} || die "emake failed"
}

src_install() {
	nictools_setupcards
	# we do this as the user might not have /usr mounted and they might want
	# the tool to configure the network card so they can use it!
	into /
	for i in ${NICTOOLS_INSTALL}; do
		dosbin ${i}
	done
	into /usr
	doman netdiag.8
}
