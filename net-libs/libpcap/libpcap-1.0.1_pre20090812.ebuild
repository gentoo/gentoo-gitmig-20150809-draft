# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-1.0.1_pre20090812.ebuild,v 1.2 2009/11/24 23:09:26 vapier Exp $

EAPI=2
inherit autotools eutils multilib toolchain-funcs

DESCRIPTION="A system-independent library for user-level network packet capture"
HOMEPAGE="http://www.tcpdump.org/"
MY_P=${PN}-${PV/_pre/-}
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}
#	SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
#		http://www.jp.tcpdump.org/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="bluetooth ipv6 libnl"

RDEPEND="!virtual/libpcap
	bluetooth? ( || ( net-wireless/bluez net-wireless/bluez-libs ) )
	libnl? ( dev-libs/libnl )"
DEPEND="${RDEPEND}
	sys-devel/flex"
PROVIDE="virtual/libpcap"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.0.0-cross-linux.patch"
	epatch "${FILESDIR}/${PN}-1.0.1_pre20090812-poll-cpu-usage.patch"
	epatch "${FILESDIR}"/${PN}-1.0.1-autoconf.patch #281690
	echo ${PV} > VERSION # Avoid CVS in version
	eautoreconf
}

src_configure() {
	econf $(use_enable ipv6) \
		$(use_with libnl) \
		$(use_enable bluetooth)
}

src_compile() {
	emake all shared || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install install-shared || die "emake install failed"

	dosym libpcap.so.${PV} /usr/$(get_libdir)/libpcap.so.1
	dosym libpcap.so.${PV} /usr/$(get_libdir)/libpcap.so

	# We need this to build pppd on G/FBSD systems
	if [[ "${USERLAND}" == "BSD" ]]; then
		insinto /usr/include
		doins pcap-int.h || die "failed to install pcap-int.h"
	fi

	# We are not installing README.{Win32,aix,hpux,tru64} (bug 183057)
	dodoc CREDITS CHANGES VERSION TODO README{,.dag,.linux,.macosx,.septel} || die
}
