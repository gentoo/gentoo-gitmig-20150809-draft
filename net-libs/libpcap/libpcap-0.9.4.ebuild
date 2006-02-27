# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.9.4.ebuild,v 1.6 2006/02/27 15:09:22 corsair Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="A system-independent library for user-level network packet capture"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 mips ~ppc ppc64 ~s390 ~sh sparc x86"
IUSE="ipv6"

DEPEND="virtual/libc
	!virtual/libpcap"

PROVIDE="virtual/libpcap"

src_unpack() {
	unpack ${A}; cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.9.3-whitespace.diff
	epatch "${FILESDIR}"/${PN}-0.8.1-fPIC.patch
}

src_compile() {
	econf $(use_enable ipv6) || die "bad configure"
	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	$(tc-getCC) -Wl,-soname,libpcap.so.0 -shared -fPIC -o libpcap.so.${PV:0:3} *.o \
		|| die "couldn't make a shared lib"
}

src_install() {
	einstall || die "make install failed"

	# We need this to build pppd on G/FBSD systems
	if [[ "${USERLAND}" == "BSD" ]]; then
		insinto /usr/include
		doins pcap-int.h || die "failed to install pcap-int.h"
	fi

	insopts -m 755
	insinto /usr/$(get_libdir) ; doins libpcap.so.${PV:0:3}
	dosym libpcap.so.${PV:0:3} /usr/$(get_libdir)/libpcap.so.0
	dosym libpcap.so.${PV:0:3} /usr/$(get_libdir)/libpcap.so

	dodoc CREDITS CHANGES FILES README* VERSION
}
