# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ezbounce/ezbounce-1.04a.ebuild,v 1.3 2004/01/07 06:44:39 mr_bones_ Exp $

DESCRIPTION="ezbounce is a small IRC bouncer"
HOMEPAGE="http://druglord.freelsd.org/ezbounce/"
SRC_URI="http://druglord.freelsd.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="ssl"
DEPEND=">=net-misc/mdidentd-1.04a
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-crash-fix.patch
}

src_compile() {
	local myconf

	use ssl && myconf="${myconf} --with-ssl"

	econf ${myconf} || die
	emake  || die
}

src_install() {
	dobin ezbounce
	dodoc README
	doman misc/ezbounce.1
}
