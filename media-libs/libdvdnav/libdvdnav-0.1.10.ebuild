# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.10.ebuild,v 1.1 2005/01/16 22:50:34 luckyduck Exp $

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libdvdread"

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "Please remove old versions of libdvdnav manually,"
	einfo "having multiple versions installed can cause problems."
	einfo
}
