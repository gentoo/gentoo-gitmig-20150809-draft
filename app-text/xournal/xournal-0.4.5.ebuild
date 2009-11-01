# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.5.ebuild,v 1.2 2009/11/01 17:48:37 rbu Exp $

EAPI=2
inherit gnome2

DESCRIPTION="Xournal is an application for notetaking, sketching, and keeping a journal using a stylus."
HOMEPAGE="http://xournal.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pdf doc"

DEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=virtual/poppler-glib-0.5.4"
RDEPEND="${DEPEND}
	pdf? ( virtual/poppler-utils virtual/ghostscript )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

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
