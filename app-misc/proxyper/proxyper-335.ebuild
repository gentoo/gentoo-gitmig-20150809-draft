# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/proxyper/proxyper-335.ebuild,v 1.1 2004/01/03 13:38:56 mholzer Exp $

DESCRIPTION="distributed.net personal proxy"
HOMEPAGE="http://www.distributed.net"
SRC_URI="x86? ( http://http.distributed.net/pub/dcti/${PN}/${PN}${PV}-linux-x86.tar.gz )"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE=""
DEPEND=""
RDEPEND="net-misc/host"

# added a DESTDIR variable to make things cleaner
DESTDIR="/opt/proxyper"

if [ `use x86` ]; then
	S="${WORKDIR}/${PN}${PV}-linux-x86"
elif [ `use ppc` ]; then
	S="${WORKDIR}/${PN}${PV}-linux-ppc"
elif [ `use sparc` ]; then
	S="${WORKDIR}/${PN}${PV}-linux-sparc"
elif [ `use alpha` ]; then
	S="${WORKDIR}/${PN}${PV}-linux-alpha"
fi

RESTRICT="nomirror"

src_install() {
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
	if [ -d ${DESTDIR} ]; then
		einfo "All files have not been removed from /opt/proxyper"
	fi
}
