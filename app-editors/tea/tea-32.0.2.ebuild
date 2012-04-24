# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-32.0.2.ebuild,v 1.1 2012/04/24 11:35:52 johu Exp $

EAPI=4
LANGS="de fr ru"

inherit eutils qt4-r2

DESCRIPTION="Small, lightweight Qt text editor"
HOMEPAGE="http://tea-editor.sourceforge.net/"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE="aspell hunspell"

RDEPEND="sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	aspell? ( app-text/aspell )
	hunspell? ( app-text/hunspell )"
DEPEND="${RDEPEND}
	hunspell? ( dev-util/pkgconfig )"

DOCS="AUTHORS ChangeLog NEWS TODO"

src_configure() {
	local myopts

	if use aspell; then
		myopts="USE_ASPELL=true"
	else
		myopts="USE_ASPELL=false"
	fi

	if use hunspell; then
		myopts="${myopts} USE_HUNSPELL=true"
	else
		myopts="${myopts} USE_HUNSPELL=false"
	fi

	eqmake4 src.pro PREFIX="/usr/bin" ${myopts}
}

src_install() {
	qt4-r2_src_install

	newicon icons/tea_icon_v2.png ${PN}.png
	make_desktop_entry ${PN} Tea ${PN}

	# translations
	insinto /usr/share/qt4/translations
	local lang
	for lang in ${LANGS}; do
		if use linguas_${lang}; then
			doins translations/${PN}_${lang}.qm
		fi
	done

	# docs
	dohtml manuals/en.html
	if use linguas_ru; then
		dodoc NEWS-RU
		dohtml manuals/ru.html
	fi
}
