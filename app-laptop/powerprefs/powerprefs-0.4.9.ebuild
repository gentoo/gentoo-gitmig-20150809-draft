# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/powerprefs/powerprefs-0.4.9.ebuild,v 1.2 2005/03/27 01:18:57 josejx Exp $

DESCRIPTION="program to interface with pbbuttonsd (Powerbook/iBook) keys"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4
	>=app-laptop/pbbuttonsd-0.6.8"

src_compile() {
	econf --prefix=/usr || die "powerprefs configure failed"
	emake || die "sorry, powerprefs compile failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "sorry, failed to install powerprefs"
	dodoc README
}
