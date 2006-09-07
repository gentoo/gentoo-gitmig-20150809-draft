# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.22.3.ebuild,v 1.1 2006/09/07 04:39:51 beandog Exp $

DESCRIPTION="Command-line WebDAV client."
HOMEPAGE="http://www.webdav.org/cadaver"
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~ppc64 ~ppc-macos ~amd64"
IUSE="nls"

DEPEND="virtual/libc
	>=net-misc/neon-0.25.4"

pkg_setup() {
	ewarn "System installed neon is now utilized -- if you require SSL support"
	ewarn "make sure to turn it on in net-misc/neon"
}

src_compile() {
	myconf="--with-libs=/usr $(use_enable nls)"
	econf $myconf || die "econf failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc BUGS ChangeLog FAQ NEWS README THANKS TODO
}
