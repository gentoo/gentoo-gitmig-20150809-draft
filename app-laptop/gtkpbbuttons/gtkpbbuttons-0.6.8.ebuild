# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/gtkpbbuttons/gtkpbbuttons-0.6.8.ebuild,v 1.1 2005/07/19 18:18:43 josejx Exp $

inherit eutils

DESCRIPTION="program to monitor special Powerbook/iBook keys"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=media-libs/audiofile-0.1.9
	>=app-laptop/pbbuttonsd-0.6.8"

src_compile() {
	econf || die "Configuration failed"
	make || die "Compile failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
