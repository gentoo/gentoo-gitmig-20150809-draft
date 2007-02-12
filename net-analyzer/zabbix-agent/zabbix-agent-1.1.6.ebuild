# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-agent/zabbix-agent-1.1.6.ebuild,v 1.1 2007/02/12 00:14:43 wschlich Exp $

inherit eutils

MY_P=${PN//-agent/}
MY_PV=${PV//_/}
DESCRIPTION="ZABBIX is software for monitoring of your applications, network and servers. Agent part."
HOMEPAGE="http://www.zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}-${MY_PV}

pkg_setup() {
	enewgroup zabbix
	enewuser zabbix -1 -1 /dev/null zabbix
}
pkg_postinst() {
	# repeat fowners/fperms functionality from src_install()
	# here to catch wrong permissions on existing files in
	# the live filesystem (yeah, that sucks).
	chown zabbix:zabbix \
		${ROOT}etc/zabbix \
		${ROOT}etc/zabbix/zabbix_agent.conf \
		${ROOT}etc/zabbix/zabbix_agentd.conf \
		${ROOT}var/log/zabbix \
		${ROOT}var/run/zabbix
	chmod 0750 \
		${ROOT}etc/zabbix \
		${ROOT}var/log/zabbix \
		${ROOT}var/run/zabbix
	chmod 0640 \
		${ROOT}etc/zabbix/zabbix_agent.conf \
		${ROOT}etc/zabbix/zabbix_agentd.conf
}

src_compile() {
	econf --enable-agent || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir \
		/etc/zabbix \
		/var/log/zabbix \
		/var/run/zabbix
	keepdir \
		/etc/zabbix \
		/var/log/zabbix \
		/var/run/zabbix
	insinto /etc/zabbix
	doins \
		${FILESDIR}/${PV}/zabbix_agent.conf \
		${FILESDIR}/${PV}/zabbix_agentd.conf
	doinitd ${FILESDIR}/${PV}/init.d/zabbix-agentd
	dosbin \
		src/zabbix_agent/zabbix_agent \
		src/zabbix_agent/zabbix_agentd
	dobin \
		src/zabbix_sender/zabbix_sender \
		src/zabbix_get/zabbix_get
	fowners zabbix:zabbix \
		/etc/zabbix \
		/etc/zabbix/zabbix_agent.conf \
		/etc/zabbix/zabbix_agentd.conf \
		/var/log/zabbix \
		/var/run/zabbix
	fperms 0750 \
		/etc/zabbix \
		/var/log/zabbix \
		/var/run/zabbix
	fperms 0640 \
		/etc/zabbix/zabbix_agent.conf \
		/etc/zabbix/zabbix_agentd.conf
}
