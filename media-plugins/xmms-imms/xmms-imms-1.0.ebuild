# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-imms/xmms-imms-1.0.ebuild,v 1.1 2004/01/27 19:23:42 eradicator Exp $

MY_P=${P/xmms-/}

DESCRIPTION="intelligent XMMS playlist plug-in that tracks your listening patterns and dynamically adapts to your taste"
HOMEPAGE="http://www.luminal.org/phpwiki/index.php/IMMS"
SRC_URI="mirror://sourceforge/imms/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-db/sqlite-2.8
	>=media-libs/id3lib-3.8
	>=media-sound/xmms-1.2.7-r20
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	sys-devel/autoconf
	>=dev-libs/libpcre-4.3"

S=${WORKDIR}/${MY_P}

src_compile() {
	WANT_AUTOCONF=2.5
	autoheader
	autoconf

	econf || die "configure failed"

	emake || die "make failed"
}

src_install () {
	exeinto "`xmms-config --visualization-plugin-dir`"
	doexe libimms.so || die
	dodoc ChangeLog INSTALL README
}
