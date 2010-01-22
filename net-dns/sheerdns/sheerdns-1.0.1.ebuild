# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/sheerdns/sheerdns-1.0.1.ebuild,v 1.5 2010/01/22 16:03:02 cla Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Sheerdns is a small, simple, fast master only DNS server"
HOMEPAGE="http://threading.2038bug.com/sheerdns/"
SRC_URI="http://threading.2038bug.com/sheerdns/${P}.tar.gz
	http://dev.gentoo.org/~iggy/${P}-${PR}.patch"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/${P}-${PR}.patch || die "failed to apply patch"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dodoc ChangeLog
	doman sheerdns.8
	dosbin sheerdns sheerdnshash
}
