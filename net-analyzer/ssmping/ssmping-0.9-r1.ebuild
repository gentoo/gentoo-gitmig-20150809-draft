# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ssmping/ssmping-0.9-r1.ebuild,v 1.4 2007/09/12 11:57:20 angelos Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Tool for testing multicast connectivity"
HOMEPAGE="http://www.venaas.no/multicast/ssmping/"
SRC_URI="http://www.venaas.no/multicast/ssmping/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dobin ssmping asmping mcfirst
	dosbin ssmpingd
	doman ssmping.1 asmping.1 mcfirst.1
}
