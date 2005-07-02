# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htpdate/htpdate-0.8.2.ebuild,v 1.5 2005/07/02 11:02:23 dertobi123 Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Synchronize local workstation with time offered by remote web
servers"
HOMEPAGE="http://www.clevervest.com/htp/"
SRC_URI="http://www.clevervest.com/htp/archive/c/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	epatch ${FILESDIR}/ppc.patch
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die
}

src_install () {
	dosbin htpdate || die
	doman htpdate.8.gz || die
	dodoc README CHANGES || die
}
