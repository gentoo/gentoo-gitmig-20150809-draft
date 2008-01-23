# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgeier/libgeier-0.9_rc.ebuild,v 1.1 2008/01/23 10:44:59 wrobel Exp $

MY_P=${P/_/-}
MY_PV=${PV/_*/}

DESCRIPTION="Libgeier provides a library to access the german digital tax project ELSTER."
HOMEPAGE="http://www.taxbird.de/"
SRC_URI="http://www.taxbird.de/tmp/${MY_P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-libs/openssl
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/xmlsec
	net-libs/xulrunner
	sys-libs/zlib
	dev-lang/swig"

src_compile() {
	econf || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed!"
	dodoc README
}
