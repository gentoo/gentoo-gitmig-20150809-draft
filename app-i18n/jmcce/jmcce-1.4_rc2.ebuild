# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jmcce/jmcce-1.4_rc2.ebuild,v 1.4 2004/01/22 06:32:25 usata Exp $

inherit gcc

MY_P=${P/_rc/RC}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Chinese Console supporting BIG5, GB and Japanese input."
HOMEPAGE="http://jmcce.slat.org"
SRC_URI="http://zope.slat.org/Project/Jmcce/DOWNLOAD/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/svgalib-1.4.3
	>=sys-libs/ncurses-4.2"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {

	unpack ${A}
	cd ${S}
	if [ `gcc-version` = "3.3" ] ; then
		epatch ${FILESDIR}/${P}-gcc3-gentoo.diff
	fi
}

src_compile() {

	./genconf.sh || die
	econf --sysconfdir=/etc/jmcce || die "econf failed"
	emake || die "make failed"
}

src_install() {

	dodir /etc/jmcce

	make DESTDIR=${D} install || die "install failed"

	mv ${D}/usr/share/doc/{${MY_P},${PF}}
	doman doc/jmcce.1
}
