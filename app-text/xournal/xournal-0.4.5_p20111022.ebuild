# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.5_p20111022.ebuild,v 1.3 2011/11/17 09:47:38 chainsaw Exp $

EAPI=4

GCONF_DEBUG=no

inherit gnome2 eutils autotools

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

src_prepare() {
	epatch "${DISTDIR}"/${P}-sjg-image-rev7.patch.gz   # the image patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" desktop-install

	dodoc ChangeLog AUTHORS README
	dohtml -r html-doc/*
}
