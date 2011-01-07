# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/buildbot-slave/buildbot-slave-0.8.2.ebuild,v 1.7 2011/01/07 17:23:38 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="trial buildslave"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit distutils eutils

MY_PV="${PV/_p/p}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="BuildBot Slave Daemon"
HOMEPAGE="http://buildbot.net/ http://pypi.python.org/pypi/buildbot-slave"
SRC_URI="mirror://sourceforge/buildbot/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE="test"

RDEPEND="dev-python/setuptools
	>=dev-python/twisted-2
	!!<dev-util/buildbot-0.8.1"
DEPEND="${RDEPEND}
	test? ( dev-python/mock )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="buildslave"

pkg_setup() {
	python_pkg_setup
	enewuser buildbot
}

src_install() {
	distutils_src_install

	newconfd "${FILESDIR}/buildslave.confd" buildslave || die "newconfd failed"
	newinitd "${FILESDIR}/buildslave.initd" buildslave || die "newinitd failed"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "The \"buildbot\" user and the \"buildslave\" init script has been added"
	elog "to support starting buildslave through Gentoo's init system. To use this,"
	elog "set up your build slave following the documentation, make sure the"
	elog "resulting directories are owned by the \"buildbot\" user and point"
	elog "\"${ROOT}etc/conf.d/buildslave\" at the right location.  The scripts can"
	elog "run as a different user if desired. If you need to run more than one"
	elog "build slave, just copy the scripts."
}
