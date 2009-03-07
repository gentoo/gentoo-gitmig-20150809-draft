# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-22.0.1.ebuild,v 1.1 2009/03/07 15:39:20 patrick Exp $

EAPI="1"
inherit qt4

DESCRIPTION="Small, lightweight Qt text editor"
HOMEPAGE="http://tea-editor.sourceforge.net"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE="spell"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-script"
RDEPEND="${DEPEND}
	spell? ( app-text/aspell )"

#S=${WORKDIR}/${MY_P}

src_compile() {
	eqmake4 src.pro
	emake  DESTDIR="${D}" || die "emake failed"
}

src_install() {
	dobin bin/tea || die "Couldn't install tea"
	dodoc AUTHORS ChangeLog NEWS NEWS-RU TODO
	doicon icons/tea_icon_v2.png

	make_desktop_entry tea Tea /usr/share/tea/pixmaps/tea_icon_v2.png Development
}

pkg_postinst() {
	if use spell ; then
		elog "To get full spellchecking functuality, ensure that you install"
		elog "the relevant language pack(s)"
	fi
}
