# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gpasman/gpasman-1.3.0.ebuild,v 1.1 2002/06/09 15:13:33 stroke Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Gpasman: GTK Password manager"
# This is _NOT_ the offical download site, but the official site
# seems to not work (ever).
SRC_URI="http://gpasman.nl.linux.org/${P}.tar.gz"
HOMEPAGE="http://gpasman.nl.linux.org/"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"


src_compile() {

	./configure --prefix=/usr || die "configure failed"
	emake || die
	
}

src_install() {

	mkdir -p ${D}/usr/bin
	emake prefix=${D}/usr install

}
