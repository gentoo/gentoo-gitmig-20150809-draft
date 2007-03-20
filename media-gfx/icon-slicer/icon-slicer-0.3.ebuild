# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icon-slicer/icon-slicer-0.3.ebuild,v 1.14 2007/03/20 17:36:29 drac Exp $

DESCRIPTION="utility for generating icon themes and libXcursor cursor themes"
HOMEPAGE="http://www.freedesktop.org/software/icon-slicer/"
SRC_URI="http://www.freedesktop.org/software/icon-slicer/releases/${P}.tar.gz"

KEYWORDS="alpha amd64 ~hppa ia64 ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="x11-apps/xcursorgen
	>=x11-libs/gtk+-2
	dev-libs/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}
