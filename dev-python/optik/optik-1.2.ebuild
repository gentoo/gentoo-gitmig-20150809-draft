# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/optik/optik-1.2.ebuild,v 1.14 2004/05/04 12:00:33 kloeri Exp $

S="${WORKDIR}/Optik-1.2"

DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="mirror://sourceforge/optik/Optik-${PV}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="BSD"
IUSE=""

src_install () {
	cd ${S}
	python setup.py install --prefix=${D}/usr || die
	dodoc *.txt
}
