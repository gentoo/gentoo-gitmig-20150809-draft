# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.5-r2.ebuild,v 1.1 2011/08/17 21:12:05 dilfridge Exp $

EAPI=2
inherit gnome2 eutils

DESCRIPTION="Xournal is an application for notetaking, sketching, and keeping a journal using a stylus."
HOMEPAGE="http://xournal.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz http://dev.gentoo.org/~dilfridge/distfiles/${P}-sjg-image-rev7.patch.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pdf doc"

DEPEND=">=x11-libs/gtk+-2.10:2
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=app-text/poppler-0.12.3-r3[cairo]"
RDEPEND="${DEPEND}
	pdf? ( >=app-text/poppler-0.12.3-r3[utils] app-text/ghostscript-gpl )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-xoprint-len.patch #bug 287701
	epatch "${DISTDIR}"/${P}-sjg-image-rev7.patch.gz   # the image patch
}

src_configure() {
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	emake DESTDIR="${D}" desktop-install || die "desktop-install failed"

	dodoc ChangeLog AUTHORS README
	if use doc ; then
		dohtml -r html-doc/*
	fi
}
