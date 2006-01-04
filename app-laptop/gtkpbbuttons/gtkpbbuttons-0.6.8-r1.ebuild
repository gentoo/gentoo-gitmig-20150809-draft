# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/gtkpbbuttons/gtkpbbuttons-0.6.8-r1.ebuild,v 1.2 2006/01/04 05:37:27 halcy0n Exp $

inherit eutils

DESCRIPTION="On screen display client for pbbuttonsd"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="gnome"

DEPEND=">=x11-libs/gtk+-2.0
	>=media-libs/audiofile-0.1.9
	dev-libs/popt
	>=app-laptop/pbbuttonsd-0.6.8
	gnome? ( gnome-base/libgnomeui )"

src_compile() {
	econf $(use_with gnome) || die "Configuration failed"
	make || die "Compile failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
