# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnut/gnut-0.4.28-r1.ebuild,v 1.2 2004/03/01 06:26:59 eradicator Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text-mode gnutella client"
SRC_URI="http://alge.anart.no/ftp/pub/gnutella/${P}.tar.gz"
HOMEPAGE="http://www.gnutelliums.com/linux_unix/gnut/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -*" #Please test on other arches
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/configure.patch.gz
	cd ${S}/src
	epatch ${FILESDIR}/src.patch.gz
}

src_compile() {
	econf
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dohtml doc/*.html
	dodoc 	doc/TUTORIAL AUTHORS COPYING ChangeLog GDJ HACKING \
		INSTALL NEWS README TODO
}
