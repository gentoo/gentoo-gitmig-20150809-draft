# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/goldendict/goldendict-0.9.0.ebuild,v 1.2 2010/04/10 20:49:05 yngwin Exp $

EAPI="2"
LANGS="ru"
inherit qt4-r2 eutils

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}-src-x11.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/${P}-src"

RDEPEND=">=app-text/hunspell-1.2
	dev-libs/libzip
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libXtst
	=x11-libs/qt-webkit-4.5*:4"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc4.4.patch"
	# duplicates stuff into a directory we don't use
	sed -i \
		-e s/INSTALLS\ \+=\ desktops2//g \
		-e s/INSTALLS\ \+=\ icons2//g \
		"${S}"/goldendict.pro || die 'sed failed'
}

src_configure() {
	PREFIX=/usr eqmake4
}

src_compile() {
	if use linguas_ru ; then
		einfo 'Preparing translations...'
		lrelease ${PN}.pro || die 'lrelease failed'
	fi
	emake || die 'emake failed'
}

src_install() {
	qt4-r2_src_install
	for X in ${LINGUAS} ; do
		for Z in ${LANGS}; do
			if [[ ${X} == ${Z} ]]; then
				insinto /usr/share/apps/${PN}/locale
				doins locale/ru.qm || die 'doins failed'
			fi
		done
	done
}

pkg_postinst() {
	elog 'The portage tree contains various stardict and dictd dictionaries, which'
	elog 'GoldenDict can use. Also, check http://goldendict.berlios.de/dictionaries.php'
	elog 'for more options. The myspell packages can also be useful.'
}
