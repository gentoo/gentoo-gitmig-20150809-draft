# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cpl/cpl-5.3.1.ebuild,v 1.1 2011/04/08 04:39:17 bicatali Exp $

EAPI=4
JAVA_PKG_OPT_USE=gasgano
inherit eutils java-pkg-opt-2

DESCRIPTION="ESO common pipeline library for astronomical data reduction"
HOMEPAGE="http://www.eso.org/sci/software/cpl/"
SRC_URI="ftp://ftp.eso.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc gasgano static-libs"

RDEPEND=">=sci-libs/cfitsio-3.09
	sci-astronomy/wcslib
	sci-libs/fftw:3.0
	gasgano? ( sci-astronomy/gasgano )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	doc? ( app-doc/doxygen dev-texlive/texlive-fontsrecommended )
	gasgano? ( >=virtual/jdk-1.5 )"

src_configure() {
	has_version sci-libs/cfitsio[static-libs] || \
		sed -i -e 's/libcfitsio.a/libcfitsio.so/' configure
	local myconf="--without-gasgano"
	use gasgano && \
		myconf="--with-gasgano=${EPREFIX}/usr
				--with-gasgano-classpath=${EPREFIX}/usr/share/gasgano/lib"
	econf \
		$(use_enable static-libs static) \
		--with-cfitsio="${EPREFIX}/usr" \
		--with-wcs="${EPREFIX}/usr" \
		--with-fftw="${EPREFIX}/usr" \
		${myconf}
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}"
	if use doc; then
		VARTEXFONTS=${T}/fonts doxygen Doxyfile || die
	fi
}
src_install() {
	default
	use doc && dohtml -r html
}
