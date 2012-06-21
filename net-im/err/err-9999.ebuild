# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/err/err-9999.ebuild,v 1.1 2012/06/21 11:27:53 maksbotan Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/gbin/err.git"

DISTUTILS_SRC_TEST="setup.py"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils git-2 user

DESCRIPTION="err is a plugin based XMPP chatbot designed to be easily deployable, extensible and maintainable."
HOMEPAGE="http://gbin.github.com/err/"

SRC_URI=""
KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/xmpppy
	dev-python/python-daemon
	dev-python/yapsy"

pkg_setup() {
	python_pkg_setup
	ebegin "Creating err group and user"
	enewgroup 'err'
	enewuser 'err' -1 -1 -1 'err'
	eend ${?}
}

src_install() {
	distutils_src_install
	newinitd "${FILESDIR}"/errd.initd errd
	newconfd "${FILESDIR}"/errd.confd errd
	dodir /etc/${PN}
	dodir /var/lib/${PN}
	keepdir /var/log/${PN}
	keepdir /var/run/${PN}
	fowners -R err:err /var/lib/${PN}
	fowners -R err:err /var/log/${PN}
	fowners -R err:err /var/run/${PN}
	insinto /etc/${PN}
	newins errbot/config-template.py config.py
}
