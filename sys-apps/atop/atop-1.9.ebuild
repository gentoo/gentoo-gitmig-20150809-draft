# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/atop/atop-1.9.ebuild,v 1.3 2003/06/22 23:40:28 liquidx Exp $


DESCRIPTION="Resource-specific view of processes"
SRC_URI="ftp://ftp.atcomputing.nl/pub/tools/linux/${P}.tar.gz
		mirror://gentoo/${P}-initscript"
HOMEPAGE="http://freshmeat.net/releases/112061/"
LICENSE="GPL-2"
SLOT="0"
DEPEND="sys-apps/acct"
KEYWORDS="~x86 amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ${S}/atop.init ${S}/atop.init.old
	cp ${DISTDIR}/${P}-initscript ${S}/atop.init
}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} INIPATH=/etc/init.d install || die

	# Install documentation.
	dodoc README
}
