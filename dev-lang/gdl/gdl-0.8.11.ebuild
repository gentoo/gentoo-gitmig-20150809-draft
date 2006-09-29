# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gdl/gdl-0.8.11.ebuild,v 1.2 2006/09/29 02:51:07 markusle Exp $

inherit eutils

DESCRIPTION="An Interactive Data Language compatible incremental compiler"
LICENSE="GPL-2"
HOMEPAGE="http://gnudatalanguage.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnudatalanguage/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE="python fftw hdf hdf5 netcdf imagemagick"

DEPEND=">=sys-libs/readline-4.3
	sci-libs/gsl
	sys-devel/libtool
	>=sci-libs/plplot-5.3
	imagemagick? ( media-gfx/imagemagick )
	hdf? ( sci-libs/hdf )
	hdf5? ( sci-libs/hdf5 )
	netcdf? ( sci-libs/netcdf )
	python? ( dev-lang/python
			dev-python/numarray
			dev-python/matplotlib )
	fftw? ( sci-libs/fftw )"


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4-gentoo.patch
}

src_compile() {
	econf \
	  $(use_with python) \
	  $(use_with fftw) \
	  $(use_with hdf) \
	  $(use_with hdf5) \
	  $(use_with netcdf) \
	  $(use_with imagemagick Magick) \
	  || die "econf failed!"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "failed to install"

	insinto /usr/share/${PN}
	doins -r src/pro
	doins -r src/py
	dodoc README PYTHON.txt AUTHORS ChangeLog NEWS TODO HACKING

	# add GDL provided routines to IDL_PATH
	echo "IDL_STARTUP=/usr/share/${PN}/pro" > 99gdl
	doenvd 99gdl
}
