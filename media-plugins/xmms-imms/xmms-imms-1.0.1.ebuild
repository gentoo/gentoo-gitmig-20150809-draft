# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-imms/xmms-imms-1.0.1.ebuild,v 1.3 2004/03/26 21:59:31 eradicator Exp $

inherit eutils

MY_P=${P/xmms-/}

DESCRIPTION="intelligent XMMS playlist plug-in that tracks your listening patterns and dynamically adapts to your taste"
HOMEPAGE="http://www.luminal.org/phpwiki/index.php/IMMS"
SRC_URI="mirror://sourceforge/imms/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

RDEPEND=">=dev-db/sqlite-2.8
	>=media-libs/id3lib-3.8
	>=media-sound/xmms-1.2.7-r20
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	>=dev-libs/libpcre-4.3"

DEPEND="$RDEPEND
	>=sys-devel/autoconf-2.5
	>=sys-apps/sed-4.0.7"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch

	WANT_AUTOCONF=2.5
	autoheader
	autoconf
}

src_install () {
	exeinto "`xmms-config --visualization-plugin-dir`"
	doexe libimms.so || die
	dodoc INSTALL LICENSE README
}
