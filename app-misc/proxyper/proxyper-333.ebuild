# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/proxyper/proxyper-333.ebuild,v 1.1 2003/04/29 21:27:51 mholzer Exp $


# This is my very first ebuild. I hope it will be easy since there's no
# compiling and stuff... ...let's see :-)


DESCRIPTION="distributed.net personal proxy"
HOMEPAGE="http://www.distributed.net"
SRC_URI="http://http.distributed.net/pub/dcti/${PN}/${PN}${PV}-linux-x86.tar.gz"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc ~alpha"
IUSE=""
DEPEND=""
RDEPEND="net-misc/host"
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
	exeinto /opt/proxyper ; doexe proxyper
	insinto /opt/proxyper ; doins proxyper.ini

	dodoc ChangeLog.txt
	dohtml manual.html

	exeinto /etc/init.d ; newexe ${FILESDIR}/proxyper.init proxyper
}

pkg_postinst() {
	einfo "Don't forget to modify the config file"
	einfo "located in /opt/proxyper/proxyper.ini"
	einfo "I recommend reading the manual first :-)"
}

pkg_postrm() {
	if [ -d /opt/proxyper ]; then
		einfo "All files has not been removed from /opt/proxyper"
	fi
}
