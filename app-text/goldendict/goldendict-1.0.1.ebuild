# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/goldendict/goldendict-1.0.1.ebuild,v 1.4 2011/05/09 14:46:59 phajdan.jr Exp $

EAPI=3
LANGSLONG="ar_SA bg_BG cs_CZ de_DE el_GR it_IT lt_LT ru_RU uk_UA vi_VN zh_CN"

inherit qt4-r2

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.org"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug kde"

RDEPEND="
	>=app-text/hunspell-1.2
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib
	x11-libs/libXtst
	>=x11-libs/qt-core-4.5:4[exceptions]
	>=x11-libs/qt-gui-4.5:4[exceptions]
	>=x11-libs/qt-webkit-4.5:4[exceptions]
	!kde? ( || (
		>=x11-libs/qt-phonon-4.5:4[exceptions]
		media-libs/phonon
	) )
	kde? ( media-libs/phonon )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"
S="${WORKDIR}"

src_prepare() {
	qt4-r2_src_prepare

	# linguas
	for x in ${LANGSLONG}; do
		if use !linguas_${x%_*}; then
			sed -e "s,locale/${x}.ts,," \
				-i ${PN}.pro || die
		fi
	done

	# do not install duplicates
	sed -e '/[icon,desktop]s2/d' \
		-i ${PN}.pro || die
}

src_configure() {
	PREFIX="${EPREFIX}"/usr eqmake4
}

src_install() {
	qt4-r2_src_install

	# install translations
	insinto /usr/share/apps/${PN}/locale
	for x in ${LANGSLONG}; do
		if use linguas_${x%_*}; then
			doins locale/${x}.qm || die
		fi
	done
}
