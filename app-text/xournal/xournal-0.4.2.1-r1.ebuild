# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.2.1-r1.ebuild,v 1.7 2011/03/27 12:25:04 nirbheek Exp $

EAPI=2
inherit gnome2 autotools
DESCRIPTION="Xournal is an application for notetaking, sketching, and keeping a journal using a stylus."
HOMEPAGE="http://xournal.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pdf doc"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.6:2
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2"
RDEPEND="${DEPEND}
	pdf? ( >=app-text/poppler-0.12.3-r3[utils] app-text/ghostscript-gpl )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pdf-annotation.patch #bug 257980

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	emake DESTDIR="${D}" desktop-install || die "desktop-install failed"

	dodoc ChangeLog AUTHORS README
	if use doc ; then
		dohtml -r html-doc/*
	fi
}
