# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvid4conf/xvid4conf-1.12.ebuild,v 1.5 2004/08/14 14:47:10 swegener Exp $

DESCRIPTION="GTK2-configuration dialog for xvid4"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/xvid4conf"
SRC_URI="http://zebra.fh-weingarten.de/~transcode/xvid4conf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE=""

DEPEND="virtual/libc
	>=x11-libs/gtk+-2.2.4"

src_install() {
	dodir /usr/{include,lib}
	einstall || die

	dodoc AUTHORS ChangeLog INSTALL README
}
