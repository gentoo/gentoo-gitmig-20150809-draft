# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hyperic-hq-agent/hyperic-hq-agent-2.0.31.ebuild,v 1.2 2005/07/09 18:27:09 swegener Exp $

inherit eutils

DESCRIPTION="Agent for HQ Monitoring Software by Hyperic LLC"
HOMEPAGE="http://www.hyperic.com/"
SRC_URI="http://download.hyperic.net/downloads/ebuilds/hyperic-hq-agent-${PV}-x86-linux.tgz"

LICENSE="hyperic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

AGENT_HOME=/opt/hyperic-hq-agent-${PV}

src_install() {

	insinto /etc/init.d
	insopts -m0750
	newins ${FILESDIR}/hyperic-hq-agent.init-${PV} hyperic-hq-agent

	dodir ${AGENT_HOME}
	cp -a ${S}/* ${D}${AGENT_HOME}
}

pkg_preinst() {
	enewgroup hyperic
	enewuser hyperic -1 -1 /dev/null hyperic
}

pkg_postinst() {
	chown -R hyperic:hyperic ${AGENT_HOME}

	einfo "You should perform the following before attempting to start the agent:"
	einfo
	einfo "1) read and agree to the _commercial license_ at /usr/portage/licenses/hyperic"
	einfo "2) ensure that your server has a license key permitting an additional agent install."
	einfo "3) have your server ip, admin username, and admin password available"
	einfo "4) run /opt/hyperic-hq-agent-${PV}/hq-agent.sh start and answer setup questions"
	einfo "5) run /opt/hyperic-hq-agent-${PV}/hq-agent.sh stop"
	einfo "6) rc-update add hyperic-hq-agent default"
	einfo "7) /etc/init.d/hyperic-hq-agent start"
	einfo
}
