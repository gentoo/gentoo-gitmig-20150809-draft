# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap-ringbuffer/libpcap-ringbuffer-1.0.20050129.ebuild,v 1.1 2005/03/24 00:56:18 vanquirius Exp $

inherit toolchain-funcs linux-info multilib

MY_P=${PN:0:7}-${PV}

DESCRIPTION="A libpcap version which supports MMAP mode (ringbuffer)  on the linux kernel 2.[46].x"
HOMEPAGE="http://public.lanl.gov/cpw/"
SRC_URI="${HOMEPAGE}${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="ipv6"

DEPEND="virtual/libc
	!virtual/libpcap"

PROVIDE="virtual/libpcap"

S=${WORKDIR}/${MY_P}

# Used in linux-info to check minium Kernel support
CONFIG_CHECK="PACKET_MMAP"
PACKET_MMAP_ERROR="Make sure you have PACKET_MMAP compiled in your kernel to make use of libpcap's ringbuffer feature."

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:@CFLAGS@:@CFLAGS@ -fPIC:' Makefile.in || die "fPIC patch failed."
}

src_compile() {
	cd ${S}
	econf `use_enable ipv6` || die "bad configure"
	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	$(tc-getCC) -Wl,-soname,libpcap.so.0 -shared -fPIC -o libpcap.so.${PV:0:3} *.o \
		|| die "couldn't make a shared lib"
}

src_install() {
	dodir /usr/include
	dodir /usr/$(get_libdir)
	emake DESTDIR=${D} install || die "install problem"
	dodoc CREDITS CHANGES FILES README* VERSION

	dolib libpcap.so.${PV:0:3}

	doins /usr/$(get_libdir)

	for link in "" .0 .0.7 .0.8
	do
		dosym libpcap.so.${PV:0:3} libpcap.so${link}
	done
}

pkg_postinst() {
	einfo "For usage with tcpdump and further details see:"
	einfo "/usr/share/doc/${PF}/README.ring.gz"
}
