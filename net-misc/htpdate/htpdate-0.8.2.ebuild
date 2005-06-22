# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htpdate/htpdate-0.8.2.ebuild,v 1.1 2005/06/22 13:58:35 dertobi123 Exp $

DESCRIPTION="Synchronize local workstation with time offered by remote web
servers"
HOMEPAGE="http://www.clevervest.com/htp/"
SRC_URI="http://www.clevervest.com/htp/archive/c/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's:CFLAGS =:#CFLAGS =:' \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die
}

src_install () {
	into /usr
	dosbin htpdate || die
	doman htpdate.8.gz || die
	dodoc README CHANGES || die
}

