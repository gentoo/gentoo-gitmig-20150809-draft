# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-1.0.ebuild,v 1.2 2004/01/06 03:09:26 avenj Exp $

inherit flag-o-matic

DESCRIPTION="Console ftp client with a lot of nifty features"
SRC_URI="mirror://sourceforge/yafc/${P}.tar.bz2"
HOMEPAGE="http://yafc.sourceforge.net/"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"
RDEPEND=">=net-misc/openssh-3.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="readline"

src_compile() {
	append-flags -DHAVE_ERRNO_H
	econf `use_with readline` || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS BUGS COPYING COPYRIGHT INSTALL NEWS \
		README THANKS TODO *.sample
}
