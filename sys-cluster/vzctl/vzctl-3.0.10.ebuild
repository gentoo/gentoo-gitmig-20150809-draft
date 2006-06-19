# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.10.ebuild,v 1.1 2006/06/19 20:29:50 phreak Exp $

inherit eutils

DESCRIPTION="OpenVZ VPS control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Install gentoo specific init script
	newinitd "${FILESDIR}"/vz.initd vz
}
