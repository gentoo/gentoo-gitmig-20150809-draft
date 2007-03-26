# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knock/knock-0.5.ebuild,v 1.9 2007/03/26 08:06:37 antarus Exp $

inherit eutils

MY_PV="${PV/%.0}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/knock/"
SRC_URI="http://www.zeroflux.org/knock/files/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="net-firewall/iptables
	${DEPEND}"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
	dodoc ChangeLog
	dodoc TODO

	dosed "s:/usr/sbin/iptables:/sbin/iptables:g" /etc/knockd.conf

	newinitd ${FILESDIR}/knockd.initd knock
	newconfd ${FILESDIR}/knockd.confd knock
}
