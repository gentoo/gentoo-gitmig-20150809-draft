# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kiax/kiax-0.8.4.ebuild,v 1.2 2005/07/10 18:33:30 stkn Exp $

inherit eutils kde-functions

IUSE=""

DESCRIPTION="QT based IAX (Inter Asterisk eXchange) client"
HOMEPAGE="http://kiax.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiax/${P}.tar.bz2"

KEYWORDS="x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=x11-libs/qt-3.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-0.8.4-iaxwrapper.patch

	# add prefix for make install
	sed -i -e "s:\(\$(DEST_PATH)\):\${INSTALL_ROOT}\1:" \
		bin/Makefile
}

src_compile() {
	set-qtdir 3

	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	make INSTALL_ROOT=${D} install || die "make install failed"

	domenu kiax.desktop
	dodoc README README.* CHANGELOG COPYING INSTALL INSTALL.*
}
