# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rotoscope/rotoscope-0.2.ebuild,v 1.5 2011/03/12 22:00:37 radhermit Exp $

EAPI=2

DESCRIPTION="Graphics program that can be used to give photos a cartoon-like appearance."
HOMEPAGE="http://www.toonyphotos.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
}
