# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.22.2.ebuild,v 1.7 2004/11/01 20:15:13 corsair Exp $

DESCRIPTION="a command-line WebDAV client."
HOMEPAGE="http://www.webdav.org/cadaver"
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~ppc64 ~ppc-macos"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf $(use_with ssl) || die "econf failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc BUGS ChangeLog COPYING FAQ INSTALL NEWS README THANKS TODO
}

