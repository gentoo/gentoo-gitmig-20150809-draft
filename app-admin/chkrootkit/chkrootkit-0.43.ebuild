# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chkrootkit/chkrootkit-0.43.ebuild,v 1.10 2004/06/25 16:06:10 vapier Exp $

inherit eutils

DESCRIPTION="a tool to locally check for signs of a rootkit"
HOMEPAGE="http://www.chkrootkit.org/"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz"

LICENSE="AMS"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~ia64 amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	sed -i 's:${head} -:${head} -n :' chkrootkit
}

src_compile() {
	make sense || die
	make strings || die
}

src_install() {
	dosbin check_wtmpx chklastlog chkproc chkrootkit chkwtmp ifpromisc || die
	newsbin strings strings-static || die
	dodoc README README.chklastlog README.chkwtmp
}
