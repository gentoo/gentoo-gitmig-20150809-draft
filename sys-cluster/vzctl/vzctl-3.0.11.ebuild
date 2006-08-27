# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.11.ebuild,v 1.1 2006/08/27 10:25:21 phreak Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="OpenVZ VPS control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${P}-patches.tar.bz2
	http://dev.gentoo.org/~hollow/distfiles/${P}-patches.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/logrotate
	sys-apps/ed
	net-firewall/iptables
	sys-fs/vzquota
	sys-apps/iproute2"

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

	# the get_libdir breaks stupid src/Makefile (all contained tools)
	# so we have to create a env.d entry for vzctl's LDPATH
	dodir /etc/env.d
	echo "LDPATH=\"/usr/$(get_libdir)/vzctl\"" > "${D}"/etc/env.d/05vzctl

	# Provide a symlink for vz.conf (part 1 of fixing #138462)
	dosym /etc/vz/vz.conf /etc/conf.d/vz

	# Install gentoo specific init script
	rm -f "${D}"/etc/init.d/*
	newinitd "${FILESDIR}"/vz-3.0.10.initd vz

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
