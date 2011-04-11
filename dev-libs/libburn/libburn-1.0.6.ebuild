# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-1.0.6.ebuild,v 1.1 2011/04/11 19:16:59 billie Exp $

EAPI=4

MY_PL=00
[[ ${PV/_p} != ${PV} ]] && MY_PL=${PV#*_p}
MY_PV="${PV%_p*}.pl${MY_PL}"

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org"
SRC_URI="http://files.libburnia-project.org/releases/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug static-libs track-src-odirect"
#IUSE="cdio debug static-libs track-src-odirect"
#Supports libcdio but needs version >=0.83 which is not yet released.

RDEPEND=""
#RDEPEND="cdio? ( >=dev-libs/libcdio-0.83 )"
DEPEND="dev-util/pkgconfig"

S=${WORKDIR}/${P%_p*}

src_configure() {
	econf \
	$(use_enable static-libs static) \
	$(use_enable track-src-odirect) \
	--disable-libcdio \
	--disable-ldconfig-at-install \
	$(use_enable debug)
#	$(use_enable cdio libcdio) \
}

src_install() {
	default

	dodoc CONTRIBUTORS doc/comments

	cd "${S}"/cdrskin
	docinto cdrskin
	dodoc changelog.txt README wiki_plain.txt
	docinto cdrskin/html
	dohtml cdrskin_eng.html

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
