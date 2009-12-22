# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hping/hping-3_pre20051105-r1.ebuild,v 1.2 2009/12/22 21:17:15 jer Exp $

inherit eutils multilib toolchain-funcs

MY_P="${PN}${PV//_pre/-}"
DESCRIPTION="A ping-like TCP/IP packet assembler/analyzer"
HOMEPAGE="http://www.hping.org"
SRC_URI="http://www.hping.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="tcl"

S="${WORKDIR}/${MY_P}"

DEPEND="net-libs/libpcap
	tcl? ( dev-lang/tcl )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}.patch \
		"${FILESDIR}"/bytesex.h.patch \
		"${FILESDIR}"/${P}-tcl.patch \
		"${FILESDIR}"/${P}-ldflags.patch

	# Correct hard coded values
	sed -i Makefile.in \
		-e "9s:gcc:$(tc-getCC):" \
		-e "10s:/usr/bin/ar:$(tc-getAR):" \
		-e "11s:/usr/bin/ranlib:$(tc-getRANLIB):" \
		-e "s:/usr/local/lib:/usr/$(get_libdir):g" \
		-e "12s:-O2:${CFLAGS}:"
}

src_compile() {
	myconf=""
	use tcl || myconf="--no-tcl"

	# Not an autotools type configure:
	sh configure ${myconf} || die "configure failed"

	emake DEBUG="" || die "emake failed"
}

src_install () {
	dosbin hping3
	dosym /usr/sbin/hping3 /usr/sbin/hping
	dosym /usr/sbin/hping3 /usr/sbin/hping2

	doman docs/hping3.8

	dodoc INSTALL NEWS README TODO AUTHORS BUGS CHANGES
}
