# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/starpu/starpu-1.0.1.ebuild,v 1.3 2012/06/23 04:46:43 ssuominen Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

PID=30852

DESCRIPTION="Unified runtime system for heterogeneous multicore architectures"
HOMEPAGE="http://runtime.bordeaux.inria.fr/StarPU/"
SRC_URI="https://gforge.inria.fr/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="blas cuda doc examples fftw gcc-plugin mpi opencl qt4 static-libs test"
RDEPEND="sys-apps/hwloc
	sci-mathematics/glpk
	blas? ( virtual/blas )
	cuda? ( x11-drivers/nvidia-drivers dev-util/nvidia-cuda-toolkit )
	fftw? ( sci-libs/fftw:3.0 )
	mpi? ( virtual/mpi )
	opencl? ( virtual/opencl )
	qt4? ( >=x11-libs/qt-gui-4.7
		   >=x11-libs/qt-opengl-4.7
		   >=x11-libs/qt-sql-4.7
		   x11-libs/qwt )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( gcc-plugin? ( dev-scheme/guile ) )"

PATCHES=(
	"${FILESDIR}"/${P}-detect-qt.patch
	"${FILESDIR}"/${P}-respect-cflags.patch
	"${FILESDIR}"/${P}-system-blas.patch
	"${FILESDIR}"/${P}-no-examples.patch
	"${FILESDIR}"/${P}-no-pc-ldflags.patch
)

src_prepare() {
	sed -i -e '/AM_INIT_AUTOMAKE/s:-Werror ::' configure.ac || die #423011
	autotools-utils_src_prepare
}

src_configure() {
	use blas && export BLAS_LIBS="$(pkg-config --libs blas)"
	myeconfargs+=(
		$(use_enable cuda)
		$(use_enable fftw starpufft)
		$(use_enable gcc-plugin gcc-extensions)
		$(use_enable opencl)
		$(use_enable qt4 starpu-top)
		$(use_with mpi mpicc "$(type -P mpicc)")
		$(use mpi && use_enable test mpi-check)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	use doc && dodoc doc/*.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
