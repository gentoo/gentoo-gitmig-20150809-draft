# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/ipsec-tools-0.5-r1.ebuild,v 1.2 2005/04/15 13:52:42 josejx Exp $

inherit eutils flag-o-matic

MY_P=${P/_/-}

DESCRIPTION="IPsec-Tools is a port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation."
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE="ipv6 selinux"
S=${WORKDIR}/${MY_P}
DEPEND="virtual/libc
	|| ( >=sys-kernel/linux-headers-2.6 sys-kernel/linux26-headers )
	>=dev-libs/openssl-0.9.6"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-ipsec-tools )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:#include <sys/sysctl.h>::' src/racoon/pfkey.c src/setkey/setkey.c
	epatch ${FILESDIR}/${P}-isakmp-underrun.diff || die "epatch failed!"
	epunt_cxx
}

src_compile() {
	# Filter the c3 flag for now. Probably a GCC problem, but we'll
	# avoid it here for now. See bug #61025
	filter-flags -march=c3

	econf	\
		--enable-hybrid \
		--enable-dpd \
		--enable-natt \
		--enable-adminport \
		--enable-frag \
		$(use_enable ipv6) \
		|| die
		# Removed due to some problems
		# --enable-samode-unspec \
	emake -j1 || die
}

src_install() {
	einstall || die
	keepdir /var/lib/racoon
	insinto /etc/conf.d && newins ${FILESDIR}/racoon.conf.d racoon
	exeinto /etc/init.d && newexe ${FILESDIR}/racoon.init.d racoon

	dodoc ChangeLog README NEWS
	dodoc ${S}/src/racoon/samples/racoon.conf.sample*
}
