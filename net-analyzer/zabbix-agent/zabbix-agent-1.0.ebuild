# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-agent/zabbix-agent-1.0.ebuild,v 1.4 2007/07/11 23:49:24 mr_bones_ Exp $

inherit eutils

MY_P=${PN//-agent/}
DESCRIPTION="ZABBIX is software for monitoring of your applications, network and servers. Agent part."

HOMEPAGE="http://zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND=""

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:"
RDEPEND=""

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
S=${WORKDIR}/${MY_P}-${PV}

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
	doconfd ${FILESDIR}/${PV}/conf.d/zabbix-agentd
	doinitd ${FILESDIR}/${PV}/init.d/zabbix-agentd
	dosbin bin/zabbix_agent bin/zabbix_agentd bin/zabbix_sender
	fowners zabbix:zabbix /etc/zabbix /var/log/zabbix /var/run/zabbix /etc/zabbix/zabbix_agent.conf /etc/zabbix/zabbix_agentd.conf
	fperms 0640 /etc/zabbix/zabbix_agent.conf /etc/zabbix/zabbix_agentd.conf
	fperms 0750 /var/log/zabbix /var/run/zabbix
}
