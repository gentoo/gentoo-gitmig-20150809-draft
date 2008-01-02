# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mcrypt/mcrypt-2.6.7.ebuild,v 1.5 2008/01/02 15:39:38 angelos Exp $

inherit eutils

DESCRIPTION="replacement of the old unix crypt(1)"
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

DEPEND=">=dev-libs/libmcrypt-2.5.8
	>=app-crypt/mhash-0.9.9"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-qa.patch"
}

src_compile() {
	econf $(use_enable nls) || die "configure error"
	emake || die "make error"
}

src_install() {
	emake install DESTDIR="${D}" || die "install error"
	dodoc README NEWS AUTHORS THANKS TODO
}
