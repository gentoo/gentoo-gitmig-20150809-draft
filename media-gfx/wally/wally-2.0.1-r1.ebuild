# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.0.1-r1.ebuild,v 1.2 2009/03/12 09:51:15 hwoarang Exp $

EAPI="2"
inherit eutils qt4

DESCRIPTION="A Qt4 wallpaper changer"
HOMEPAGE="http://wally.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

DEPEND="app-crypt/qca:2
	media-libs/libexif
	x11-libs/qt-gui:4
	kde? (	>=kde-base/kdelibs-4.2.0 )"

RDEPEND="${DEPEND}"

src_configure() {
	eqmake4
}

src_compile() {
	emake || die "emake failed"
	if use kde;then
		cd "${S}"/wallyplugin/build
		cmake .. || die "cmake wallyplugin failed"
		emake || die "emake wallyplugin failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	if use kde;then
		cd "${S}"/wallyplugin/build
		emake DESTDIR="${D}" install || die "emake install wallyplugin failed"
	fi
	newicon "${S}"/res/images/idle.png wally.png
	make_desktop_entry wally Wally wally "Graphics;Qt"
}

pkg_postinst() {
	if use kde;then
		elog
		elog "In order to use wallyplugin you need to"
		elog "logout and login again on your KDE4 enviroment."
		elog
	fi
}
