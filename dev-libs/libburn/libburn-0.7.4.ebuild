# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-0.7.4.ebuild,v 1.1 2009/12/09 19:27:38 billie Exp $

EAPI=2

MY_PL=00
[[ ${PV/_p} != ${PV} ]] && MY_PL=${PV#*_p}
MY_PV="${PV%_p*}.pl${MY_PL}"

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org"
SRC_URI="http://files.libburnia-project.org/releases/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="track-src-odirect"

RDEPEND=""
DEPEND="dev-util/pkgconfig"

S=${WORKDIR}/${P%_p*}

src_configure() {
	econf --disable-static \
	--disable-dvd-obs-64k \
	$(use_enable track-src-odirect)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS CONTRIBUTORS README doc/comments || die "dodoc failed"

	cd "${S}"/cdrskin
	docinto cdrskin
	dodoc changelog.txt README || die "dodoc failed"

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
