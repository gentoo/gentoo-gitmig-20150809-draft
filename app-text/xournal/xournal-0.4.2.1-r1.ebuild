# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.2.1-r1.ebuild,v 1.4 2009/08/02 13:15:16 maekke Exp $

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
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2"
RDEPEND="${DEPEND}
	pdf? ( virtual/poppler-utils virtual/ghostscript )"
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
