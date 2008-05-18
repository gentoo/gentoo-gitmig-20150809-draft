# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/scw/scw-0.4.7.ebuild,v 1.3 2008/05/18 13:38:28 drac Exp $

DESCRIPTION="A GTK+ widget set specifically designed for chat programs."
HOMEPAGE="http://scwwidgets.googlepages.com"
SRC_URI="http://scwwidgets.googlepages.com/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable doc gtk-doc)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
