# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upm/upm-0.85.ebuild,v 1.8 2004/03/12 11:03:07 mr_bones_ Exp $

inherit eutils

DESCRIPTION="The micro Package Manager"
HOMEPAGE="http://u-os.org/upm.html"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/uos/sputnik/sources/${P}.tar.gz"

LICENSE="4F"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha"
IUSE=""

DEPEND="sys-apps/fakeroot"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	emake
}

src_install() {
	dodir /bin
	make DESTDIR=${D} install || die
	dodir /usr/upm/installed
	dodir /var/upm/{binary,cache}
}
