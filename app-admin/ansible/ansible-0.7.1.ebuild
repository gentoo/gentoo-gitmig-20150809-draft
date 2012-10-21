# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ansible/ansible-0.7.1.ebuild,v 1.2 2012/10/21 14:50:25 pinkbyte Exp $

EAPI="4"

PYTHON_COMPAT="python2_6 python2_7"

inherit distutils

DESCRIPTION="Radically simple deployment, model-driven configuration management, and command execution framework"
HOMEPAGE="http://ansible.cc/"
SRC_URI="mirror://github/ansible/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="examples paramiko +sudo"

# Stable version fails almost all quality tests
RESTRICT="test"

DEPEND=""
RDEPEND="
	dev-python/jinja
	dev-python/pyyaml
	paramiko? ( dev-python/paramiko )
	!paramiko? ( virtual/ssh )
	sudo? ( app-admin/sudo )
"

src_install() {
	distutils_src_install

	dodir /usr/share/ansible
	insinto /usr/share/ansible
	doins library/*

	doman docs/man/man1/*.1
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${P}/examples
	fi

	newenvd "${FILESDIR}"/${PN}.env 95ansible
	dodir /etc/ansible
	insinto /etc/ansible
	doins examples/ansible.cfg examples/hosts
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "You have to create hosts file for user:"
	einfo "		echo \"127.0.0.1\" > ~/ansible_hosts"
	einfo "or global:"
	einfo "		echo \"127.0.0.1\" > /etc/ansible/hosts"
	einfo ""
	einfo "More info on http://ansible.github.com/gettingstarted.html"
}
