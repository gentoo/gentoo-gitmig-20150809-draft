# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/cairo-clock/cairo-clock-0.3.2.ebuild,v 1.2 2007/03/02 13:09:41 uberlord Exp $

DESCRIPTION="An analog clock displaying the system-time."
HOMEPAGE="http://macslow.thepimp.net/?page_id=23"
SRC_URI="http://macslow.thepimp.net/projects/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.8.0
	>=gnome-base/libglade-2.5.1
	>=gnome-base/librsvg-2.13.91
	>=x11-libs/cairo-1.0.0
	>=x11-libs/gtk+-2.8.0
	>=x11-libs/pango-1.10.0"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
