# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmifs/wmifs-1.3_beta1-r1.ebuild,v 1.3 2004/03/27 15:41:11 aliz Exp $

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
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 amd64"

src_compile() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}_${MY_PV}-11.diff
	emake || die
}

src_install () {
	dobin wmifs
	insinto /usr/share/wmifs
	doins sample.wmifsrc
	cd ..
	dodoc BUGS  CHANGES  COPYING  HINTS  INSTALL  README  TODO
}
