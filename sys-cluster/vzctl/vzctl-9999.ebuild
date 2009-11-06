# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-9999.ebuild,v 1.4 2009/11/06 13:12:44 pva Exp $

EAPI="2"

inherit bash-completion autotools git

DESCRIPTION="OpenVZ ConTainers control utility"
HOMEPAGE="http://openvz.org/"
EGIT_REPO_URI="git://git.openvz.org/pub/vzctl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bash-completion"

RDEPEND="
	net-firewall/iptables
	sys-apps/ed
	sys-apps/iproute2
	sys-fs/vzquota
	virtual/cron"

DEPEND="${RDEPEND}"

src_prepare() {
	# Set default OSTEMPLATE on gentoo
	sed -e 's:=redhat-:=gentoo-:' -i etc/dists/default || die
	eautoreconf
}

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-cron \
		--enable-udev \
		--enable-logrotate \
		$(use_enable bash-completion bashcomp)
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
	if has_version "<sys-cluster/vzctl-3.0.10"; then
		ewarn "The location of some vzctl files have changed. Most notably,"
		ewarn "CT configuration files and samples directory has changed from"
		ewarn "/etc/vz to /etc/vz/conf. In order to be able to work with"
		ewarn "your CTs, please do the following:"
		ewarn
		ewarn "bash# mv /etc/vz/[0-9]*.conf /etc/vz/conf/"
		ewarn
	fi

	local conf_without_OSTEMPLATE
	for file in \
		$(find "${ROOT}/etc/vz/conf/" \( -name *.conf -a \! -name 0.conf \)); do
		if ! grep '^OSTEMPLATE' $file > /dev/null; then
			conf_without_OSTEMPLATE+=" $file"
		fi
	done

	if [[ -n ${conf_without_OSTEMPLATE} ]]; then
		ewarn
		ewarn "OSTEMPLATE default was changed from redhat-like to gentoo."
		ewarn "This means that any VEID.conf files without explicit or correct"
		ewarn "OSTEMPLATE set will use gentoo scripts instead of redhat."
		ewarn "Please check the following configs:"
		for file in ${conf_without_OSTEMPLATE}; do
			ewarn "${file}"
		done
		ewarn
	fi

	ewarn "To avoid loosing network to CTs on iface down/up, please, add the"
	ewarn "following code to /etc/conf.d/net:"
	ewarn " postup() {"
	ewarn "     /usr/sbin/vzifup-post \${IFACE}"
	ewarn " }"

	elog "NOTE: Starting with vzctl-3.0.22 the mechanism for choosing the"
	elog "interfaces to send ARP requests to has been improved (see description"
	elog "of NEIGHBOUR_DEVS in vz.conf(5) man page). In case CT IP addresses"
	elog "are not on the same subnet as HN IPs, it may lead to such CTs being"
	elog "unreachable from the outside world."
	elog
	elog "The solution is to set up a device route(s) for the network your CTs are"
	elog "in. For more details, see http://bugzilla.openvz.org/show_bug.cgi?id=771#c1"
	elog
	elog "The old vzctl behavior can be restored by setting NEIGHBOUR_DEVS to any"
	elog 'value other than "detect" in /etc/vz/vz.conf.'
}
