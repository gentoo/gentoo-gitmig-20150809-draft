# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.2.1.ebuild,v 1.4 2008/10/04 18:30:34 rbu Exp $

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
	pdf? ( app-text/poppler virtual/ghostscript )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

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
