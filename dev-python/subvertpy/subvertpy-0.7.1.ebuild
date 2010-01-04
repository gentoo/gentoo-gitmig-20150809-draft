# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subvertpy/subvertpy-0.7.1.ebuild,v 1.2 2010/01/04 10:33:36 fauli Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Alternative Python bindings for Subversion."
HOMEPAGE="http://samba.org/~jelmer/subvertpy/"
SRC_URI="http://samba.org/~jelmer/${PN}/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="test"

RDEPEND=">=dev-util/subversion-1.4
	!<dev-util/bzr-svn-0.5.0_rc2"
DEPEND="${RDEPEND}
	test? ( dev-python/nose )"

DOCS="NEWS AUTHORS"
