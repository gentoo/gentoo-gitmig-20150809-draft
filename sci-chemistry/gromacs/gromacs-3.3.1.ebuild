# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gromacs/gromacs-3.3.1.ebuild,v 1.1 2006/08/08 02:54:41 markusle Exp $

inherit eutils fortran

IUSE="altivec mpi xml"

DESCRIPTION="The ultimate molecular dynamics simulation package"
SRC_URI="ftp://ftp.gromacs.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gromacs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc64"

# gromacs uses fortran intrinsics such as RSHIFT that
# are currently missing from gfortran; hence we need
# to require g77 for the time being (see bug #141672).
FORTRAN="g77"


#mpi is a local USE flag now
#May become official when situation with mpich is cleared (now the only mpi implementation awailable is lam-mpi)
DEPEND="=sci-libs/fftw-2.1*
	mpi? ( >=sys-cluster/lam-mpi-6.5.6 )
	>=sys-devel/binutils-2.10.91.0.2
	app-shells/tcsh
	xml? ( dev-libs/libxml2 )"

pkg_setup() {
	# !!!Please note!!!
	# for troublesome work gromacs should be compiled with the same mpi setting
	# as fftw.
	if use mpi; then
		if ! built_with_use =sci-libs/fftw-2.1* mpi; then
			die "=sci-libs/fftw-2.1* must be built with USE=mpi."
		fi
	fi

	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	if use ppc64 && use altivec ; then
		epatch ${FILESDIR}/${PN}-ppc64-altivec.patch
	fi
}

src_compile() {
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
		$(use_with xml) \
		$(use_enable mpi) \
		$(use_enable altivec ppc-altivec) \
		$(use_enable alpha axp-asm) || die "configure failed"

#		$(use_enable static all-static) \

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
