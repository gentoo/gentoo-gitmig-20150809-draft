# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hyperic-hq-agent/hyperic-hq-agent-2.5.15.ebuild,v 1.2 2006/04/16 08:22:37 mattm Exp $

inherit eutils

DESCRIPTION="Agent for HQ Monitoring Software by Hyperic LLC"
HOMEPAGE="http://www.hyperic.com/"
SRC_URI="x86? (
http://dl.hyperic.net/2.5/hyperic-hq-agent-${PV}-x86-linux.tgz ) amd64? (
http://dl.hyperic.net/2.5/hyperic-hq-agent-${PV}-amd64-linux.tgz )"

LICENSE="hyperic"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

AGENT_HOME=/opt/hyperic-hq-agent-${PV}

src_install() {

	insinto /etc/init.d
	insopts -m0750
	newins ${FILESDIR}/hyperic-hq-agent.init-${PV} hyperic-hq-agent

	dodir ${AGENT_HOME}
	cp -pPR ${S}/* ${D}${AGENT_HOME}
}

pkg_preinst() {
	enewgroup hyperic
	enewuser hyperic -1 /bin/bash ${AGENT_HOME} hyperic
}

pkg_postinst() {
	chown -R hyperic:hyperic ${AGENT_HOME}

	einfo "You should perform the following before attempting to start the agent:"
	einfo
	einfo "1) read and agree to the _commercial license_ at /usr/portage/licenses/hyperic"
	einfo "2) ensure that your server has a license key permitting an additional agent install."
	einfo "3) have your server ip, admin username, and admin password available"
	einfo "4) rc-update add hyperic-hq-agent default"
	einfo "5) /etc/init.d/hyperic-hq-agent start"
	einfo
}
