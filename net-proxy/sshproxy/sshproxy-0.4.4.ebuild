# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/sshproxy/sshproxy-0.4.4.ebuild,v 1.1 2006/08/25 15:39:33 mrness Exp $

inherit distutils

DESCRIPTION="sshproxy is an ssh gateway to apply ACLs on ssh connections"
HOMEPAGE="http://penguin.fr/sshproxy/"
SRC_URI="http://penguin.fr/sshproxy/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql"

DEPEND=">=dev-lang/python-2.4.0
		>=dev-python/paramiko-1.6
		mysql? ( >=dev-python/mysql-python-1.2.0 )"

pkg_setup() {
	enewgroup sshproxy
	enewuser sshproxy -1 -1 /var/lib/sshproxy sshproxy
}

src_install () {
	distutils_src_install

	diropts -o sshproxy -g sshproxy -m0750
	dodir /var/lib/sshproxy
	keepdir /var/lib/sshproxy

	# init/conf files for sshproxy daemon
	newinitd "${FILESDIR}/sshproxyd.initd" sshproxyd
}

pkg_postinst () {
	pkg_setup #for creating the user when installed from binary package

	distutils_pkg_postinst

	echo
	einfo "If this is your first installation, run"
	einfo "   emerge --config =${CATEGORY}/${PF}"
	einfo "to initialize the backend."
	echo
	einfo "There is no need to install sshproxy on a client machine."
	einfo "You can connect to a SSH server using this proxy by running"
	einfo "   ssh -tp PROXY_PORT PROXY_HOST REMOTE_USER@REMOTE_HOST"
}

pkg_config() {
	HOME=/var/lib/sshproxy INITD_STARTUP="/etc/init.d/sshproxyd start" \
			chroot "${ROOT}" /usr/bin/sshproxyd --wizard
	chown -R sshproxy:sshproxy "${ROOT}/var/lib/sshproxy"
}
