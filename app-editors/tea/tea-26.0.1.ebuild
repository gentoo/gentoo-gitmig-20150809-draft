# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-26.0.1.ebuild,v 1.1 2009/11/07 22:45:40 billie Exp $

EAPI="2"

inherit eutils qt4

DESCRIPTION="Small, lightweight Qt text editor"
HOMEPAGE="http://tea-editor.sourceforge.net"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE="aspell hunspell"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-script:4"
RDEPEND="${DEPEND}
	aspell? ( app-text/aspell )
	hunspell? ( app-text/hunspell )"

src_configure() {
	local myopts
	if use aspell ; then
		myopts="USE_ASPELL=true"
	else
		myopts="USE_ASPELL=false"
	fi

	if use hunspell ; then
		myopts="${myopts} USE_HUNSPELL=true"
	else
		myopts="${myopts} USE_HUNSPELL=false"
	fi

	eqmake4 src.pro PREFIX="/usr/bin" ${myopts}
}

src_install() {
	dobin bin/tea || die "Couldn't install tea"
	dodoc AUTHORS ChangeLog NEWS NEWS-RU TODO
	doicon icons/tea_icon_v2.png

	make_desktop_entry tea Tea tea_icon_v2.png Utility
}

pkg_postinst() {
	if use aspell || use hunspell ; then
		elog "To get full spellchecking functuality, ensure that you install"
		elog "the relevant language pack(s)"
	fi
}
