# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-0.6.10.ebuild,v 1.1 2003/06/08 12:50:37 liquidx Exp $

inherit flag-o-matic

IUSE="ssl ncurses"
MY_PV="0.6.a"
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Ettercap is a multipurpose sniffer/interceptor/logger for switched LAN."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://ettercap.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

RDEPEND="virtual/glibc
	ncurses? ( sys-libs/ncurses )
	ssl? ( dev-libs/openssl )"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-apps/portage-2.0.45-r3
	${RDEPEND}"



src_compile() {
	# NOTE: gtk support is still experimental code and has _NOT_ been included here

	econf \
		`use_enable ncurses` \
		`use_with ssl openssl` \
		`use_enable ssl https` \
		--enable-plugins \
		--disable-debug

	sed -i	"s:/usr/share/ettercap/:/etc/ettercap/:; \
		s:/usr/doc/${P}/:/usr/share/doc/${PF}/:" ettercap.8

	append-flags "-funroll-loops -fomit-frame-pointer -Wall"

	emake CFLAG="${CFLAGS}" || die "failed to compile"
	emake CFLAG="${CFLAGS}" plug-ins || die "failed to compile plugins"
}

src_install() {
	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		DATADIR=${D}/etc/ettercap \
		DOCDIR=${D}/usr/share/doc/${PF} \
		complete_install || die "make complete_install failed"

	rm ${D}/usr/share/doc/${PF}/{ettercap.fr.8.in,COPYING,INSTALL} \
	   ${D}/etc/ettercap/{AUTHORS,THANKS}
}

pkg_preinst() {
	prepalldocs
	dosym /etc/ettercap /usr/share/ettercap
}

pkg_postrm() {
	rm /usr/share/ettercap
}
