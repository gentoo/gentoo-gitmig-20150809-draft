# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvid4conf/xvid4conf-1.12.ebuild,v 1.1 2004/03/31 19:33:10 mholzer Exp $ 

DESCRIPTION="XviD4conf, a GTK2-configuration dialog for xvid4"
SRC_URI="http://zebra.fh-weingarten.de/~transcode/xvid4conf/${P}.tar.gz"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/xvid4conf"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-2.2.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa ~ia64"

src_compile() {
	[ -z "${CC}" ] && export CC="gcc"

	econf || die
	emake || die
}

src_install() {
	dodir /usr/{include,lib}
	einstall || die

	dodoc AUTHORS ChangeLog INSTALL README
}
