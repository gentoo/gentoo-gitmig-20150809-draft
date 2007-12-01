# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/sheerdns/sheerdns-1.0.1.ebuild,v 1.4 2007/12/01 23:57:14 angelos Exp $

inherit eutils

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
}

src_compile() {
	make || die
}

src_install() {
	dodoc ChangeLog
	doman sheerdns.8
	dosbin sheerdns sheerdnshash
}
