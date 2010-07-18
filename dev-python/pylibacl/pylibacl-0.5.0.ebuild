# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibacl/pylibacl-0.5.0.ebuild,v 1.6 2010/07/18 12:23:07 nixnut Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="POSIX ACLs (Access Control Lists) for Python"
HOMEPAGE="http://sourceforge.net/projects/pylibacl/ http://pypi.python.org/pypi/pylibacl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/acl"
DEPEND="${RDEPEND}
		dev-python/setuptools"
# Tests are missing in the tarball.
RESTRICT="test"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" test/test_acls.py || \
			{
				eerror
				eerror "If you got the following errors:"
				eerror "\"IOError: [Errno 95] Operation not supported\","
				eerror "then you should remount the filesystem containing"
				eerror "build directory with \"acl\" option enabled."
				eerror
				return 1
			}
	}
	python_execute_function testing
}
