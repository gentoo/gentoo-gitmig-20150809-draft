# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/unicode-data/unicode-data-5.2.0.ebuild,v 1.4 2008/05/29 21:46:08 welp Exp $

DESCRIPTION="Unicode data from unicode.org"
HOMEPAGE="http://unicode.org/"
SRC_URI="mirror://gentoo/unicode-data-5.2.0.tar.lzma"
LICENSE="unicode"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"
IUSE=""

DEPEND="app-arch/lzma-utils"
RDEPEND=""

src_compile() {
	:
}

src_install() {
	cd "${WORKDIR}"
	dodir /usr/share/
	mv "${S}" "${D}/usr/share/unicode-data" || die "mv failed"
}
