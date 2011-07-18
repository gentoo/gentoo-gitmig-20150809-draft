# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-9999.ebuild,v 1.19 2011/07/18 10:54:30 idl0r Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit eutils distutils git-2

DESCRIPTION="Tool to manage Gentoo overlays"
HOMEPAGE="http://layman.sourceforge.net"
SRC_URI=""
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/layman.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bazaar cvs darcs git mercurial subversion test"

COMMON_DEPS="dev-lang/python[xml]"
DEPEND="${COMMON_DEPS}
	test? ( dev-vcs/subversion )
	app-text/asciidoc"
RDEPEND="${COMMON_DEPS}
	bazaar? ( dev-vcs/bzr )
	cvs? ( dev-vcs/cvs )
	darcs? ( dev-vcs/darcs )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	subversion? (
		|| (
			>=dev-vcs/subversion-1.5.4[webdav-neon]
			>=dev-vcs/subversion-1.5.4[webdav-serf]
		)
	)"
RESTRICT_PYTHON_ABIS="2.4 3.*"

src_test() {
	testing() {
		for suite in layman/tests/{dtest,external}.py ; do
			PYTHONPATH="." "$(PYTHON)" ${suite} \
					|| die "test suite '${suite}' failed"
		done
	}
	python_execute_function testing
}

src_compile() {
	distutils_src_compile
	# override MAKEOPTS to prevent build failure
	emake -j1 -C doc || die "emake -C doc failed"
}

src_install() {
	distutils_src_install

	insinto /etc/layman
	doins etc/layman.cfg || die

	doman doc/layman.8
	dohtml doc/layman.8.html

	keepdir /var/lib/layman
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "You are now ready to add overlays into your system."
	einfo
	einfo "  layman -L"
	einfo
	einfo "will display a list of available overlays."
	einfo
	elog  "Select an overlay and add it using"
	elog
	elog  "  layman -a overlay-name"
	elog
	elog  "If this is the very first overlay you add with layman,"
	elog  "you need to append the following statement to your"
	elog  "/etc/make.conf file:"
	elog
	elog  "  source /var/lib/layman/make.conf"
	elog
	elog  "If you modify the 'storage' parameter in the layman"
	elog  "configuration file (/etc/layman/layman.cfg) you will"
	elog  "need to adapt the path given above to the new storage"
	elog  "directory."
	elog
	ewarn "Please add the 'source' statement to make.conf only AFTER "
	ewarn "you added your first overlay. Otherwise portage will fail."
	epause 5
}
