# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-infopipe/bmp-infopipe-1.3.ebuild,v 1.2 2004/12/05 19:33:09 chainsaw Exp $

inherit eutils
IUSE=""

MY_P=${P/bmp-/xmms-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Publish information about currently playing song in BMP to a temp file"
SRC_URI="http://www.beastwithin.org/users/wwwwolf/code/xmms/${MY_P}.tar.gz http://www.beastwithin.org/users/wwwwolf/code/xmms/${MY_P}-for-beepmp.patch.gz"
HOMEPAGE="http://www.beastwithin.org/users/wwwwolf/code/xmms/infopipe.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/beep-media-player"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${MY_P}-for-beepmp.patch
	epatch ${FILESDIR}/${PV}-includes.patch

	ebegin "Rebuilding configure script (this will take a while)"
	WANT_AUTOMAKE=1.6 WANT_AUTOCONF=2.5 autoreconf -i -f
	eend
}

src_install () {
	exeinto `beep-config --general-plugin-dir`
	doexe ${S}/src/.libs/libinfopipe.so
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
