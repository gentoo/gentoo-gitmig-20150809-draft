# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-imms/xmms-imms-1.2a.ebuild,v 1.7 2005/01/24 17:20:28 luckyduck Exp $

IUSE=""

inherit eutils

MY_P=${P/xmms-/}

DESCRIPTION="intelligent XMMS playlist plug-in that tracks your listening patterns and dynamically adapts to your taste"
HOMEPAGE="http://www.luminal.org/phpwiki/index.php/IMMS"
SRC_URI="mirror://sourceforge/imms/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="=dev-db/sqlite-3*
	media-sound/xmms
	>=media-libs/taglib-1.1
	>=dev-libs/libpcre-4.3
	=sci-libs/fftw-3*
	media-sound/sox"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.5
	>=sys-apps/sed-4.0.7"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}

	export WANT_AUTOCONF=2.5
	autoheader || die
	autoconf || die
}

src_install () {
	dobin build/immsremote || die
	dobin build/immstool || die
	dobin build/analyzer || die
	exeinto "`xmms-config --general-plugin-dir`"
	doexe build/libimms.so || die
	dodoc INSTALL LICENSE README
}
