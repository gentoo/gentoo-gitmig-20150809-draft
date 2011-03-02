# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/cairo-clock/cairo-clock-0.3.3.ebuild,v 1.3 2011/03/02 16:23:38 signals Exp $

EAPI=2

DESCRIPTION="An analog clock displaying the system-time."
HOMEPAGE="http://macslow.thepimp.net/?page_id=23"
SRC_URI="http://macslow.thepimp.net/projects/${PN}/${PN}_${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/glib:2
	>=gnome-base/libglade-2.6
	>=gnome-base/librsvg-2.14
	>=x11-libs/cairo-1.2
	x11-libs/gtk+:2
	>=x11-libs/pango-1.10"
DEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
