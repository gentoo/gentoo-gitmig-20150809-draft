# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/dumb-bmp/dumb-bmp-0.01.ebuild,v 1.1 2004/12/21 19:43:57 chainsaw Exp $

IUSE=""

DESCRIPTION="BMP plugin to play MOD style files using the dumb libs."
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="http://mitglied.lycos.de/mldoering/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}/${PN}

DEPEND="media-sound/beep-media-player
	media-libs/dumb"

src_compile() {
	emake || die
}

src_install () {
	insinto "`pkg-config bmp --variable=input_plugin_dir`"
	doins libdumb-bmp.so
}
