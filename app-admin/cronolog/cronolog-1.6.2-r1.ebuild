# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cronolog/cronolog-1.6.2-r1.ebuild,v 1.8 2004/10/05 02:58:10 pvdabeel Exp $

inherit eutils

DESCRIPTION="Cronolog apache logfile rotator"
HOMEPAGE="http://cronolog.org/"
SRC_URI="http://cronolog.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	net-www/apache"

src_unpack() {
	local a
	unpack ${A}
	cd ${S}
	for a in $( ls -1 ${FILESDIR}/${PV}-patches/ ); do
		epatch ${FILESDIR}/${PV}-patches/${a}
	done
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
