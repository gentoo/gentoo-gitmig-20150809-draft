# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/buildbot/buildbot-0.7.4.ebuild,v 1.5 2007/07/12 01:05:42 mr_bones_ Exp $

inherit distutils eutils

DESCRIPTION="A Python system to automate the compile/test cycle to validate code changes. Similar to Tinderbox, but simpler."
HOMEPAGE="http://buildbot.sourceforge.net/"
SRC_URI="mirror://sourceforge/buildbot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc irc mail test web"

commondepend=">=dev-lang/python-2.3
	>=dev-python/twisted-2.0.1"
RDEPEND="${commondepend}
	mail? ( dev-python/twisted-mail )
	irc? ( dev-python/twisted-words )
	web? ( dev-python/twisted-web )"
DEPEND="${commondepend}
	test? ( dev-python/twisted-web )
	doc? ( dev-python/epydoc )"

pkg_setup(){
	enewuser buildbot
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-svn-1.4.patch"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		PYTHONPATH=. "${python}" docs/epyrun -o docs/reference || \
			die "epyrun failed"
	fi
}

src_test() {
	local trialopts
	if ! has_version ">=dev-python/twisted-2.2"; then
		trialopts=-R
	fi
	PYTHONPATH=. trial ${trialopts} buildbot || die "tests failed!"
}

src_install() {
	distutils_src_install
	doinfo docs/buildbot.info
	dohtml -r docs/buildbot.html docs/images

	insinto /usr/share/doc/${PF}
	doins -r docs/examples

	if use doc; then
		doins -r docs/reference
	fi

	newconfd "${FILESDIR}/buildslave.confd" buildslave
	newinitd "${FILESDIR}/buildbot.initd" buildslave
	newconfd "${FILESDIR}/buildmaster.confd" buildmaster
	newinitd "${FILESDIR}/buildbot.initd" buildmaster
}

pkg_postinst() {
	elog 'The "buildbot" user and the "buildmaster" and "buildslave" init'
	elog "scripts were added to support starting buildbot through gentoo's"
	elog "init system.  To use this set up your build master or build slave"
	elog "following the buildbot documentation, make sure the resulting"
	elog 'directories are owned by the "buildbot" user and point'
	elog "${ROOT}etc/conf.d/buildmaster or ${ROOT}etc/conf.d/buildslave"
	elog "at the right location.  The scripts can run as a different user"
	elog "if desired.  If you need to run more than one master or slave"
	elog "just copy the scripts."
}
