# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icon-slicer/icon-slicer-0.3.ebuild,v 1.11 2006/02/11 04:14:32 joshuabaergen Exp $

DESCRIPTION="utility for generating icon themes and libXcursor cursor themes"
HOMEPAGE="http://www.freedesktop.org/software/icon-slicer/"
SRC_URI="http://www.freedesktop.org/software/icon-slicer/releases/${P}.tar.gz"

KEYWORDS="x86 sparc ppc alpha ia64 amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="|| ( x11-apps/xcursorgen
			virtual/x11 )
	>=x11-libs/gtk+-2.0
	dev-libs/popt"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
