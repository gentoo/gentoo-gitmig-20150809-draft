# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisoburn/libisoburn-1.0.0.ebuild,v 1.8 2011/04/13 20:16:31 maekke Exp $

EAPI=2

MY_PL=00
[[ ${PV/_p} != ${PV} ]] && MY_PL=${PV#*_p}
MY_PV="${PV%_p*}.pl${MY_PL}"

DESCRIPTION="Enables creation and expansion of ISO-9660 filesystems on all CD/DVD media supported by libburn"
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 x86"
IUSE="acl debug external-filters external-filters-setuid readline xattr zlib"
#IUSE="acl cdio debug external-filters external-filters-setuid readline xattr zlib"
#Supports libcdio but needs version >=0.83 which is not yet released.

RDEPEND=">=dev-libs/libburn-1.0.0
	>=dev-libs/libisofs-1.0.0
	acl? ( virtual/acl )
	readline? ( sys-libs/readline )
	xattr? ( sys-apps/attr )
	zlib? ( sys-libs/zlib )"
#RDEPEND="cdio? ( >=dev-libs/libcdio-0.83 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P%_p*}

src_configure() {
	econf --disable-dependency-tracking \
	--disable-static \
	$(use_enable readline libreadline) \
	$(use_enable acl libacl) \
	$(use_enable xattr) \
	$(use_enable zlib) \
	--disable-libjte \
	--disable-libcdio \
	$(use_enable external-filters) \
	$(use_enable external-filters-setuid) \
	 --disable-ldconfig-at-install \
	$(use_enable debug)
#	$(use_enable cdio libcdio) \
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS CONTRIBUTORS README TODO doc/comments || die "dodoc failed"

	cd "${S}"/xorriso
	docinto xorriso
	dodoc changelog.txt README_gnu_xorriso || die "dodoc failed"

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
