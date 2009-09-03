# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/tuxfrw/tuxfrw-2.61.ebuild,v 1.5 2009/09/03 12:07:25 ikelos Exp $

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
	#check for kernel version (2.4.23 or higher)
	get_version

	if [ ${KV_MINOR} -eq 4 ] && [ ${KV_PATCH} -lt 23 ] ; then
		eerror "${P} requires a 2.4 kernel version of at least 2.4.23."
		eerror "You must upgrade your kernel."
		die "Kernel version not supported"
	fi

	elog "Now checking your kernel configuration. If, for some reason, it"
	elog "fails, you can get a list of modules needed here:"
	elog "http://dev.gentoo.org/~angusyoung/docs/devel/tuxfrw/mod.txt"
	CONFIG_CHECK="~NETFILTER ~IP_NF_CONNTRACK ~IP_NF_FTP ~IP_NF_TARGET_REDIRECT"
	CONFIG_CHECK="${CONFIG_CHECK} ~IP_NF_IPTABLES ~IP_NF_MATCH_TOS ~IP_NF_FILTER"
	CONFIG_CHECK="${CONFIG_CHECK} ~IP_NF_TARGET_REJECT ~IP_NF_TARGET_REJECT"
	CONFIG_CHECK="${CONFIG_CHECK} ~IP_NF_TARGET_LOG ~IP_NF_NAT ~IP_NF_MANGLE"
	CONFIG_CHECK="${CONFIG_CHECK} ~IP_NF_TARGET_MASQUERADE ~IP_NF_NAT_FTP"
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
	doins tuxfrw.conf

	exeopts -m700
	exeinto /etc/init.d/
	doexe ${FILESDIR}/tuxfrw

	dosbin ${S}/tuxfrw

	dodoc ${S}/AUTHORS ${S}/COPYING ${S}/CREDITS ${S}/ChangeLog ${S}/INSTALL
	dodoc ${S}/README ${S}/VERSION ${S}/manual/${PN}-manual-${MANUAL_PV}-en.txt
}

pkg_postinst() {
	elog "Configure /etc/tuxfrw/tuxfrw.conf manually"
	elog "To start: /etc/init.d/tuxfrw start "
	elog "To load on boot: rc-update add tuxfrw default"
}
