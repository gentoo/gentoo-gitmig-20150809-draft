# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/scw/scw-0.4.7.ebuild,v 1.1 2007/03/06 16:16:34 ticho Exp $

DESCRIPTION="A GTK+ widget set specifically designed for chat programs."
HOMEPAGE="http://scwwidgets.googlepages.com"
SRC_URI="http://scwwidgets.googlepages.com/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="doc"
RDEPEND="dev-util/pkgconfig
	>=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1 )"

src_compile() {
	econf $(use_enable doc gtk-doc) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README NEWS ChangeLog AUTHORS
}
