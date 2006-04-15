# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzrtools/bzrtools-0.7.ebuild,v 1.3 2006/04/15 00:24:53 wormo Exp $

inherit distutils

DESCRIPTION="bzrtools is a useful collection of utilities for bzr."
HOMEPAGE="http://bazaar.canonical.com/BzrTools"
SRC_URI="http://panoramicfeedback.com/opensource/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	=dev-util/bzr-0.7*"

src_test() {
	./test.py build/lib/bzrlib/plugins || die "test failed"
}
