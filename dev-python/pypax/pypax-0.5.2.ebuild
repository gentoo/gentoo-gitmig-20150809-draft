# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypax/pypax-0.5.2.ebuild,v 1.11 2012/09/30 17:22:56 armin76 Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="Python module for reading or writing PaX flags to an ELF."
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/elfix-${PV}.tar.gz"

S="${WORKDIR}/elfix-${PV}/scripts"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="xtpax"

DEPEND="
	dev-libs/elfutils
	xtpax? ( sys-apps/attr )"

RDEPEND=""

src_compile() {
	unset XATTR
	use xtpax && export XATTR="yes"
	distutils_src_compile
}
