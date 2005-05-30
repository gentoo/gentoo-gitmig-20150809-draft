# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-crossfade/bmp-crossfade-0.3.8-r3.ebuild,v 1.1 2005/05/30 20:56:55 chainsaw Exp $

IUSE=""
inherit eutils

MY_P=${P/bmp-/xmms-}
MY_PN=${PN/bmp-/xmms-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="BMP Plugin for crossfading, and continuous output."
SRC_URI="http://www.eisenlohr.org/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.eisenlohr.org/xmms-crossfade/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="media-sound/beep-media-player
	media-libs/libsamplerate"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-bmp.patch
	epatch ${FILESDIR}/${PV}-gcc4.patch
	epatch ${FILESDIR}/${PV}-op-fix.patch
	cp interface.c interface-2.0.c
	cp support.c support-2.0.c
}

src_compile() {
	econf --enable-player=beep \
		--disable-oss \
		--libdir=$(beep-config --output-plugin-dir) || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
