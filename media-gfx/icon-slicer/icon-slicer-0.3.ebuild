# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icon-slicer/icon-slicer-0.3.ebuild,v 1.3 2003/10/12 09:32:38 dholm Exp $

DESCRIPTION="utility for generating icon themes and libXcursor cursor themes"

HOMEPAGE="http://www.freedesktop.org/software/icon-slicer/"

SRC_URI="http://www.freedesktop.org/software/icon-slicer/releases/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86 ~sparc ~ppc"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	dev-libs/popt"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	#make DESTDIR=${D} install || die
	einstall || die
}
