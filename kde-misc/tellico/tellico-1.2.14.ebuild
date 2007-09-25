# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-1.2.14.ebuild,v 1.1 2007/09/25 04:57:51 philantrop Exp $

inherit kde sgml-catalog eutils

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A collection manager for the KDE environment."
HOMEPAGE="http://www.periapsis.org/tellico"
SRC_URI="http://www.periapsis.org/tellico/download/${MY_P}.tar.gz
		mirror://gentoo/kde-admindir-3.5.5.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="calendar cddb yaz"

RDEPEND=">=dev-libs/libxml2-2.6
	>=dev-libs/libxslt-1.0.19
	cddb?  ( || ( kde-base/libkcddb kde-base/kdemultimedia ) )
	calendar? ( || ( ( kde-base/ktnef kde-base/libkcal ) kde-base/kdepim ) )
	media-libs/taglib
	yaz? ( dev-libs/yaz )"

need-kde 3.5

src_unpack() {
	kde_src_unpack
	cd "${S}"

	# Disabling a single test that is broken with --as-needed. Dug into it,
	# not worth fixing unless you're totally bored.
	epatch "${FILESDIR}/${P}-disable_formattest.patch"

	sed -i -e "s:\(MimeType=.*\):\1;:" tellico.desktop
	sed -i -e "s:\(Icon=\).*:\1${PN}:" tellico.desktop
}

src_compile() {
	local myconf="$(use_enable cddb libkcddb) $(use_enable calendar libkcal)"
	rm -f "${S}/configure"
	kde_src_compile
}

pkg_postinst() {
	einfo "Installing catalog..."
	"${ROOT}"/usr/bin/xmlcatalog --noout --add "delegatePublic" \
		"-//Robby Stephenson/DTD Tellico V9.0//EN" \
		"file://${ROOT}usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
	"${ROOT}"/usr/bin/xmlcatalog --noout --add "delegateSystem" \
		"http://www.periapsis.org/tellico/dtd/v9/tellico.dtd" \
		"file://${ROOT}usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
	"${ROOT}"/usr/bin/xmlcatalog --noout --add "delegateURI" \
		"http://www.periapsis.org/tellico/dtd/v9/tellico.dtd" \
		"file://${ROOT}usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
}

pkg_postrm() {
	"${ROOT}"/usr/bin/xmlcatalog --noout --del \
		"file://${ROOT}usr/share/apps/tellico/tellico.dtd" \
		"${ROOT}"/etc/xml/catalog
}
