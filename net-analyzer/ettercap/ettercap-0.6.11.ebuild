# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-0.6.11.ebuild,v 1.4 2004/01/11 17:27:27 gmsoft Exp $

MY_PV=0.6.b
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="multipurpose sniffer/interceptor/logger for switched LAN"
HOMEPAGE="http://ettercap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha hppa"
IUSE="ssl ncurses"

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
		--datadir=/etc \
		--disable-debug \
		--disable-gtk \
		|| die

	sed -i	"s:/usr/share/ettercap/:/etc/ettercap/:; \
		s:/usr/doc/${P}/:/usr/share/doc/${PF}/:" ettercap.8

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

pkg_postinst() {
	einfo "To use ARP Poisioning, you must generate your own SSL certificate"
	einfo "by running:"
	einfo ""
	einfo " ettercap -w"
	einfo ""
	einfo "and then follow the instructions."
}
