# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/glftpd-tls/glftpd-tls-1.30.ebuild,v 1.1 2003/06/16 19:01:34 vapier Exp $

DESCRIPTION="allows you to use SSLv3 encryption with glftpd connections"
HOMEPAGE="http://pftp.suxx.sk/glftpd-TLS/"
SRC_URI="http://pftp.suxx.sk/glftpd-TLS/glftpd-LNX_${PV}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 -*"
RESTRICT="nostrip"

DEPEND=""
RDEPEND="net-ftp/glftpd"

S=${WORKDIR}/glftpd-LNX_${PV}

src_install() {
	dodir /opt/glftpd
	mv ${S}/* ${D}/opt/glftpd/
	rm ${D}/opt/glftpd/glftpd.conf
}

pkg_postinst() {
	einfo "Now please read /opt/glftpd/docs/README.TLS"
	einfo "in order to setup TLS properly ..."
	echo
	einfo "1. cd /opt/glftpd/"
	einfo "2. ./create_server_key.sh COMMENT"
	einfo "3. chmod o-r ftpd-dsa.pem"
	einfo "4. mv ftpd-dsa.pem /etc/glftpd-dsa.pem"
	einfo "5. Edit /etc/xinetd.d/glftpd and add"
	einfo "   '-z cert=/etc/glftpd-dsa.pem' to server_args"
	einfo "6. /etc/init.d/xinetd restart"
	einfo "7. Edit /etc/glftpd.conf and setup TLS permissions"
}
