# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmifs/wmifs-1.3_beta1-r2.ebuild,v 1.1 2004/07/31 22:24:35 s4t4n Exp $

inherit eutils

IUSE=""
MY_PV=${PV/_beta/b}
S=${WORKDIR}/wmifs.app/wmifs
DESCRIPTION="Network monitoring dock.app"
HOMEPAGE="http://www.linux.tucows.com"
SRC_URI="http://linux.tucows.tierra.net/files/x11/dock/${PN}-${MY_PV}.tar.gz
	http://http.us.debian.org/debian/pool/main/w/wmifs/${PN}_${MY_PV}-11.diff.gz"

DEPEND="virtual/x11"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha hppa ~mips ~ia64 amd64"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# patch to allow for longer interface names
	# and prettify program output for long names
	epatch ${WORKDIR}/${PN}_${MY_PV}-11.diff
}


src_compile()
{
	emake CFLAGS="${CFLAGS}" || die
}

src_install ()
{
	dobin wmifs
	insinto /usr/share/wmifs
	doins sample.wmifsrc
	cd ..
	dodoc BUGS  CHANGES  COPYING  HINTS  INSTALL  README  TODO
}
