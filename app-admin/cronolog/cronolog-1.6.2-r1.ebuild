# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cronolog/cronolog-1.6.2-r1.ebuild,v 1.4 2004/03/09 09:32:54 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Cronolog apache logfile rotator"
HOMEPAGE="http://cronolog.org/"
SRC_URI="http://cronolog.org/download/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND} net-www/apache"
KEYWORDS="x86 ~ppc amd64"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	local a

	unpack ${A} ; cd ${S}

	for a in $( ls -1 ${FILESDIR}/${PV}-patches/ ); do
		epatch ${FILESDIR}/${PV}-patches/${a}
	done
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
