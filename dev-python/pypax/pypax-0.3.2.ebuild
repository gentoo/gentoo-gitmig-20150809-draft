# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypax/pypax-0.3.2.ebuild,v 1.1 2011/11/27 02:37:47 blueness Exp $

EAPI=3

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
IUSE=""

DEPEND="dev-libs/elfutils
	sys-devel/binutils
	sys-apps/attr"
RDEPEND=""
