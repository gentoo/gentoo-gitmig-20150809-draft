# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/optik/optik-1.3.ebuild,v 1.5 2002/08/16 02:49:58 murphy Exp $

S="${WORKDIR}/Optik-${PV}"

DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="mirror://sourceforge/optik/Optik-${PV}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="BSD"


src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc *.txt examples/*
}
