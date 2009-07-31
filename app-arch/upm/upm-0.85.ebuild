# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upm/upm-0.85.ebuild,v 1.13 2009/07/31 09:37:03 volkmar Exp $

inherit eutils

DESCRIPTION="The micro Package Manager"
HOMEPAGE="http://u-os.org/upm.html"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/uos/sputnik/sources/${P}.tar.gz"

LICENSE="4F"
SLOT="0"
KEYWORDS="alpha ~hppa ppc ~sparc x86"
IUSE=""

DEPEND="sys-apps/fakeroot"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${P}.tar.gz
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-static.patch # bug 264067
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /bin
	make DESTDIR="${D}" install || die "make install failed"
	dodir /usr/upm/installed
	dodir /var/upm/{binary,cache}
}
