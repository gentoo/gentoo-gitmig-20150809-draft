# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

S="${WORKDIR}/Optik-1.2"

DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="mirror://sourceforge/optik/Optik-${PV}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="BSD"

src_install () {
	cd ${S}
	python setup.py install --prefix=${D}/usr || die
	dodoc *.txt
}



