# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-0.7.9.ebuild,v 1.3 2002/08/16 14:24:50 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console ftp client with a lot of nifty features"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://yafc.sourceforge.net/"

DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"
RDEPEND=">=net-misc/openssh-3.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	use readline || myconf="--without-readline"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS BUGS COPYING COPYRIGHT INSTALL NEWS \
		README THANKS TODO *.sample
}
