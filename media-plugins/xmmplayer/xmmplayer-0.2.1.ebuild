# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmmplayer/xmmplayer-0.2.1.ebuild,v 1.3 2004/02/15 12:00:34 eradicator Exp $

DESCRIPTION="XMMPlayer is an input plugin for XMMS"
HOMEPAGE="http://thegraveyard.org/xmmplayer.php"
SRC_URI="http://thegraveyard.org/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND="media-sound/xmms
	media-video/mplayer"

src_compile() {
	econf \
		--prefix=/usr/lib
		--with-xmms-prefix=/usr/include/xmms
	emake || die
}

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING README
}

pkg_postinst() {
	einfo "*** WARNING: XMMS will play all mplayer supported file"
	einfo "once the mplayer input plugin is configured"
}
