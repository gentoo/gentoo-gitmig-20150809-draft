# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cxx/log4cxx-0.9.5.ebuild,v 1.6 2005/01/06 13:49:00 ka0ttic Exp $

inherit eutils

DESCRIPTION="Library of C++ classes for flexible logging to files, syslog and other destinations"
HOMEPAGE="http://log4cxx.sourceforge.net/"
SRC_URI="mirror://sourceforge/log4cxx/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
		dev-libs/libxml2"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-errno.diff
}

src_compile() {
	./autogen.sh || die "autogen.sh failed"
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
}
