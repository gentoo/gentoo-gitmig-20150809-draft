# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbear/dropbear-0.42.ebuild,v 1.1 2004/06/21 13:32:07 vapier Exp $

DESCRIPTION="small SSH 2 server designed for small memory environments"
HOMEPAGE="http://matt.ucc.asn.au/dropbear/"
SRC_URI="http://matt.ucc.asn.au/dropbear/releases/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc mips arm"
IUSE="zlib"

DEPEND="zlib? ( sys-libs/zlib )"

src_compile() {
	econf `use_enable zlib` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/dropbear.init.d dropbear
	insinto /etc/conf.d ; newins ${FILESDIR}/dropbear.conf.d dropbear
	dodoc CHANGES README TODO SMALL
}
