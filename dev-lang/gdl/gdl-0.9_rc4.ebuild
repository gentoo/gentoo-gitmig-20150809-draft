# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gdl/gdl-0.9_rc4.ebuild,v 1.5 2010/02/27 05:28:16 markusle Exp $

EAPI="2"

inherit eutils flag-o-matic autotools multilib

MYP=${P/_/}
DESCRIPTION="An Interactive Data Language compatible incremental compiler"
LICENSE="GPL-2"
HOMEPAGE="http://gnudatalanguage.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnudatalanguage/${MYP}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python fftw hdf hdf5 netcdf imagemagick"

RDEPEND=">=sys-libs/readline-4.3
	sci-libs/gsl
	=dev-java/antlr-2.7*[cxx]
	>=sci-libs/plplot-5.3
	imagemagick? ( media-gfx/imagemagick )
	hdf? ( sci-libs/hdf )
	hdf5? ( sci-libs/hdf5 )
	netcdf? ( sci-libs/netcdf )
	python? ( dev-python/numarray dev-python/matplotlib )
	fftw? ( >=sci-libs/fftw-3 )"

DEPEND="${RDEPEND}
	sys-devel/libtool"

S="${WORKDIR}/${MYP}"

src_prepare() {
	use hdf5 && has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	epatch "${FILESDIR}"/${PN}-0.9_rc2-gcc4.4.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
	epatch "${FILESDIR}"/${P}-antlr.patch

	# we need to blow away the directory with antlr
	# otherwise the build system picks up bogus
	# header files
	rm -fr "${S}"/src/antlr || die "failed to remove antlr directory"

	# adjust the *.pro file install path
	sed -i -e "s:datasubdir=.*$:datasubdir=\"${PN}\":" configure.in \
		|| die "Failed to fix *.pro install patch."

	# set path to libantlr. Note that we need to explicitly link against
	# libantlr.a since kde-sdk provides libantlr.so which we can not
	# use (see bug #286630).
	sed -i -e "s:ANTLR_LIB:/usr/$(get_libdir)/libantlr.a:" src/Makefile.am \
		|| die "Failed to adjust link to libantlr."
	eautoreconf
}

src_configure() {
	# need to check for old plplot
	local myconf
	if has_version '<sci-libs/plplot-5.9.0'; then
		myconf="${myconf} --enable-oldplplot"
	fi

	# make sure we're hdf5-1.6 backward compatible
	use hdf5 && append-flags -DH5_USE_16_API

	use proj && append-cppflags -DPJ_LIB__
	econf \
	  $(use_with python) \
	  $(use_with fftw) \
	  $(use_with hdf) \
	  $(use_with hdf5) \
	  $(use_with netcdf) \
	  $(use_with imagemagick Magick) \
	  ${myconf} \
	  || die "econf failed"

}

src_test() {
	cd "${S}"/testsuite
	PATH="${S}"/src gdl <<-EOF
		test_suite
	EOF
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README PYTHON.txt AUTHORS ChangeLog NEWS TODO HACKING \
		|| die "Failed to install docs"
}
