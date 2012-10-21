# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ansible/ansible-9999.ebuild,v 1.4 2012/10/21 14:50:25 pinkbyte Exp $

EAPI="4"

PYTHON_COMPAT="python2_6 python2_7"

EGIT_REPO_URI="git://github.com/ansible/ansible.git"
EGIT_BRANCH="devel"

inherit distutils git-2

DESCRIPTION="Radically simple deployment, model-driven configuration management, and command execution framework"
HOMEPAGE="http://ansible.cc/"
SRC_URI=""

KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE="examples paramiko +sudo test"

DEPEND="test? (
		dev-python/nose
		dev-vcs/git
	)
"
RDEPEND="dev-python/jinja
	dev-python/pyyaml
	paramiko? ( dev-python/paramiko )
	!paramiko? ( virtual/ssh )
	sudo? ( app-admin/sudo )
"

src_prepare() {
	distutils_src_prepare
	# Skip tests which need ssh access
	sed -i 's:PYTHONPATH=./lib nosetests.*:\0 -e \\(TestPlayBook.py\\|TestRunner.py\\):' Makefile || die "sed failed"
}

src_test() {
	make tests
}

src_install() {
	distutils_src_install

	dodir /usr/share/ansible
	insinto /usr/share/ansible
	insopts -m0655
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
