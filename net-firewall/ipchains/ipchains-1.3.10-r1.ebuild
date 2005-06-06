# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipchains/ipchains-1.3.10-r1.ebuild,v 1.6 2005/06/06 04:22:34 vapier Exp $

inherit eutils

DESCRIPTION="legacy Linux firewall/packet mangling tools"
HOMEPAGE="http://netfilter.filewatcher.org/ipchains/"
SRC_URI="http://netfilter.kernelnotes.org/ipchains/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ipchains-1.3.10-gcc34.patch
	epatch "${FILESDIR}"/ipchains-1.3.10-fixman.patch
	epatch "${FILESDIR}"/ipchains-1.3.10-nonroot.patch
	sed -i \
		-e "s/= -g -O/= ${CFLAGS}/" \
		Makefile libipfwc/Makefile \
		|| die "sed CFLAGS"
}

src_compile() {
	make clean || die
	emake all || die
}

src_install() {
	into /
	dosbin ipchains || die
	doman ipfw.4 ipchains.8
	dodoc README
	docinto ps
	dodoc ipchains-quickref.ps
}
