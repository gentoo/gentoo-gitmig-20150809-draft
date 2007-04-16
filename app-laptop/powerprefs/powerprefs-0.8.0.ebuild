# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/powerprefs/powerprefs-0.8.0.ebuild,v 1.4 2007/04/16 13:02:33 josejx Exp $

DESCRIPTION="program to interface with pbbuttonsd (Powerbook/iBook) keys"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4
	>=app-laptop/pbbuttonsd-0.8.0"

src_compile() {
	econf || die "Failed to configure powerprefs"
	emake || die "Failed to compile powerprefs"
}

src_install() {
	make install DESTDIR=${D} || die "Failed to install powerprefs"
	dodoc README
}
