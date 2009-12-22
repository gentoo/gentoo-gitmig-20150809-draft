# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hping/hping-2.0.0_rc3-r2.ebuild,v 1.1 2009/12/22 21:17:15 jer Exp $

inherit eutils toolchain-funcs

MY_P="${PN}${PV//_/-}"
DESCRIPTION="A ping-like TCP/IP packet assembler/analyzer"
HOMEPAGE="http://www.hping.org"
SRC_URI="http://www.hping.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libpcap"

S="${WORKDIR}/${MY_P//\.[0-9]}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/bytesex.h.patch \
		"${FILESDIR}"/hping-bridge.patch \
		"${FILESDIR}"/${P}-gentoo.patch
	sed -i Makefile.in \
		-e "9s:gcc:$(tc-getCC):" \
		-e "10s:/usr/bin/ar:$(tc-getAR):" \
		-e "11s:/usr/bin/ranlib:$(tc-getRANLIB):" \
		-e "s:/usr/local/lib:/usr/$(get_libdir):g"
}

src_compile() {
	tc-export CC

	# Not an autotools type configure:
	sh configure || die "configure failed"

	emake CCOPT="${CFLAGS}" DEBUG="" || die "emake failed"
}

src_install () {
	dodir /usr/sbin
	dosbin hping2
	dosym /usr/sbin/hping2 /usr/sbin/hping

	doman docs/hping2.8
	dodoc INSTALL KNOWN-BUGS NEWS README TODO AUTHORS BUGS CHANGES COPYING docs/AS-BACKDOOR docs/HPING2-IS-OPEN docs/MORE-FUN-WITH-IPID docs/*.txt
}
