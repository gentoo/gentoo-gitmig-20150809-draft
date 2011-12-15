# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.5_p20111022-r1.ebuild,v 1.4 2011/12/15 12:22:40 ago Exp $

EAPI=4

GCONF_DEBUG=no

inherit base gnome2 autotools

DESCRIPTION="Xournal is an application for notetaking, sketching, and keeping a journal using a stylus."
HOMEPAGE="http://xournal.sourceforge.net/"

SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz http://dev.gentoo.org/~dilfridge/distfiles/${P}-sjg-image-rev7.patch.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+pdf"

COMMONDEPEND="
	app-text/poppler[cairo]
	dev-libs/atk
	dev-libs/glib
	gnome-base/libgnomecanvas
	media-libs/freetype
	media-libs/fontconfig
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
"
RDEPEND="${COMMONDEPEND}
	pdf? ( app-text/poppler[utils] app-text/ghostscript-gpl )
"
DEPEND="${COMMONDEPEND}
	dev-util/pkgconfig
"

PATCHES=(
	"${DISTDIR}"/${P}-sjg-image-rev7.patch.gz
	"${FILESDIR}"/${P}-gtk-recent.patch
	"${FILESDIR}"/${P}-aspectratio.patch
	"${FILESDIR}"/${P}-underlinking.patch
)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" desktop-install

	dodoc ChangeLog AUTHORS README
	dohtml -r html-doc/*
}
