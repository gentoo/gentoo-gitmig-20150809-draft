# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/atftp/atftp-0.7.ebuild,v 1.3 2004/03/27 03:13:39 vapier Exp $

DESCRIPTION="Advanced TFTP implementation client/server"
HOMEPAGE="ftp://ftp.mamalinux.com/pub/atftp/"
SRC_URI="ftp://ftp.mamalinux.com/pub/atftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

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
	einstall || die "Installation failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/atftp.init atftp
	insinto /etc/conf.d
	newins ${FILESDIR}/atftp.confd atftp
}
