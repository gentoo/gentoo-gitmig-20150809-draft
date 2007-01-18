# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.14.ebuild,v 1.1 2007/01/18 09:40:03 phreak Exp $

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

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-ndsend.c.patch
}

src_compile() {
	econf --libdir=/usr/$(get_libdir) || die "econf failed!"
	emake CFLAGS="${CFLAGS}" || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install install-gentoo || die "make install failed"

	# Remove udev files unless USE=udev
	use udev || rm -rf "${D}"/etc/udev

	# Remove the bash-completion and use dobashcompletion to install it in the
	# right place!
	dobashcompletion "${S}"/etc/bash_completion.d/vzctl.sh.in vzctl

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
