# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/jftpgw/jftpgw-0.13.4-r1.ebuild,v 1.8 2005/08/23 13:09:29 flameeyes Exp $

inherit eutils

DESCRIPTION="A small FTP gateway"
HOMEPAGE="http://www.mcknight.de/jftpgw/"
SRC_URI="http://www.mcknight.de/jftpgw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="crypt tcpd"

DEPEND="virtual/libc
	tcpd? ( sys-apps/tcp-wrappers )"

src_compile() {
	econf \
		--sysconfdir=/etc/jftpgw \
		--with-logpath=/var/log \
		`use_enable crypt` \
		`use_enable tcpd libwrap` \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING README TODO

	dosed "s:nobody:${PN}:" /etc/jftpgw/jftpgw.conf
	dosed "s:nobody:${PN}:" /etc/jftpgw/jftpgw.conf.sample

	exeinto /etc/init.d ; newexe ${FILESDIR}/jftpgw.rc jftpgw

	if has_version sys-apps/xinetd ; then
		insinto /etc/xinetd.d
		newins support/jftpgw.xinetd jftpgw
		dosed "s:nobody:${PN}:" /etc/xinetd.d/jftpgw
	fi

	enewuser ${PN} -1 -1 /dev/null nobody
}
