# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/frameworks/frameworks-0.3.7.ebuild,v 1.2 2011/03/23 08:32:23 radhermit Exp $

EAPI=2

DESCRIPTION="A small v4l frame capture utility especially suited for stop motion animation."
SRC_URI="http://frameworks.polycrystal.org/release/${P}.tar.gz"
HOMEPAGE="http://frameworks.polycrystal.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

RDEPEND=">=gnome-base/libglade-2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
