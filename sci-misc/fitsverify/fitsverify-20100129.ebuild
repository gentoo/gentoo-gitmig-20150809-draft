# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/fitsverify/fitsverify-20100129.ebuild,v 1.1 2010/01/31 21:48:15 bicatali Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="FITS file format checker"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/ftools/fitsverify/"
SRC_URI="${HOMEPAGE}/${PN}.tar"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sci-libs/cfitsio-3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}"

src_compile() {
	$(tc-getCC) -DSTANDALONE ${CFLAGS} ${LDFLAGS} \
		ftverify.c fvrf_data.c fvrf_file.c fvrf_head.c fvrf_key.c fvrf_misc.c \
		-o ${PN} $(pkg-config --libs cfitsio) || die "compiling failed"
}

src_install() {
	dobin fitsverify || die
	dodoc README
}
