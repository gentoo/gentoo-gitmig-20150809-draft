# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gpasman/gpasman-1.3.0.ebuild,v 1.15 2004/06/24 22:20:35 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gpasman: GTK Password manager"
# This is _NOT_ the offical download site, but the official site
# seems to not work (ever).
SRC_URI="http://gpasman.nl.linux.org/${P}.tar.gz"
HOMEPAGE="http://gpasman.nl.linux.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_install() {
	dodir /usr/bin
	emake prefix=${D}/usr install

	dodoc ChangeLog AUTHORS README BUGS NEWS
}
