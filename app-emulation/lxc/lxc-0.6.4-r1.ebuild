# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lxc/lxc-0.6.4-r1.ebuild,v 1.1 2009/12/07 11:39:11 flameeyes Exp $

EAPI="2"

inherit eutils linux-info versionator base

DESCRIPTION="LinuX Containers userspace utilities"
HOMEPAGE="http://lxc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="+doc examples"

RDEPEND="sys-libs/libcap"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml-utils )
	>=sys-kernel/linux-headers-2.6.29"

CONFIG_CHECK="~CGROUPS
	~CGROUP_NS ~CPUSETS ~CGROUP_CPUACCT
	~RESOURCE_COUNTERS ~CGROUP_MEM_RES_CTLR
	~CGROUP_SCHED

	~NAMESPACES
	~IPC_NS ~USER_NS ~PID_NS

	~SECURITY_FILE_CAPABILITIES
	~DEVPTS_MULTIPLE_INSTANCES
	~CGROUP_FREEZER
	~UTS_NS ~NET_NS
	~VETH ~MACVLAN"

ERROR_DEVPTS_MULTIPLE_INSTANCES="CONFIG_DEVPTS_MULTIPLE_INSTANCES:	needed for pts inside container"

ERROR_CGROUP_FREEZER="CONFIG_CGROUP_FREEZER:	needed to freeze containers"

ERROR_UTS_NS="CONFIG_UTS_NS:	needed to unshare hostnames and uname info"
ERROR_NET_NS="CONFIG_NET_NS:	needed for unshared network"

ERROR_VETH="CONFIG_VETH:	needed for internal (inter-container) networking"
ERROR_MACVLAN="CONFIG_MACVLAN:	needed for internal (inter-container) networking"

PATCHES=(
	"${FILESDIR}"/${P}-lxc.network.pair.patch
	"${FILESDIR}"/${P}-move-rcfile.patch
	"${FILESDIR}"/${P}-fix-full-system.patch
)

src_configure() {
	econf \
		--localstatedir=/var \
		--bindir=/usr/sbin \
		--docdir=/usr/share/doc/${PF} \
		--with-config-path=/etc/lxc	\
		$(use_enable doc) \
		$(use_enable examples) \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS CONTRIBUTING MAINTAINERS \
		NEWS TODO README doc/FAQ.txt || die "dodoc failed"

	rm -r "${D}"/etc/lxc "${D}"/usr/sbin/lxc-{setcap,ls}

	keepdir /etc/lxc

	find "${D}" -name '*.la' -delete
}
