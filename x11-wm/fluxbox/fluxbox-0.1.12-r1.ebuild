# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.12-r1.ebuild,v 1.9 2003/05/20 21:42:10 mkeadle Exp $

IUSE="kde gnome nls xinerama"

inherit commonbox flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on Blackbox -- has tabs."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-gentoo.diff.bz2"
HOMEPAGE="http://fluxbox.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

mydoc="ChangeLog COPYING NEWS"
filter-flags -fno-exceptions
export WANT_AUTOMAKE_1_6=1
export WANT_AUTOCONF_2_5=1

src_unpack() {

	unpack ${P}.tar.gz

	cd ${S}
	bzcat ${DISTDIR}/${PN}-gentoo.diff.bz2 | patch -p1 || die
}

src_compile() {

	commonbox_src_compile

	cd data
	make \
		pkgdatadir=/usr/share/commonbox init
}


src_install() {

	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init
	insinto /usr/share/commonbox/fluxbox
	doins keys
}
