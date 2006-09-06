# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.11-r1.ebuild,v 1.3 2006/09/06 16:46:47 hollow Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="OpenVZ VPS control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${P}-patches-${PR}.tar.bz2
	http://dev.gentoo.org/~hollow/distfiles/${P}-patches-${PR}.tar.bz2"

# new SRC_URI for next releases
#SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2
#	http://dev.gentoo.org/~phreak/distfiles/${PN}-patches-${PVR}.tar.bz2
#	http://dev.gentoo.org/~hollow/distfiles/${PN}-patches-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev"

RDEPEND="app-admin/logrotate
	sys-apps/ed
	net-firewall/iptables
	sys-fs/vzquota
	sys-apps/iproute2
	udev? ( sys-fs/udev )"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}

	epatch "${WORKDIR}"/patches/*.patch
}

src_compile() {
	append-flags -Wall -g2
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)/vzctl" install || die "make install failed"

	# the get_libdir in `make install' breaks src/Makefile's logic (and thus all
	# contained tools), so we have to create a env.d entry for vzctl's LDPATH.
	dodir /etc/env.d
	echo "LDPATH=\"/usr/$(get_libdir)/vzctl\"" > "${D}"/etc/env.d/05vzctl

	# setup udev rules for /dev/vzctl
	if use udev; then
		dodir /etc/udev/rules.d
		echo 'KERNEL="vzctl", NAME="%k", MODE="0600"' > "${D}"/etc/udev/rules.d/60-vzctl.rules
	fi

	# Provide a symlink for vz.conf (fixing #138462)
	dosym /etc/vz/vz.conf /etc/conf.d/vz

	# Install gentoo specific init script
	rm -f "${D}"/etc/init.d/*
	newinitd "${WORKDIR}"/init.d/vz.initd vz

	dodoc "${WORKDIR}/patches/000_README"
}

pkg_postinst() {
	if has_version "<3.0.10"; then
		ewarn
		ewarn "The location of some vzctl files have changed. Most notably,"
		ewarn "VE configuration files and samples directory has changed from"
		ewarn "/etc/vz to /etc/vz/conf. In order to be able to work with"
		ewarn "your VEs, please do the following:"
		ewarn
		ewarn "bash# mv /etc/vz/[0-9]*.conf /etc/vz/conf/"
		ewarn
	fi
}
