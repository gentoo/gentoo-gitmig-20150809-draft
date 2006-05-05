# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xapwrap/xapwrap-0.3.1.ebuild,v 1.1 2006/05/05 16:18:01 marienz Exp $

inherit distutils eutils

DESCRIPTION="XapWrap enhances xapian's python bindings."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodXapwrap"
SRC_URI="mirror://gentoo/Xapwrap-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/epsilon-0.4
	>=dev-libs/xapian-bindings-0.9.2"

S="${WORKDIR}/Xapwrap-${PV}"

DOCS="README NEWS.txt"


pkg_setup() {
	if ! built_with_use xapian-bindings python; then
		eerror "Need xapian-bindings compiled with USE=python"
		die "Need xapian-bindings compiled with USE=python"
	fi
}
