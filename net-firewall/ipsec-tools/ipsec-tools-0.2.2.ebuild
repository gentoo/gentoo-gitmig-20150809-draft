# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/ipsec-tools-0.2.2.ebuild,v 1.2 2004/01/03 13:44:31 plasmaroo Exp $

DESCRIPTION="IPsec-Tools is a port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation."
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
DEPEND="virtual/glibc
	>=dev-libs/openssl-0.9.6"

pkg_setup() {
	my_KV=`echo ${KV} | cut -f-2 -d "."`
	if [ ${my_KV} != "2.6" ] ; then
		echo; eerror "You need a 2.6.x kernel to use the ipsec tools!"; die "You need a 2.6 kernel to use ipsec-tools!"
	fi
}

src_compile() {
	unset CC
	./configure --prefix=/usr --sysconfdir=/etc || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog README NEWS
	insinto /etc && doins ${FILESDIR}/ipsec.conf.sample
	insinto /etc/conf.d && newins ${FILESDIR}/racoon.conf.d racoon
	exeinto /etc/init.d && newexe ${FILESDIR}/racoon.init.d racoon
}
