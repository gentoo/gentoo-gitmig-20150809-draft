# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/powerprefs/powerprefs-0.4.4.ebuild,v 1.5 2005/01/01 14:48:17 eradicator Exp $

DESCRIPTION="program to interface with pbbuttonsd (Powerbook/iBook) keys"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=app-laptop/pbbuttonsd-0.5"

src_compile() {
	./configure --prefix=/usr || die "sorry, powerprefs configure failed"
	make || die "sorry, powerprefs compile failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "sorry, failed to install powerprefs"
	dodoc README
}
