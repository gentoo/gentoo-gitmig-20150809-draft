# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.20.20070313.ebuild,v 1.4 2007/08/27 12:13:59 gustavoz Exp $

inherit eutils toolchain-funcs

MY_PV=${PV%.*}
SNAP=${PV##*.}
SNAP=${SNAP:2}
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://linux-net.osdl.org/index.php/Iproute2"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${PN}-${MY_PV}-${SNAP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86"
IUSE="atm berkdb minimal"

RDEPEND="!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21"

S=${WORKDIR}/iproute-${MY_PV}-${SNAP}

pkg_setup() {
	if use kernel_linux ; then
		ewarn
		ewarn "${PN} requires kernel support for Netlink (CONFIG_NETLINK)."
		ewarn "This is only applies for kernels prior to 2.4.17"
		ewarn
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"

	epatch "${FILESDIR}"/${PN}-2.6.16.20060323-build.patch #137574
	epatch "${FILESDIR}"/${PN}-2.6.16.20060323-routef-safe.patch #139853

	#68948 - esfq/wrr patches
	epatch "${FILESDIR}"/${PN}-051007-esfq-2.6.13.patch
	epatch "${FILESDIR}"/${PN}-2.6.11.20050330-wrr.patch

	# don't build arpd if USE=-berkdb #81660
	use berkdb || sed -i '/^TARGETS=/s: arpd : :' misc/Makefile
	# Multilib fixes
	sed -i 's:/usr/local:/usr:' tc/m_ipt.c include/iptables.h
	sed -i "s:/usr/lib:/usr/$(get_libdir):g" \
		netem/Makefile tc/{Makefile,tc.c,q_netem.c,m_ipt.c} include/iptables.h || die
	# Use correct iptables dir, #144265.
	sed -i "s:/usr/local/lib/iptables:/$(get_libdir)/iptables:g" \
		include/iptables.h
}

src_compile() {
	echo -n 'TC_CONFIG_ATM:=' > Config
	use atm \
		&& echo 'y' >> Config \
		|| echo 'n' >> Config

	use minimal && sed -i -e '/^SUBDIRS=/s:=.*:=lib tc:' Makefile
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		|| die "make"
}

src_install() {
	if use minimal ; then
		into /
		dosbin tc/tc || die "minimal"
		return 0
	fi

	emake \
		DESTDIR="${D}" \
		SBINDIR=/sbin \
		DOCDIR=/usr/share/doc/${PF} \
		install \
		|| die "make install failed"
	if use berkdb ; then
		dodir /var/lib/arpd
		# bug 47482, arpd doesn't need to be in /sbin
		dodir /usr/sbin
		mv "${D}"/sbin/arpd "${D}"/usr/sbin/
	fi
}
