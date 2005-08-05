# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gromacs/gromacs-3.2.1-r1.ebuild,v 1.2 2005/08/05 15:55:41 omkhar Exp $

inherit eutils

IUSE="altivec mpi xml2"

DESCRIPTION="The ultimate molecular dynamics simulation package"
SRC_URI="ftp://ftp.gromacs.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gromacs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc64"

#mpi is a local USE flag now
#May become official when situation with mpich is cleared (now the only mpi implementation awailable is lam-mpi)
DEPEND="=sci-libs/fftw-2.1*
	mpi? ( >=sys-cluster/lam-mpi-6.5.6 )
	>=sys-devel/binutils-2.10.91.0.2
	app-shells/tcsh
	xml2? ( dev-libs/libxml2 )"

src_unpack() {
	unpack ${A}
	if use ppc64 && use altivec ; then
		epatch ${FILESDIR}/${PN}-ppc64-altivec.patch
	fi
}

src_compile() {
#!!!Please note!!!
#for troublesome work gromacs should be compiled with the same mpi setting as fftw.
#Unfortunately portage cannot trace optional dependencies of dependencies at present.
#Until this (planned) feature is completed, please try to do corresponding check yourself.

	# static should work but something's broken.
	# gcc spec file may be screwed up.
	# Static linking should try -lgcc instead of -lgcc_s.
	# For more info:
	# http://lists.debian.org/debian-gcc/2002/debian-gcc-200201/msg00150.html
	econf \
		--enable-fortran \
		--datadir=/usr/share/${P} \
		--bindir=/usr/bin \
		--libdir=/usr/lib \
		$(use_with xml2 xml) \
		$(use_enable mpi) \
		$(use_enable altivec ppc-altivec) \
		$(use_enable alpha axp-asm) || die "configure failed"

	#	`use_enable static all-static` \

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
