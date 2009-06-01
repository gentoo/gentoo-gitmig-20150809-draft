# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibacl/pylibacl-0.4.0.ebuild,v 1.9 2009/06/01 16:11:09 nixnut Exp $

inherit distutils

DESCRIPTION="Python interface to libacl"
HOMEPAGE="http://sourceforge.net/projects/pylibacl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ~ppc64 sh sparc x86"
IUSE=""

RDEPEND="virtual/python
		sys-apps/acl"
DEPEND="${RDEPEND}
		>=dev-python/setuptools-0.6_rc7-r1"

src_test() {
	PYTHONPATH="$(ls -d build/lib*)" python test/test_acls.py || \
		{
			eerror
			eerror "If you got the following errors:"
			eerror "\"IOError: [Errno 95] Operation not supported\","
			eerror "then you should remount the filesystem containing"
			eerror "build directory with \"acl\" option enabled."
			eerror
			die "tests failed"
		}
}
