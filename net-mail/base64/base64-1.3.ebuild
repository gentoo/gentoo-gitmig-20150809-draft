# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/base64/base64-1.3.ebuild,v 1.11 2004/07/15 01:30:16 agriffis Exp $

IUSE=""
DESCRIPTION="Command line program that encodes/decodes files in base64"
HOMEPAGE="http://www.fourmilab.ch/webtools/base64/"
SRC_URI="http://www.fourmilab.ch/webtools/base64/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc alpha ~ia64 ~ppc ~amd64"
DEPEND="virtual/libc"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	dobin base64
	doman base64.1
}
