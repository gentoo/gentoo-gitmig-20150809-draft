# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/tuxfrw/tuxfrw-2.62.ebuild,v 1.1 2007/05/12 14:45:44 cedk Exp $

inherit eutils linux-info

# The version of the manual.
MANUAL_PV="2.60"

DESCRIPTION="TuxFrw is a complete firewall automation tool for GNU/Linux."
HOMEPAGE="http://tuxfrw.sf.net/"
SRC_URI="mirror://sourceforge/tuxfrw/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND="net-firewall/iptables"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 4 23 ; then
		eerror "${P} requires a 2.4 kernel version of at least 2.4.23."
		eerror "You must upgrade your kernel."
		die "Kernel version not supported"
	fi

	CONFIG_CHECK="NETFILTER IP_NF_TARGET_REDIRECT"
	CONFIG_CHECK="${CONFIG_CHECK} IP_NF_IPTABLES IP_NF_MATCH_TOS IP_NF_FILTER"
	CONFIG_CHECK="${CONFIG_CHECK} IP_NF_TARGET_REJECT IP_NF_TARGET_REJECT"
	CONFIG_CHECK="${CONFIG_CHECK} IP_NF_TARGET_LOG IP_NF_MANGLE"
	CONFIG_CHECK="${CONFIG_CHECK} IP_NF_TARGET_MASQUERADE"

	if kernel_is lt 2 6 20; then
		CONFIG_CHECK="${CONFIG_CHECK} IP_NF_CONNTRACK IP_NF_FTP IP_NF_NAT IP_NF_NAT_FTP"
	else
		CONFIG_CHECK="${CONFIG_CHECK} NF_CONNTRACK NF_CONNTRACK_FTP NF_NAT NF_NAT_FTP"
	fi
	check_extra_config
}

src_install() {
	diropts -m0700
	dodir /etc/tuxfrw
	dodir /etc/tuxfrw/rules

	insinto /etc/tuxfrw/
	insopts -m0600
	CONF_MOD="tf_PIGMEAT.mod tf_KERNEL.mod tf_BASE.mod tuxfrw.conf"
	for conf_mod in ${CONF_MOD}; do
		doins ${conf_mod}
	done


	insinto /etc/tuxfrw/rules
	insopts -m0600
	CONF_RULES="tf_*-*.mod tf_INPUT.mod tf_OUTPUT.mod tf_FORWARD.mod"
	CONF_RULES="${CONF_RULES} tf_MANGLE.mod"
	for conf_rule in ${CONF_RULES} ; do
		doins ${conf_rule}
	done

	doinitd "${FILESDIR}"/tuxfrw

	dosbin tuxfrw

	dodoc AUTHORS CREDITS ChangeLog README VERSION
	dodoc manual/${PN}-manual-${MANUAL_PV}-en.txt
}

pkg_postinst() {
	elog "Configure /etc/tuxfrw/tuxfrw.conf manually"
	elog "To start: /etc/init.d/tuxfrw start "
	elog "To load on boot: rc-update add tuxfrw default"
}
