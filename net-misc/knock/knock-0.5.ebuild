# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knock/knock-0.5.ebuild,v 1.6 2006/08/29 04:28:12 metalgod Exp $

inherit eutils

MY_PV="${PV/%.0}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/knock/"
SRC_URI="http://www.zeroflux.org/knock/files/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND="net-libs/libpcap
	>=sys-apps/portage-2.0.51"
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
