# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-compress/xmms-compress-1.1.ebuild,v 1.4 2003/08/07 04:01:02 vapier Exp $

DESCRIPTION="dynamic range compressor intended to keep the output of XMMS at a consistent volume without introducing any audible artifacts"
HOMEPAGE="http://trikuare.cx/~magenta/projects/xmms-compress.html"
SRC_URI="http://trikuare.cx/~magenta/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

src_compile() {
	emake || die
}

src_install() {
	exeinto "$(xmms-config --effect-plugin-dir)" || die
	doexe libcompress.so || die
	dodoc COPYING ChangeLog README TODO
}
