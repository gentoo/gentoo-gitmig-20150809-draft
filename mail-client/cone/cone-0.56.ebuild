# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/cone/cone-0.56.ebuild,v 1.7 2004/11/29 22:57:13 ticho Exp $

DESCRIPTION="COnsole News reader and Emailer"
HOMEPAGE="http://www.courier-mta.org/cone/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="crypt fam spell"

RDEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6
	dev-libs/libxml2
	fam? ( virtual/fam )
	crypt? ( >=app-crypt/gnupg-1.0.4 )
	spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_compile() {
	econf --with-devel || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		check install install-configure || die

	dosed "3i export LANG=en_US" /usr/bin/cone
}
