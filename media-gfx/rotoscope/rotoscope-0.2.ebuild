# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rotoscope/rotoscope-0.2.ebuild,v 1.3 2008/11/20 10:21:41 armin76 Exp $

DESCRIPTION="Graphics program that can be used to give photos a cartoon-like appearance."
HOMEPAGE="http://www.toonyphotos.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
}
