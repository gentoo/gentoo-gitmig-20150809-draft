# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/optik/optik-1.3.ebuild,v 1.15 2004/06/25 01:35:33 agriffis Exp $

S="${WORKDIR}/Optik-${PV}"

DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="mirror://sourceforge/optik/Optik-${PV}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="BSD"
IUSE=""

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc *.txt examples/*
}
