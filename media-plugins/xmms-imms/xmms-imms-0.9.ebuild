# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-imms/xmms-imms-0.9.ebuild,v 1.4 2004/01/26 00:40:17 vapier Exp $

MY_P=${P/xmms-/}

DESCRIPTION="intelligent XMMS playlist plug-in that tracks your listening patterns and dynamically adapts to your taste"
HOMEPAGE="http://www.luminal.org/phpwiki/index.php/IMMS"
SRC_URI="mirror://sourceforge/imms/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-db/sqlite
	media-libs/id3lib
	media-sound/xmms
	oggvorbis? ( media-libs/libvorbis )"

S=${WORKDIR}/${MY_P}

src_compile() {
	WANT_AUTOCONF=2.5
	autoheader
	autoconf

	econf || die "configure failed"

	emake || die "make failed"
}

src_install () {
	insinto "`xmms-config --general-plugin-dir`"
	doins libimms.so || die
	dodoc ChangeLog INSTALL README
}
