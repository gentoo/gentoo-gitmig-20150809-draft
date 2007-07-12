# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.22.2.ebuild,v 1.13 2007/07/12 02:52:15 mr_bones_ Exp $

DESCRIPTION="Command-line WebDAV client."
HOMEPAGE="http://www.webdav.org/cadaver"
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ppc64 ~sparc x86"
IUSE="ssl"

DEPEND="virtual/libc
	net-misc/neon
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf $(use_with ssl) || die "econf failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc BUGS ChangeLog COPYING FAQ INSTALL NEWS README THANKS TODO
}
