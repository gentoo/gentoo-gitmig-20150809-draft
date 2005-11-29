# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upm/upm-0.85.ebuild,v 1.11 2005/11/29 03:01:44 vapier Exp $

inherit eutils

DESCRIPTION="The micro Package Manager"
HOMEPAGE="http://u-os.org/upm.html"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/uos/sputnik/sources/${P}.tar.gz"

LICENSE="4F"
SLOT="0"
KEYWORDS="alpha ~hppa ppc ~sparc x86"
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
