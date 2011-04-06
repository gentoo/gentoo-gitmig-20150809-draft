# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-1.2.3.ebuild,v 1.15 2011/04/06 17:28:22 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"

inherit eutils distutils

DESCRIPTION="A python script for retrieving gentoo overlays."
HOMEPAGE="http://layman.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="git subversion test"

COMMON_DEPS="|| (
	dev-lang/python[xml]
	( dev-lang/python dev-python/pyxml ) )"
DEPEND="${COMMON_DEPS}
	test? ( dev-vcs/subversion )"
RDEPEND="${COMMON_DEPS}
	git? ( dev-vcs/git )
	subversion? (
		|| (
			>=dev-vcs/subversion-1.5.4[webdav-neon]
			>=dev-vcs/subversion-1.5.4[webdav-serf]
		)
	)"

pkg_setup() {
	if ! has_version dev-vcs/subversion; then
		ewarn "You do not have dev-vcs/subversion installed!"
		ewarn "While layman does not exactly depend on this"
		ewarn "version control system you should note that"
		ewarn "most available overlays are offered via"
		ewarn "dev-vcs/subversion. If you do not install it"
		ewarn "you will be unable to use these overlays."
		ewarn
	fi
}

src_install() {

	distutils_src_install

	dodir /etc/layman

	cp etc/* "${D}"/etc/layman/

	doman doc/layman.8
	dohtml doc/layman.8.html

	keepdir /usr/local/portage/layman
}

src_test() {
	einfo "Running layman doctests..."
	echo
	if ! PYTHONPATH="." $(PYTHON) layman/tests/dtest.py; then
		eerror "DocTests failed - please submit a bug report"
		die "DocTesting failed!"
	fi
}

pkg_postinst() {
	einfo "You are now ready to add overlays into your system."
	einfo
	einfo "layman -L"
	einfo
	einfo "will display a list of available overlays."
	einfo
	elog  "Select an overlay and add it using"
	einfo
	elog  "layman -a overlay-name"
	einfo
	elog  "If this is the very first overlay you add with layman,"
	elog  "you need to append the following statement to your"
	elog  "/etc/make.conf file:"
	elog
	elog  "source /usr/local/portage/layman/make.conf"
	elog
	elog  "If you modify the 'storage' parameter in the layman"
	elog  "configuration file (/etc/layman/layman.cfg) you will"
	elog  "need to adapt the path given above to the new storage"
	elog  "directory."
	einfo
	ewarn "Please add the 'source' statement to make.conf only AFTER "
	ewarn "you added your first overlay. Otherwise portage will fail."
	epause 5
}
