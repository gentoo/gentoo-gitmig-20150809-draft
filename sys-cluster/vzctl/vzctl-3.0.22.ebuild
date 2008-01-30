# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.22.ebuild,v 1.3 2008/01/30 08:30:30 pva Exp $

inherit bash-completion eutils

DESCRIPTION="OpenVZ VE control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc64 ~sparc x86"
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

	# We need to keep some dirs
	keepdir /vz/{dump,lock,root,private,template/cache}
	keepdir /etc/vz/names /var/lib/vzctl/veip
}

pkg_postinst() {
	bash-completion_pkg_postinst
	ewarn
	if has_version "<3.0.10"; then
		ewarn "The location of some vzctl files have changed. Most notably,"
		ewarn "VE configuration files and samples directory has changed from"
		ewarn "/etc/vz to /etc/vz/conf. In order to be able to work with"
		ewarn "your VEs, please do the following:"
		ewarn
		ewarn "bash# mv /etc/vz/[0-9]*.conf /etc/vz/conf/"
		ewarn
	fi
	ewarn "NOTE: Starting with vzctl-3.0.22 the mechanism for choosing the"
	ewarn "interfaces to send ARP requests to has been improved (see description"
	ewarn "of NEIGHBOUR_DEVS in vz.conf(5) man page). In case VE IP addresses"
	ewarn "are not on the same subnet as HN IPs, it may lead to such VEs being"
	ewarn "unreachable from the outside world."
	ewarn
	ewarn "The solution is to set up a device route(s) for the network your VEs are"
	ewarn "in. For more details, see http://bugzilla.openvz.org/show_bug.cgi?id=771#c1"
	ewarn
	ewarn "The old vzctl behavior can be restored by setting NEIGHBOUR_DEVS to any"
	ewarn 'value other than "detect" in /etc/vz/vz.conf.'
}
