# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvs2svn/cvs2svn-1.5.0.ebuild,v 1.2 2010/06/22 18:43:49 arfrever Exp $

inherit distutils

FILEVER="34574"

DESCRIPTION="Convert a CVS repository to a Subversion repository"
HOMEPAGE="http://cvs2svn.tigris.org/"
SRC_URI="http://cvs2svn.tigris.org/files/documents/1462/${FILEVER}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc x86"
IUSE=""

DEPEND="dev-lang/python
		>=dev-vcs/subversion-1.0.9"
RDEPEND="${DEPEND}
		dev-vcs/rcs"

src_install() {
	distutils_src_install
	insinto "/usr/share/${PN}"
	doins -r contrib cvs2svn-example.options {profile-repos,show-db,verify-cvs2svn}.py
	doman cvs2svn.1
}

pkg_postinst() {
	elog "Additional scripts and examples have been installed to:"
	elog "  ${ROOT}usr/share/${PN}/"
}

src_test() {
	# Need this because subversion is localized, but the tests aren't
	export LC_ALL=C
	python run-tests.py || die "tests failed"
}
