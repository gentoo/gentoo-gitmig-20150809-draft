# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-realrandom/xmms-realrandom-0.2.ebuild,v 1.4 2004/02/14 16:25:15 absinthe Exp $

IUSE=""

MY_P=${P/xmms-realrandom/real_random}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Real Random XMMS Plugin"
SRC_URI="http://kingleo.home.pages.at/development/stuff/${MY_P}.tar.gz"
HOMEPAGE="http://kingleo.home.pages.at/index.php?show=/development/stuff"

LICENSE="GPL-2"
KEYWORDS="x86 amd64"
SLOT="0"

DEPEND="media-sound/xmms"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} libdir=$(xmms-config --general-plugin-dir) install || die
	dodoc AUTHORS README
}
