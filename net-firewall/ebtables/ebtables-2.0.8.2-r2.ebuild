# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.8.2-r2.ebuild,v 1.3 2009/01/04 15:38:26 maekke Exp $

inherit versionator eutils toolchain-funcs multilib flag-o-matic

MY_PV=$(replace_version_separator 3 '-' )
MY_P="${PN}-v${MY_PV}"

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://ebtables.sourceforge.net/"
KEYWORDS="amd64 ppc x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Enchance ebtables-save to take table names as parameters bug #189315
	epatch "${FILESDIR}"/${PN}-2.0.8.1-ebt-save.diff
	epatch "${FILESDIR}"/${PN}-v2.0.8-2-LDFLAGS.diff
	epatch "${FILESDIR}"/${PN}-v2.0.8-2-ethertype-DESTDIR-mkdir.patch

	sed -i -e "s,^MANDIR:=.*,MANDIR:=/usr/share/man," \
		-e "s,^BINDIR:=.*,BINDIR:=/sbin," \
		-e "s,^INITDIR:=.*,INITDIR:=/usr/share/doc/${PF}," \
		-e "s,^SYSCONFIGDIR:=.*,SYSCONFIGDIR:=/usr/share/doc/${PF}," \
		-e "s,^LIBDIR:=.*,LIBDIR:=/$(get_libdir)/\$(PROGNAME)," Makefile
	sed -i -e "s/^CFLAGS:=/CFLAGS+=/" Makefile
	sed -i -e "s,^CC:=.*,CC:=$(tc-getCC)," Makefile
}

src_compile() {
	# This package uses _init functions to initialise extensions. With
	# --as-needed this will not work.
	append-ldflags -Wl,--no-as-needed
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog THANKS
	keepdir /var/lib/ebtables/
	newinitd "${FILESDIR}"/ebtables.initd ebtables
	newconfd "${FILESDIR}"/ebtables.confd ebtables
}
