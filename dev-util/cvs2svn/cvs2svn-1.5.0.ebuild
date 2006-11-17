# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs2svn/cvs2svn-1.5.0.ebuild,v 1.1 2006/11/17 21:00:39 dev-zero Exp $

inherit distutils

DESCRIPTION="Convert a CVS repository to a Subversion repository"
HOMEPAGE="http://cvs2svn.tigris.org/"
SRC_URI="http://cvs2svn.tigris.org/files/documents/1462/34574/cvs2svn-1.5.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~ia64 ~ppc"
IUSE=""

DEPEND="dev-lang/python
	!<dev-util/subversion-1.0.9"
RDEPEND="${DEPEND}
	app-text/rcs"

src_test() {
	# Need this because subversion is localized, but the tests aren't
	export LC_ALL=C
	python run-tests.py || die "tests failed"
}
