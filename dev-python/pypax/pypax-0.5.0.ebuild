# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypax/pypax-0.5.0.ebuild,v 1.1 2012/07/24 13:35:03 blueness Exp $

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
KEYWORDS="~amd64 ~x86"
IUSE="xtpax"

DEPEND="
	|| (
		dev-libs/elfutils
		dev-libs/libelf
	)
	sys-devel/binutils
	xtpax? ( sys-apps/attr )"
RDEPEND=""

src_compile() {
	unset XATTR
	use xtpax && export XATTR="yes"
	distutils_src_compile
}
