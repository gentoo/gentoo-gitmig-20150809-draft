# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/speedcrunch/speedcrunch-0.10.1.ebuild,v 1.3 2009/12/25 17:56:38 yngwin Exp $

EAPI=1

inherit eutils cmake-utils

DESCRIPTION="A fast and usable calculator for power users"
HOMEPAGE="http://speedcrunch.org/"
SRC_URI="http://speedcrunch.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="x11-libs/qt-gui:4"

LANGS="ca cs de en es es_AR eu fi fr he id it nb nl no pl
	pt pt_BR ro ru sv tr zh_CN"
for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

S="${WORKDIR}/${P}/src"

src_unpack( ) {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-iconname.patch
	# regenerate translations
	lrelease speedcrunch.pro || die
	for lang in ${LANGS}; do
		if ! use linguas_${lang}; then
			sed -i -e "s:i18n/${lang}\.qm::" Translations.cmake || die
			sed -i -e "s:books/${lang}::" CMakeLists.txt || die
		fi
	done
}

src_install() {
	cmake-utils_src_install
	cd ..
	dodoc ChangeLog ChangeLog.floatnum HACKING.txt LISEZMOI README TRANSLATORS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf || die
	fi
}
