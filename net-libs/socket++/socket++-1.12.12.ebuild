# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/socket++/socket++-1.12.12.ebuild,v 1.1 2004/12/16 09:30:28 swegener Exp $

DESCRIPTION="C++ Socket Library"
HOMEPAGE="http://www.linuxhacker.at/socketxx/"
SRC_URI="http://www.linuxhacker.at/linux/downloads/src/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="=sys-devel/automake-1.7*
	=sys-devel/autoconf-2.59*
	sys-devel/libtool
	sys-apps/texinfo"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	WANT_AUTOMAKE=1.7 WANT_AUTOCONF=2.5  ./autogen || die "./autogen failed"
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README* THANKS || die "dodoc failed"
}
