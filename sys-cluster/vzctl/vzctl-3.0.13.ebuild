# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.13.ebuild,v 1.2 2006/12/03 08:33:48 hollow Exp $

inherit bash-completion eutils flag-o-matic multilib

DESCRIPTION="OpenVZ VPS control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE="bash-completion logrotate udev"

RDEPEND="logrotate? ( app-admin/logrotate )
	net-firewall/iptables
	sys-apps/ed
	sys-apps/iproute2
	sys-fs/vzquota
	udev? ( sys-fs/udev )
	virtual/cron"

DEPEND="${RDEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)/vzctl" install install-gentoo || die "make install failed"

	# the get_libdir in `make install' breaks src/Makefile's logic (and thus all
	# contained tools), so we have to create a env.d entry for vzctl's LDPATH.
	dodir /etc/env.d
	echo "LDPATH=\"/usr/$(get_libdir)/vzctl\"" > "${D}"/etc/env.d/05vzctl

	# Remove udev files unless USE=udev
	use udev || rm -rf "${D}"/etc/udev

	# Remove the bash-completion and use dobashcompletion to install it in the
	# right place!
	rm -rf "${D}"/etc/bash_completion.d
	dobashcompletion "${S}"/etc/bash_completion.d/vzctl.sh vzctl

	# Remove the logrotate entry unless USE=logrotate
	use logrotate || rm -rf "${D}"/etc/logrotate.d
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
