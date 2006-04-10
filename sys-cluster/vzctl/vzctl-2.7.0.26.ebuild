# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-2.7.0.26.ebuild,v 1.3 2006/04/10 12:01:23 phreak Exp $

inherit eutils toolchain-funcs versionator linux-info

VVER="$(get_version_component_range 1-3 ${PV})"
VREL="$(get_version_component_range 4 ${PV})"
MY_PV="${VVER}-${VREL}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="OpenVZ VPS control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${MY_PV}/src/${MY_P}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${P}-patches-${PR}.tar.bz2
	http://dev.gentoo.org/~hollow/distfiles/${P}-patches-${PR}.tar.bz2"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-admin/logrotate
	app-shells/bash
	sys-apps/sed
	sys-apps/ed
	sys-apps/grep
	sys-apps/gawk
	sys-apps/coreutils
	net-firewall/iptables
	app-arch/tar
	sys-fs/vzquota
	sys-process/procps
	sys-apps/iproute2"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="FAIRSCHED VE VE_CALLS VE_NETDEV VE_IPTABLES"

pkg_setup() {
	linux-info_pkg_setup
	check_kernel_built
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/patches/vzctl-2.7.0-gentoo_conf_d.patch
	epatch "${WORKDIR}"/patches/vzctl-2.7.0.23-gentoo_etc_vz.patch

	# fix hardcoded lib paths
	use amd64 && epatch "${WORKDIR}"/patches/vzctl-2.7.0.26-amd64.patch
}

src_compile() {
	emake VZKERNEL_HEADERS=${KV_DIR}/include || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" VZCONFDIR=/etc/conf.d/ install || die "make install failed"

	# sysconfig is vendor specific
	rm -rf ${D}/etc/sysconfig

	# Install gentoo specific init script
	rm -f ${D}/etc/init.d/*
	newinitd ${FILESDIR}/vz.initd vz

	# Fix permissions on cron.d files
	chmod 0644 ${D}/etc/cron.d/*
}
