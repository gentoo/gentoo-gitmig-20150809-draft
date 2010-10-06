# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-28.1.2.ebuild,v 1.1 2010/10/06 20:02:57 chiiph Exp $

EAPI="2"
inherit eutils qt4-r2

DESCRIPTION="Small, lightweight Qt text editor"
HOMEPAGE="http://tea-editor.sourceforge.net/"
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
	dobin bin/tea || die
	dodoc AUTHORS ChangeLog NEWS NEWS-RU TODO || die
	doicon icons/tea_icon_v2.png || die

	make_desktop_entry tea Tea tea_icon_v2 Utility
}
