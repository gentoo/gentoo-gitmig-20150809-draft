# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bing/bing-1.1.3.ebuild,v 1.1 2003/09/06 23:33:49 zul Exp $


DESCRIPTION="A point-to-point bandwidth measurement tool."
SRC_URI="http://distro.ibiblio.org/pub/Linux/distributions/debian/pool/main/b/bing/${PN}_1.1.3.orig.tar.gz"
HOMEPAGE="http://www.cnam.fr/reseau/bing.html"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="as-is"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:#COPTIM = -g: COPTIM = ${CLFAGS}:" Makefile.orig > Makefile
	emake || die 
}

src_install() {
	dobin bing
	doman unix/bing.8
	dodoc ChangeLog Readme.1st Readme
}
