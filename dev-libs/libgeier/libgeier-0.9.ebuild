# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgeier/libgeier-0.9.ebuild,v 1.3 2008/05/21 15:21:59 wrobel Exp $

inherit versionator

MY_PVD=$(get_version_component_range 1-2)
MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="Libgeier provides a library to access the german digital tax project ELSTER."
HOMEPAGE="http://www.taxbird.de/"
SRC_URI="http://www.taxbird.de/download/${PN}/${MY_PVD}/${PN}-${MY_PV}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/xmlsec
	=net-libs/xulrunner-1.8*
	sys-libs/zlib"

DEPEND="${DEPEND}
	dev-lang/swig"


src_compile() {
	econf || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed!"
	dodoc README
}
