# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-compress/xmms-compress-1.1.ebuild,v 1.3 2003/07/12 18:40:43 aliz Exp $

DESCRIPTION="xmms-compress is (essentially) a dynamic range compressor intended to keep the output of XMMS at a consistent volume without introducing any audible artifacts"
SRC_URI="http://trikuare.cx/~magenta/projects/${P}.tar.gz"
HOMEPAGE="http://trikuare.cx/~magenta/projects/xmms-compress.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

src_compile() {
	emake || die
}

src_install() {
	installdir="${D}$(xmms-config --effect-plugin-dir)"
	install -d ${installdir} || die
	install -m 755 libcompress.so ${installdir} || die
	dodoc COPYING ChangeLog README TODO
}
