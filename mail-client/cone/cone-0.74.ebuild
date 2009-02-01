# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/cone/cone-0.74.ebuild,v 1.2 2009/02/01 22:03:02 maekke Exp $

inherit eutils

DESCRIPTION="CONE: COnsole News reader and Emailer"
HOMEPAGE="http://www.courier-mta.org/cone/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crypt fam spell"

RDEPEND=">=dev-libs/openssl-0.9.6
	dev-libs/libxml2
	fam? ( virtual/fam )
	crypt? ( >=app-crypt/gnupg-1.0.4 )
	spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_install() {
	emake install DESTDIR="${D}" || die
	DESTDIR=${D} emake install-configure || die

	dosed "3i export LANG=en_US" /usr/bin/cone
}
