# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/ipsec-tools-0.6.5.ebuild,v 1.1 2006/04/20 03:47:35 latexer Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="IPsec-Tools is a port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation."
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE="idea ipv6 pam rc5 readline selinux"

AT_M4DIR="${S}"

DEPEND="virtual/libc
	!<sys-kernel/linux-headers-2.6
	readline? ( sys-libs/readline )
	pam? ( sys-libs/pam )
	>=dev-libs/openssl-0.9.6"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-ipsec-tools )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:#include <sys/sysctl.h>::' src/racoon/pfkey.c src/setkey/setkey.c
	sed -i 's:-Werror::g' ${S}/configure.ac
	eautoreconf
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
		$(use_enable idea) \
		$(use_enable rc5) \
		$(use_enable ipv6) \
		$(use_with readline) \
		$(use_with pam libpam) \
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
