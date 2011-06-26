# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clipper/clipper-20100511-r1.ebuild,v 1.1 2011/06/26 10:13:02 jlec Exp $

EAPI=4

WANT_AUTOMAKE="1.11"

inherit autotools eutils flag-o-matic

DESCRIPTION="Object-oriented libraries for crystallographic data and crystallographic computation"
HOMEPAGE="http://www.ysbl.york.ac.uk/~cowtan/clipper/clipper.html"
# Transform 4-digit year to 2 digits
SRC_URI="http://www.ysbl.york.ac.uk/~cowtan/clipper/clipper-2.1-${PV:2:${#PV}}-ac.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	sci-libs/ccp4-libs
	sci-libs/fftw
	sci-libs/mmdb"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}-2.1

src_prepare() {
	epatch "${FILESDIR}"/20091215-missing-var.patch

	# ccp4 provides these, and more.
	sed -i -e "s:examples::g" "${S}"/Makefile.am

	AT_M4DIR="config" eautoreconf
}

src_configure() {
	# Recommended on ccp4bb/coot ML to fix crashes when calculating maps
	# on 64-bit systems
	append-flags -fno-strict-aliasing

	econf \
		--enable-ccp4 \
		--enable-cif \
		--enable-cns \
		--enable-contrib \
		--enable-minimol \
		--enable-mmdb \
		--enable-phs \
		--with-mmdb="${EPREFIX}"/usr \
		$(use_enable debug)
}

src_test() {
	emake \
		-C examples \
		check
}
