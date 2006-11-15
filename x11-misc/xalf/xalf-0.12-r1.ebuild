# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xalf/xalf-0.12-r1.ebuild,v 1.18 2006/11/15 20:40:33 nelchael Exp $

IUSE="gnome"

DESCRIPTION="X11 Application Launch Feedback"
SRC_URI="http://www.lysator.liu.se/~astrand/projects/xalf/${P}.tgz"
HOMEPAGE="http://www.lysator.liu.se/~astrand/projects/xalf/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc sparc x86"

DEPEND="=x11-libs/gtk+-1.2*
	x11-libs/libXmu
	gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1
		gnome-base/control-center )"

src_compile() {

	local myconf

	if use gnome
	then
		myconf="--prefix=/usr --enable-capplet"
	else
		myconf="--prefix=/usr --disable-capplet"
	fi

	./configure ${myconf} || die "Failed to configure package."

	emake || die "Failed to build package."
}

src_install() {

	make prefix=${D}/usr install || die

	dodoc AUTHORS ChangeLog README
}
