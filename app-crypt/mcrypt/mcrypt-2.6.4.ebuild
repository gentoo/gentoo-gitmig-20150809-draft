# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mcrypt/mcrypt-2.6.4.ebuild,v 1.7 2004/06/06 15:48:33 dragonheart Exp $

DESCRIPTION="replacement of the old unix crypt(1)"
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64"
IUSE="nls"

DEPEND=">=dev-libs/libmcrypt-2.5.7
	>=app-crypt/mhash-0.8.15"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf} || die "configure error"
	emake || die "make error"
}

src_install() {
	einstall || die "install error"
	dodoc README NEWS AUTHORS THANKS TODO
}
