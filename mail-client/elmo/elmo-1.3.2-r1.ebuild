# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/elmo/elmo-1.3.2-r1.ebuild,v 1.2 2004/11/15 21:20:54 citizen428 Exp $

inherit eutils

IUSE="crypt nls ssl"

DESCRIPTION="Elmo: console email client"
HOMEPAGE="http://elmo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="x86"
SLOT="0"

RDEPEND="ssl? ( >=dev-libs/openssl )
	nls? ( sys-devel/gettext )
	crypt? ( >=app-crypt/gpgme-0.9.0 )"


src_compile() {
	local myconf

	epatch ${FILESDIR}/configure.in.patch

	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with crypt gpgme`"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ABOUT-NLS ADVOCACY AUTHORS BUGS COPYING ChangeLog INSTALL NEWS THANKS TODO doc/*
}

pkg_postinst() {
	einfo "If you compiled elmo with GCC 3.4 and experience run-time problems, please consider recompiling with GCC 3.3."
}
