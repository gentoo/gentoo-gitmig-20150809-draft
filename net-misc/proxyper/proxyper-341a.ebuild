# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxyper/proxyper-341a.ebuild,v 1.1 2004/06/07 08:09:41 dragonheart Exp $

DESCRIPTION="distributed.net personal proxy"
HOMEPAGE="http://www.distributed.net"
SRC_URI="http://http.distributed.net/pub/dcti/${PN}/${PN}${PV}-linux-x86-uclibc.tar.gz"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE=""
DEPEND=""
RDEPEND="net-misc/host"

S="${WORKDIR}/${PN}${PV}-linux-x86-uclibc"

RESTRICT="nomirror"

src_install() {
	local DESTDIR="/opt/proxyper"
	exeinto ${DESTDIR} ; doexe proxyper

	# don't clobber an already existing ini file!
	insinto ${DESTDIR}
	if [ ! -f ${DESTDIR}/proxyper.ini ]
	then
		doins proxyper.ini
	else
		newins ${DESTDIR}/proxyper.ini proxyper.ini
	fi

	dodoc ChangeLog.txt
	dohtml manual.html

	exeinto /etc/init.d ; newexe ${FILESDIR}/proxyper.init proxyper
}

pkg_postinst() {
	einfo "Don't forget to modify the config file"
	einfo "located in /opt/proxyper/proxyper.ini"
	einfo "It's recommend to reading the manual first :-)"
}

pkg_postrm() {
	local DESTDIR="/opt/proxyper"
	if [ -d ${DESTDIR} ]; then
		einfo "All files have not been removed from ${DESTDIR}"
	fi
}
