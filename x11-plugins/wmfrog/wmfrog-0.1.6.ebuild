# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfrog/wmfrog-0.1.6.ebuild,v 1.5 2004/08/01 08:00:25 s4t4n Exp $

IUSE=""
DESCRIPTION="This is a weather application, it shows the weather in a graphical way."
SRC_URI="http://www.colar.net/wmapps/wmFrog-${PV}.tgz"
HOMEPAGE="http://www.colar.net/wmapps/"

DEPEND="virtual/x11
	dev-lang/perl
	net-misc/wget"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

S=${WORKDIR}/wmFrog/Src

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die
	cd ..
	dodoc CHANGES COPYING HINTS
}
