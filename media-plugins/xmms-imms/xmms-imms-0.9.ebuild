# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-imms/xmms-imms-0.9.ebuild,v 1.3 2003/09/08 07:17:25 msterret Exp $

IUSE=""

MY_P=${P/xmms-/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MMS is an intelligent playlist plug-in for XMMS that tracks your listening patterns and dynamically adapts to your taste."
SRC_URI="mirror://sourceforge/imms/${MY_P}.tar.bz2"
HOMEPAGE="http://www.luminal.org/phpwiki/index.php/IMMS"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-db/sqlite
	media-libs/id3lib
	media-sound/xmms
	oggvorbis? ( media-libs/libvorbis )"

src_compile() {
	WANT_AUTOCONF_2_5=1
	autoheader
	autoconf

	econf || die "configure failed"

	emake || die "make failed"
}

src_install () {
	insinto "`xmms-config --general-plugin-dir`"
	doins libimms.so

	dodoc ChangeLog INSTALL LICENSE README
}


