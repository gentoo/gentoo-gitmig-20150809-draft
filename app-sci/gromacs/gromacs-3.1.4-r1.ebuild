# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gromacs/gromacs-3.1.4-r1.ebuild,v 1.2 2003/07/02 12:33:39 aliz Exp $

IUSE="mpi"

DESCRIPTION="The ultimate Molecular Dynamics simulation package"
SRC_URI="ftp://ftp.gromacs.org/pub/gromacs/${P}.tar.gz"
HOMEPAGE="http://www.gromacs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

#mpi is a local USE flag now
#May become official when situation with mpich is cleared (now the only mpi implementation awailable is lam-mpi)
DEPEND=">=dev-libs/fftw-2.1.3
	mpi? ( >=dev-libs/lam-mpi-6.5.6 )
	>=sys-devel/binutils-2.10.91.0.2"


src_compile() {
#!!!Please note!!!
#for troublesome work gromacs should be compiled with the same mpi setting as fftw.
#Unfortunately portage cannot trace optional dependencies of dependencies at present.
#Until this (planned) feature is completed, please try to do corresponding check yourself.
	local myconf=""
	use mpi && myconf="${myconf} --enable-mpi"

	econf \
		--enable-fortran \
		--datadir=/usr/share/${P} ${myconf} || die "./configure failed"
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
