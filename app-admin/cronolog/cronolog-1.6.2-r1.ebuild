# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cronolog/cronolog-1.6.2-r1.ebuild,v 1.10 2005/01/02 14:02:55 aliz Exp $

inherit eutils

DESCRIPTION="Cronolog apache logfile rotator"
HOMEPAGE="http://cronolog.org/"
SRC_URI="http://cronolog.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${PV}-patches/*.txt
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
