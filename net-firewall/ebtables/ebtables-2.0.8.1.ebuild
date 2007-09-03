# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.8.1.ebuild,v 1.2 2007/09/03 18:18:30 dertobi123 Exp $

inherit versionator eutils toolchain-funcs multilib

MY_PV=$(replace_version_separator 3 '-' )
MY_P="${PN}-v${MY_PV}"

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://ebtables.sourceforge.net/"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Kill two rabits: TEXTREL and compilation on amd64. bug #159371.
	epatch "${FILESDIR}"/${P}-fix-textrel.patch

	# Fix scripts to be built during make, thus paths inside are correct.
	epatch "${FILESDIR}"/${P}-scripts-build.patch

	sed -i -e "s,MANDIR:=/usr/local/man,MANDIR:=/usr/share/man," \
		-e "s,BINDIR:=/usr/local/sbin,BINDIR:=/sbin," \
		-e "s,INITDIR:=/etc/rc.d/init.d,INITDIR:=/usr/share/doc/${PF}," \
		-e "s,SYSCONFIGDIR:=/etc/sysconfig,SYSCONFIGDIR:=/usr/share/doc/${PF}," \
		-e "s,LIBDIR:=/usr/lib,LIBDIR:=/$(get_libdir)/\$(PROGNAME)," Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dodoc ChangeLog THANKS
	make DESTDIR="${D}" install || die
}
