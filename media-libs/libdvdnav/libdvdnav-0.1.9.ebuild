# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.9.ebuild,v 1.10 2004/11/14 00:02:18 kito Exp $

inherit eutils

DESCRIPTION="Library for DVD navigation tools."
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64 ~ppc-macos"
IUSE=""

DEPEND="media-libs/libdvdread"

src_unpack() {
	unpack ${A}
	use ppc-macos && epatch ${FILESDIR}/${P}-darwin.diff
}

src_compile() {
	use ppc-macos && CFLAGS="${CFLAGS} -D__DARWIN__"
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "Please remove old versions of libdvdnav manually,"
	einfo "having multiple versions installed can cause problems."
	einfo
}