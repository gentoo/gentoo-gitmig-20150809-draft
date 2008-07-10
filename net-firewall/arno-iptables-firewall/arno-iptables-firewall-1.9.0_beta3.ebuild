# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arno-iptables-firewall/arno-iptables-firewall-1.9.0_beta3.ebuild,v 1.1 2008/07/10 20:09:50 wolf31o2 Exp $

EAPI=1
MY_PV=${PV/_beta/-beta}

DESCRIPTION="Arno's iptables firewall script"
HOMEPAGE="http://rocky.molphys.leidenuniv.nl/"
SRC_URI="http://rocky.eld.leidenuniv.nl/iptables-firewall/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+plugins"

RDEPEND=">=net-firewall/iptables-1.2.5"

S=${WORKDIR}/${PN}_${MY_PV}

src_install() {
	insinto /etc/arno-iptables-firewall
	doins etc/arno-iptables-firewall/*

	sed -e 's:local/::' \
		contrib/Gentoo/firewall.conf > \
		"${T}"/arno-iptables-firewall.confd
	newconfd "${T}"/arno-iptables-firewall.confd arno-iptables-firewall
	newinitd contrib/Gentoo/rc.firewall arno-iptables-firewall

	dobin bin/arno-fwfilter
	dosbin bin/arno-iptables-firewall

	if use plugins
	then
		insinto /etc/arno-iptables-firewall/plugins
		doins etc/arno-iptables-firewall/plugins/*

		insinto /usr/share/arno-iptables-firewall/plugins
		doins usr/share/arno-iptables-firewall/plugins/*.plugin

		docinto plugins
		dodoc usr/share/arno-iptables-firewall/plugins/*.CHANGELOG
	fi

	dodoc CHANGELOG README

	doman man/arno-fwfilter.1 man/arno-iptables-firewall.8
}

pkg_postinst () {
	elog "You will need to configure /etc/${PN}/firewall.conf before using this"
	elog "package.  To start the script, run:"
	elog "  /etc/init.d/${PN} start"
	echo
	elog "If you want to start this script at boot, run:"
	elog "  rc-update add ${PN} default"
	echo
	ewarn "When you stop this script, all firewall rules are flushed!"
	echo
}
