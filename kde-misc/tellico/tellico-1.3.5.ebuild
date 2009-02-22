# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-1.3.5.ebuild,v 1.2 2009/02/22 22:17:31 carlo Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde sgml-catalog eutils

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A collection manager for the KDE environment."
HOMEPAGE="http://www.periapsis.org/tellico/"
SRC_URI="http://www.periapsis.org/tellico/download/${MY_P}.tar.gz
		mirror://gentoo/kde-admindir-3.5.5.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="calendar cddb yaz"

DEPEND=">=dev-libs/libxml2-2.6
	>=dev-libs/libxslt-1.0.19
	cddb?  ( || ( kde-base/libkcddb:3.5 kde-base/kdemultimedia:3.5 ) )
	calendar? ( || ( ( kde-base/ktnef:3.5 kde-base/libkcal:3.5 ) kde-base/kdepim:3.5 ) )
	media-libs/taglib
	yaz? ( dev-libs/yaz )"
RDEPEND="${DEPEND}"
need-kde 3.5

PATCHES=(
	"${FILESDIR}/${PN}-1.3-releaseflaws.patch"
	"${FILESDIR}/tellico-1.3.5-test-ldadd.diff"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	local myconf="$(use_enable cddb libkcddb) $(use_enable calendar libkcal)"
	rm -f "${S}/configure"
	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	einfo "Installing catalog..."
	"${ROOT}"/usr/bin/xmlcatalog --noout --add "delegatePublic" \
		"-//Robby Stephenson/DTD Tellico V9.0//EN" \
		"file:/"${ROOT}"usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
	"${ROOT}"/usr/bin/xmlcatalog --noout --add "delegateSystem" \
		"http://www.periapsis.org/tellico/dtd/v9/tellico.dtd" \
		"file:/"${ROOT}"usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
	"${ROOT}"/usr/bin/xmlcatalog --noout --add "delegateURI" \
		"http://www.periapsis.org/tellico/dtd/v9/tellico.dtd" \
		"file:/"${ROOT}"usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
}

pkg_postrm() {
	kde_pkg_postrm

	"${ROOT}"/usr/bin/xmlcatalog --noout --del \
		"file:/"${ROOT}"usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
}
