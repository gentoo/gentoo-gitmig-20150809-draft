# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/atftp/atftp-0.7.ebuild,v 1.6 2004/07/19 20:21:16 vapier Exp $

DESCRIPTION="Advanced TFTP implementation client/server"
HOMEPAGE="ftp://ftp.mamalinux.com/pub/atftp/"
SRC_URI="ftp://ftp.mamalinux.com/pub/atftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc arm"
IUSE="tcpd"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	!virtual/tftp"
PROVIDE="virtual/tfp"

src_compile () {
	econf `use_enable tcpd libwrap` || die "./configure failed"

	sed -i \
		-e "/^CFLAGS =/s:-g::" \
		-e "/^CFLAGS =/s:-O2::" \
		-e "/^CFLAGS =/s:$: ${CFLAGS}:" \
		Makefile
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die "Installation failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/atftp.init atftp
	insinto /etc/conf.d
	newins ${FILESDIR}/atftp.confd atftp
}
