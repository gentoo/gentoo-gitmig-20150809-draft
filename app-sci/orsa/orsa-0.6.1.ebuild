# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/orsa/orsa-0.6.1.ebuild,v 1.3 2004/11/04 12:44:34 phosphan Exp $

inherit base flag-o-matic

DESCRIPTION="Orbit Reconstruction, Simulation and Analysis"
HOMEPAGE="http://orsa.sourceforge.net/"
SRC_URI="mirror://sourceforge/orsa/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="opengl mpi fftw ginac cln gsl qt"

S="${WORKDIR}/${P/_/-}"

DEPEND="virtual/libc
	fftw? ( =dev-libs/fftw-2.1* )
	>=dev-libs/gsl-1.3
	qt? ( >=x11-libs/qt-3.3 )
	>=sys-libs/readline-4.2
	mpi? ( sys-cluster/lam-mpi )
	ginac? ( >=app-sci/ginac-1.2.0 )
	gsl? ( dev-libs/gsl )
	cln? ( >=dev-libs/cln-1.1.6 )"

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_compile() {
	if ! use mpi; then
		export MPICXX="g++"
	fi
	local myconf
	if ! use ginac; then
		myconf="--with-ginac-prefix=/no/such/file"
	fi
	if ! use gsl; then
		myconf="${myconf} --with-gsl-prefix=/no/such/file"
	fi
	if ! use cln; then
		myconf="${myconf} --with-cln-prefix=/no/such/file"
	fi
	if ! use fftw; then
		sed -e 's/have_fftw=yes/have_fftw=no/' -i configure
	fi
	if ! use qt; then
		myconf="${myconf} --with-qt-dir=/no/such/file"
	fi
	econf ${myconf} $(use_with opengl gl) || die "configure failed"
	if use mpi; then
		sed -e 's/\(orsa_LDADD = .*\)/\1 -llammpi++ -lmpi -llam -lpthread/' \
			-i src/orsa/Makefile
	fi

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	dodoc src/test/*
}
