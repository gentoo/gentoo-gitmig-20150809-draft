# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/base64/base64-1.3.ebuild,v 1.1 2003/04/13 18:23:17 liquidx Exp $

IUSE=""
DESCRIPTION="Command line program that encodes/decodes files in base64"
HOMEPAGE="http://www.fourmilab.ch/webtools/base64/"
SRC_URI="http://www.fourmilab.ch/webtools/base64/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	dobin base64
	doman base64.1
}
