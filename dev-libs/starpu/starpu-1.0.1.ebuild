# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/starpu/starpu-1.0.1.ebuild,v 1.1 2012/05/30 00:29:47 bicatali Exp $

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

IUSE="blas cuda fftw mpi opencl qt4 static-libs"
RDEPEND="sys-apps/hwloc
	sci-mathematics/glpk
	blas? ( virtual/blas )
	cuda? ( dev-util/nvidia-cuda-toolkit )
	fftw? ( sci-libs/fftw:3.0 )
	mpi? ( virtual/mpi )
	opencl? ( virtual/opencl )
	qt4? ( >=x11-libs/qt-gui-4.7
		   >=x11-libs/qt-opengl-4.7
		   >=x11-libs/qt-sql-4.7
		   x11-libs/qwt )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-respect-cflags.patch
	"${FILESDIR}"/${P}-system-blas.patch
	"${FILESDIR}"/${P}-no-examples.patch
	"${FILESDIR}"/${P}-no-pc-ldflags.patch
)

src_configure() {
	use blas && export BLAS_LIBS="$(pkg-config --libs blas)"
	myeconfargs+=(
		--disable-gcc-extensions
		$(use_enable cuda)
		$(use_enable fftw starpufft)
		$(use_enable opencl)
		$(use_enable qt4 starpu-top)
		$(use_with mpi mpicc "$(type -P mpicc)")
	)
	autotools-utils_src_configure
}
