# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-compress/xmms-compress-1.1.ebuild,v 1.1 2002/10/29 13:24:54 seemant Exp $

DESCRIPTION="xmms-compress is (essentially) a dynamic range compressor intended to keep the output of XMMS at a consistent volume without introducing any audible artifacts"
SRC_URI="http://trikuare.cx/~magenta/projects/${P}.tar.gz"
HOMEPAGE="http://trikuare.cx/~magenta/projects/xmms-compress.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

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
