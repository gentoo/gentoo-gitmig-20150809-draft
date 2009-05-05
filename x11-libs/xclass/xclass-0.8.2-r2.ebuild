# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xclass/xclass-0.8.2-r2.ebuild,v 1.6 2009/05/05 08:03:00 ssuominen Exp $

DESCRIPTION="a C++ GUI toolkit for the X windows environment"
HOMEPAGE="http://xclass.sourceforge.net/"
SRC_URI="ftp://mitac11.uia.ac.be/pub/xclass/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha ~ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libXpm
	virtual/libc"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:example-app::' Makefile.in
	sed -i \
		-e 's:/usr/local/xclass-icons:/usr/share/icons/xclass:' \
		-e 's:/usr/local/xclass:/:' \
		lib/libxclass/Makefile.in
	sed -i \
		-e 's:/usr/local/xclass/icons:/usr/share/icons/xclass:' \
		-e 's:mime\.types:xclass.mime.types:' \
		doc/xclassrc
	sed -i \
		-e 's:OXListTree\:\:::' \
		include/xclass/OXListTree.h
}

src_compile() {
	econf --enable-shared=yes --with-x || die
	emake || die "'emake' failed"
}

src_install() {
	rm -rf `find . -name 'Makefile*'`

	dobin config/xc-config || die "xc-config failed"

	insinto /etc
	doins doc/xclassrc || die "xclassrc failed"
	newins doc/mime.types xclass.mime.types || die

	dodoc doc/*

	dodir /usr/share/icons/xclass
	insinto /usr/share/icons/xclass
	doins icons/*.xpm || die "icons failed"

	dodir /usr/include/xclass
	insinto /usr/include/xclass
	doins include/xclass/*.h || die "include failed"

	cd lib/libxclass
	dolib libxclass* || die "lib failed"
}
