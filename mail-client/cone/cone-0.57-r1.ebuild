# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/cone/cone-0.57-r1.ebuild,v 1.2 2004/07/14 16:16:18 agriffis Exp $

inherit eutils

DESCRIPTION="Cone: COnsole News reader and Emailer"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/cone/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="crypt fam spell"

RDEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6
	dev-libs/libxml2
	fam? ( app-admin/fam )
	crypt? ( >=app-crypt/gnupg-1.0.4 )
	spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	dev-lang/perl"

EXTRA_ECONF="--with-devel"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/cone-dotsignature.patch
}

src_install() {
	make check DESTDIR=${D} || die
	make install DESTDIR=${D} || die
	DESTDIR=${D} make install-configure || die
}
