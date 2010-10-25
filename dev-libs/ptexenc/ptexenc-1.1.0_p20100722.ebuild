# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ptexenc/ptexenc-1.1.0_p20100722.ebuild,v 1.2 2010/10/25 04:38:59 jer Exp $

EAPI=3

DESCRIPTION="Library for Japanese pTeX providing a better way of handling character encodings"
HOMEPAGE="http://tutimura.ath.cx/ptexlive/?ptexenc"
SRC_URI="mirror://gentoo/texlive-${PV#*_p}-source.tar.xz"
# http://tutimura.ath.cx/~nob/tex/ptexlive/ptexenc/${P}.tar.xz

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa"
IUSE="iconv static-libs"

DEPEND="iconv? ( virtual/libiconv )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${PN}
#S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${P}
#src_unpack() {
#	unpack ${A}
#	mv "${WORKDIR}/${P}" "${S}"
#}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable iconv kanji-iconv)
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -name '*.la' -delete

	dodoc ChangeLog README || die
}
