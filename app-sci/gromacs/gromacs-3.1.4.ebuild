# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gromacs/gromacs-3.1.4.ebuild,v 1.3 2003/03/25 09:51:20 george Exp $

IUSE=""

DESCRIPTION="The ultimate Molecular Dynamics simulation package"
SRC_URI="ftp://ftp.gromacs.org/pub/gromacs/${P}.tar.gz"
HOMEPAGE="http://www.gromacs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-libs/fftw-2.1.3
		>=sys-devel/binutils-2.10.91.0.2"


src_compile() {
	econf \
		--enable-fortran \
		--datadir=/usr/share/${P} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	# Install documentation.
	dodoc AUTHORS COPYING INSTALL README

	#move html docs under /usr/share/doc
	#and leave examples and templates under /usr/gromacs...
	mv ${D}/usr/share/${P}/html ${D}/usr/share/doc/${PF}
}
