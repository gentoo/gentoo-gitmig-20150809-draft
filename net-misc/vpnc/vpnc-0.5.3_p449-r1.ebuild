# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.5.3_p449-r1.ebuild,v 1.2 2010/08/13 08:39:49 fauli Exp $

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="http://www.unix-ag.uni-kl.de/~massar/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="resolvconf"

DEPEND=">=dev-libs/libgcrypt-1.1.91
	>=sys-apps/iproute2-2.6.19.20061214
	net-libs/gnutls"

RDEPEND="${DEPEND}
	resolvconf? ( net-dns/openresolv )"

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die
	dodoc README TODO VERSION || die
	keepdir /etc/vpnc/scripts.d
	newinitd "${FILESDIR}/vpnc-3.init" vpnc || die
	newconfd "${FILESDIR}/vpnc.confd" vpnc || die
	sed -e "s:/usr/local:/usr:" -i "${D}"/etc/vpnc/vpnc-script || die
	# COPYING file resides here, should not be installed
	rm -rf "${D}"/usr/share/doc/vpnc/
}

pkg_postinst() {
	elog "You can generate a configuration file from the original Cisco profiles of your"
	elog "connection by using /usr/bin/pcf2vpnc to convert the .pcf file"
	elog "A guide is to be found in http://www.gentoo.org/doc/en/vpnc-howto.xml"
	echo
	elog "Don't forget to turn on TUN support in the kernel."
}
