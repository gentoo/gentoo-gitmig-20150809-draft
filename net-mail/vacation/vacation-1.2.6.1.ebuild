# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vacation/vacation-1.2.6.1.ebuild,v 1.7 2004/11/25 00:12:09 ticho Exp $

DESCRIPTION="automatic mail answering program"
HOMEPAGE="http://vacation.sourceforge.net/"
SRC_URI="mirror://sourceforge/sourceforge/vacation/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 alpha ~amd64"
SLOT="0"
IUSE=""

RDEPEND="virtual/mta
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	!mail-mta/sendmail"

S="${WORKDIR}/${PN}"

src_unpack () {
	unpack ${A}
	cd ${S}
	mv vacation.man vacation.1
	sed -i -e 's: -m486::; s:CFLAGS.*= \(.*\):CFLAGS += \1:' Makefile
}

src_compile () {
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	dobin vacation
	dodoc AUTHORS ChangeLog README README.smrsh
	doman vacation.1
}
