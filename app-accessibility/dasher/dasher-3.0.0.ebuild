# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.0.0.ebuild,v 1.1 2004/03/17 22:23:13 leonardop Exp $

DESCRIPTION="information-efficient text-entry interface, driven by natural continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"
SRC_URI="http://www.inference.phy.cam.ac.uk/dasher/download/linux/source/3.0/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="=dev-cpp/gtkmm-1.2*"

src_compile() {
	econf || die "bad ./configure"
	make || die "compile problem"
}

src_install() {
	make install DESTDIR=${D} || die
}
