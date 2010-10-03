# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-0.8.4.ebuild,v 1.5 2010/10/03 15:13:39 klausman Exp $

EAPI=2

MY_PL=00
[[ ${PV/_p} != ${PV} ]] && MY_PL=${PV#*_p}
MY_PV="${PV%_p*}.pl${MY_PL}"

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org"
SRC_URI="http://files.libburnia-project.org/releases/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ppc ppc64 x86"
IUSE="track-src-odirect"
#IUSE="cdio track-src-odirect"
#Supports libcdio but needs version >=0.83 which is not yet released.

RDEPEND=""
#RDEPEND="cdio? ( >=dev-libs/libcdio-0.83 )"
DEPEND="dev-util/pkgconfig"

S=${WORKDIR}/${P%_p*}

src_configure() {
	econf --disable-static \
	--disable-dvd-obs-64k \
	--disable-libcdio \
	$(use_enable track-src-odirect)
#	$(use_enable cdio libcdio) \
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS CONTRIBUTORS README doc/comments || die "dodoc failed"

	cd "${S}"/cdrskin
	docinto cdrskin
	dodoc changelog.txt README || die "dodoc failed"

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
