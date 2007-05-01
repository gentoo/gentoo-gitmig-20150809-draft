# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hyperic-hq-agent/hyperic-hq-agent-2.6.22.ebuild,v 1.2 2007/05/01 17:48:59 genone Exp $

inherit eutils

DESCRIPTION="Agent for HQ Monitoring Software by Hyperic LLC"
HOMEPAGE="http://www.hyperic.com/"
SRC_URI="x86? (
http://dl.hyperic.net/2.6/hyperic-hq-agent-${PV}-x86-linux.tgz ) amd64? (
http://dl.hyperic.net/2.6/hyperic-hq-agent-${PV}-amd64-linux.tgz )"

LICENSE="hyperic"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

AGENT_HOME=/opt/hyperic-hq-agent-${PV}

src_install() {

	insinto /etc/init.d
	insopts -m0750
	newins ${FILESDIR}/hyperic-hq-agent.init-${PV} hyperic-hq-agent

	dodir ${AGENT_HOME}
	cp -pPR ${S}/* ${D}${AGENT_HOME}
}

pkg_postinst() {

	elog "You should perform the following before attempting to start the agent:"
	elog
	elog "1) read and agree to the _commercial license_ at /usr/portage/licenses/hyperic"
	elog "2) ensure that your server has a license key permitting an additional agent install."
	elog "3) have your server ip, admin username, and admin password available"
	elog "4) rc-update add hyperic-hq-agent default"
	elog "5) /etc/init.d/hyperic-hq-agent start"
	elog
}
