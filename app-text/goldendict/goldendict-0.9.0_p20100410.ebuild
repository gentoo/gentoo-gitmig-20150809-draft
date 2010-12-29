# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/goldendict/goldendict-0.9.0_p20100410.ebuild,v 1.1 2010/12/29 09:06:33 pva Exp $

EAPI="3"
LANGSLONG="ar_SA bg_BG cs_CZ de_DE el_GR lt_LT ru_RU zh_CN"

inherit qt4-r2

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.berlios.de/"
SRC_URI="http://omploader.org/vNDQ1cQ/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

RDEPEND=">=app-text/hunspell-1.2
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib
	x11-libs/libXtst
	>=x11-libs/qt-core-4.5:4[exceptions]
	>=x11-libs/qt-gui-4.5:4[exceptions]
	>=x11-libs/qt-webkit-4.5:4[exceptions]
	!kde? ( || (
		>=x11-libs/qt-phonon-4.5:4[exceptions]
		media-sound/phonon
	) )
	kde? ( media-sound/phonon )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	qt4-r2_src_install

	# install translations
	insinto /usr/share/apps/${PN}/locale
	for lang in ${LANGSLONG}; do
		if use linguas_${lang%_*}; then
			doins locale/${lang}.qm || die
		fi
	done
}
