# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.18.ebuild,v 1.1 2007/07/06 10:10:49 phreak Exp $

inherit bash-completion eutils

DESCRIPTION="OpenVZ VE control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="bash-completion logrotate"

RDEPEND="logrotate? ( app-admin/logrotate )
	net-firewall/iptables
	sys-apps/ed
	sys-apps/iproute2
	sys-fs/vzquota
	virtual/cron"

DEPEND="${RDEPEND}"

src_compile() {
	econf --localstatedir=/var \
		--enable-cron \
		--enable-udev \
		$(use_enable bash-completion bashcomp) \
		$(use_enable logrotate) || die "econf failed!"

	emake || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install install-gentoo || die "make install failed"

	# install the bash-completion script into the right location
	rm -rf "${D}"/etc/bash_completion.d
	dobashcompletion "${S}"/etc/bash_completion.d/vzctl.sh vzctl
}

pkg_postinst() {
	bash-completion_pkg_postinst
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
