# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-realrandom/xmms-realrandom-0.2-r1.ebuild,v 1.1 2003/08/12 10:10:39 joker Exp $

IUSE=""

MY_P=${P/xmms-realrandom/real_random}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Real Random XMMS Plugin"
SRC_URI="http://kingleo.home.pages.at/development/stuff/${MY_P}.tar.gz"
HOMEPAGE="http://kingleo.home.pages.at/index.php?show=/development/stuff"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Replace generic random function with one that uses /dev/urandom
	cp real_random.c real_random.c.orig
	sed 's/srand( time(NULL) );/srandomdev();/' <real_random.c.orig >real_random.c
}

src_compile() {     
	econf || die
	emake || die
}

src_install() {        
	make DESTDIR=${D} libdir=$(xmms-config --general-plugin-dir) install || die
	dodoc AUTHORS README	
}
