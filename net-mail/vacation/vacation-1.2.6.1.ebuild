# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vacation/vacation-1.2.6.1.ebuild,v 1.2 2003/06/17 20:05:45 agriffis Exp $ 

DESCRIPTION="automatic mail answering program"
HOMEPAGE="http://vacation.sourceforge.net/"
SRC_URI="mirror://sourceforge/sourceforge/vacation/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 alpha"
SLOT="0"
IUSE=""

DEPEND="virtual/mta
	sys-libs/gdbm"

S="${WORKDIR}/${PN}"

src_unpack () {
	unpack ${A}
	cd ${S}
	mv vacation.man vacation.1
	mv Makefile Makefile.orig
	sed < Makefile.orig -e 's: -m486::' | sed -e 's:CFLAGS.*= \(.*\):CFLAGS += \1:' > Makefile	
}

src_compile () {
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	dobin vacation
	dodoc AUTHORS ChangeLog README README.smrsh
	doman vacation.1
}
