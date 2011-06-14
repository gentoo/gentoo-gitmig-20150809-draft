# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.0.28.2.ebuild,v 1.1 2011/06/14 05:48:26 pva Exp $

EAPI="4"

inherit bash-completion eutils

DESCRIPTION="OpenVZ ConTainers control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="bash-completion"

RDEPEND="
	net-firewall/iptables
	sys-apps/ed
	sys-apps/iproute2
	sys-fs/vzquota"

DEPEND="${RDEPEND}"

src_prepare() {
	# Set default OSTEMPLATE on gentoo
	sed -e 's:=redhat-:=gentoo-:' -i etc/dists/default || die
}

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-udev \
		$(use_enable bash-completion bashcomp) \
		--enable-logrotate
}

src_install() {
	emake DESTDIR="${D}" install install-gentoo

	# install the bash-completion script into the right location
	rm -rf "${ED}"/etc/bash_completion.d
	dobashcompletion etc/bash_completion.d/vzctl.sh vzctl

	# We need to keep some dirs
	keepdir /vz/{dump,lock,root,private,template/cache}
	keepdir /etc/vz/names /var/lib/vzctl/veip
}

pkg_postinst() {
	bash-completion_pkg_postinst
	local conf_without_OSTEMPLATE
	for file in \
		$(find "${EROOT}/etc/vz/conf/" \( -name *.conf -a \! -name 0.conf \)); do
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

	ewarn "Starting with 3.0.25 there is new vzeventd service to reboot CTs."
	ewarn "Please, drop /usr/share/vzctl/scripts/vpsnetclean and"
	ewarn "/usr/share/vzctl/scripts/vpsreboot from crontab and use"
	ewarn "/etc/init.d/vzeventd."
}
