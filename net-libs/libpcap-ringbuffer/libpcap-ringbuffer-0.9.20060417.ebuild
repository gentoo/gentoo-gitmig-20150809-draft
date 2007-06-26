# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap-ringbuffer/libpcap-ringbuffer-0.9.20060417.ebuild,v 1.4 2007/06/26 02:26:28 mr_bones_ Exp $

inherit eutils toolchain-funcs linux-info multilib libtool autotools

MY_P=${PN:0:7}-${PV}

DESCRIPTION="A libpcap version which supports MMAP mode (ringbuffer) on the linux kernel 2.[46].x"
HOMEPAGE="http://public.lanl.gov/cpw/"
SRC_URI="http://public.lanl.gov/cpw/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ipv6"

DEPEND="!virtual/libpcap"

PROVIDE="virtual/libpcap"

S=${WORKDIR}/${MY_P}

# Used in linux-info to check minium Kernel support
CONFIG_CHECK="PACKET_MMAP"
PACKET_MMAP_ERROR="Make sure you have PACKET_MMAP compiled in your kernel to make use of libpcap's ringbuffer feature."

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
	eautoreconf
}

src_compile() {
	econf $(use_enable ipv6) --enable-shared --with-pcap=linux || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CREDITS CHANGES FILES README* VERSION

	dosym libpcap-0.9.3.so /usr/$(get_libdir)/libpcap.so.0.9
	dosym libpcap-0.9.3.so /usr/$(get_libdir)/libpcap.so.0

	#set PCAP_FRAMES=max
	echo "PCAP_FRAMES=32768" > "${T}/99libpcap-ringbuffer"
	doenvd "${T}/99libpcap-ringbuffer"
}

pkg_postinst() {
	echo
	elog "Use of the ringbuffer requires that the environment variable PCAP_FRAMES be set."
	elog "This has automaticaly been set to the maximal accepted value"
	elog "   PCAP_FRAMES=32768"
	elog
	elog "This will tie up at around 51 Mbytes of memory for the ring buffer alone"
	elog "when capturing packets with tools like tcpdump or snort."
	elog "You can change this environment variable by editing"
	elog "   /etc/env.d/99libpcap-ringbuffer"
	elog "and then run"
	elog "   env-update && source /etc/profile"
	elog
	elog "To continue to use libpcap-ringbuffer without the ringbuffer,  just set PCAP_FRAMES=0"
	elog "in the env.d file. Alternatively, you could run wireshark like this:"
	elog "   PCAP_FRAMES=0 wireshark"
	elog
	elog "For further details see:"
	elog "   /usr/share/doc/${PF}/README.ring.gz"
}
