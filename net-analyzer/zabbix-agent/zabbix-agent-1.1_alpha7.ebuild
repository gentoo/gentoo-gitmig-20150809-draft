# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-agent/zabbix-agent-1.1_alpha7.ebuild,v 1.3 2005/08/23 17:23:25 flameeyes Exp $

inherit eutils

MY_P=${PN//-agent/}
MY_PV=${PV//_/}
DESCRIPTION="ZABBIX is software for monitoring of your applications, network and servers. Agent part."

HOMEPAGE="http://zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND=""

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:"
RDEPEND=""

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
S=${WORKDIR}/${MY_P}-${MY_PV}

pkg_setup() {
	enewgroup zabbix
	enewuser zabbix -1 -1 /dev/null zabbix
}


src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /etc/zabbix /var/log/zabbix /var/run/zabbix
	keepdir /etc/zabbix /var/log/zabbix /var/run/zabbix
	insinto /etc/zabbix
	doins ${FILESDIR}/${PV}/zabbix_agent.conf ${FILESDIR}/${PV}/zabbix_agentd.conf
	insinto /etc/conf.d
	doins ${FILESDIR}/${PV}/conf.d/zabbix-agentd
	exeinto /etc/init.d
	doexe ${FILESDIR}/${PV}/init.d/zabbix-agentd
	dosbin bin/zabbix_agent bin/zabbix_agentd bin/zabbix_sender
	fowners zabbix:zabbix /etc/zabbix /var/log/zabbix /var/run/zabbix /etc/zabbix/zabbix_agent.conf /etc/zabbix/zabbix_agentd.conf
	fperms 0640 /etc/zabbix/zabbix_agent.conf /etc/zabbix/zabbix_agentd.conf
	fperms 0750 /var/log/zabbix /var/run/zabbix
}
