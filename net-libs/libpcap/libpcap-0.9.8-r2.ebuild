# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.9.8-r2.ebuild,v 1.9 2011/04/02 12:57:21 ssuominen Exp $

inherit autotools eutils multilib toolchain-funcs

DESCRIPTION="A system-independent library for user-level network packet capture"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="ipv6"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.9.3-whitespace.diff
	epatch "${FILESDIR}"/${PN}-0.8.1-fPIC.patch
	epatch "${FILESDIR}"/${PN}-cross-linux.patch
	epatch "${FILESDIR}"/${P}-largefile.patch
	epatch "${FILESDIR}"/${P}-arptype-65534.patch
	epatch "${FILESDIR}"/${P}-pcap_compile.patch
	eautoreconf
}

src_compile() {
	econf $(use_enable ipv6)
	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	$(tc-getCC) ${LDFLAGS} -Wl,-soname,libpcap.so.0 -shared -fPIC -o libpcap.so.${PV:0:3} *.o \
		|| die "couldn't make a shared lib"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# We need this to build pppd on G/FBSD systems
	if [[ "${USERLAND}" == "BSD" ]]; then
		insinto /usr/include
		doins pcap-int.h || die "failed to install pcap-int.h"
	fi

	insopts -m 755
	insinto /usr/$(get_libdir)
	doins libpcap.so.${PV:0:3}
	dosym libpcap.so.${PV:0:3} /usr/$(get_libdir)/libpcap.so.0
	dosym libpcap.so.${PV:0:3} /usr/$(get_libdir)/libpcap.so

	# We are not installing README.{Win32,aix,hpux,tru64} (bug 183057)
	dodoc CREDITS CHANGES FILES VERSION TODO README{,.dag,.linux,.macosx,.septel}
}
