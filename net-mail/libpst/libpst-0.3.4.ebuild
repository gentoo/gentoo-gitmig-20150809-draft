# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/libpst/libpst-0.3.4.ebuild,v 1.1 2004/03/05 09:02:05 phosphan Exp $

DESCRIPTION="Tools and library for reading Outlook files (.pst format)"
HOMEPAGE="http://sourceforge.net/projects/ol2mbox"
MY_PN="libpst"
MYFILE="${MY_PN}_${PV}.tgz"
SRC_URI="mirror://sourceforge/ol2mbox/${MYFILE}"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=sys-apps/sed-4"

S="${WORKDIR}/${MY_PN}_${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/-g/$(CFLAGS)/' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe getidblock readpst
	dodoc README* AUTHORS FILE-FORMAT*
	insinto /usr/include
	doins libpst.h
	insinto /usr/lib
	doins libpst.o
}
