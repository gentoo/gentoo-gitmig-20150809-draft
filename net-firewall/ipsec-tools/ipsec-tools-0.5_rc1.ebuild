# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/ipsec-tools-0.5_rc1.ebuild,v 1.2 2005/01/11 23:48:30 johnm Exp $

inherit eutils

MY_P=${P/_/-}

DESCRIPTION="IPsec-Tools is a port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation."
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
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
	epunt_cxx
}

src_compile() {
	econf	\
		--enable-hybrid \
		--enable-dpd \
		--enable-natt \
		--enable-adminport \
		--enable-samode-unspec \
		--enable-frag \
		$(use_enable ipv6) \
		|| die
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
