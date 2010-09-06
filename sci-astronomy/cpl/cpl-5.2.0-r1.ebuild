# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cpl/cpl-5.2.0-r1.ebuild,v 1.1 2010/09/06 10:56:26 xarthisius Exp $

EAPI=2
JAVA_PKG_OPT_USE=gasgano
inherit java-pkg-opt-2

DESCRIPTION="ESO common pipeline library for astronomical data reduction"
HOMEPAGE="http://www.eso.org/sci/data-processing/software/cpl/"
SRC_URI="ftp://ftp.eso.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc gasgano"

RDEPEND=">=sci-libs/cfitsio-3.09
	sci-astronomy/wcslib
	sci-libs/fftw:3.0
	gasgano? ( sci-astronomy/gasgano )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	doc? ( app-doc/doxygen )
	gasgano? ( >=virtual/jdk-1.5 )"

src_configure() {
	local myconf="--without-gasgano"
	use gasgano && \
		myconf="--with-gasgano=/usr
				--with-gasgano-classpath=/usr/share/gasgano/lib"
	econf \
		--with-cfitsio="/usr" \
		--with-wcs="/usr" \
		--with-fftw="/usr" \
		${myconf}
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" || die #336189
	if use doc; then
		doxygen Doxyfile || die
	fi
}
src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS TODO BUGS ChangeLog || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r html || die
	fi
}
