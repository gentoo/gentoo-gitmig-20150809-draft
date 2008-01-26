# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzma-utils/lzma-utils-4.32.4.ebuild,v 1.3 2008/01/26 06:29:56 vapier Exp $

inherit eutils

DESCRIPTION="LZMA interface made easy"
HOMEPAGE="http://tukaani.org/lzma/"
SRC_URI="http://tukaani.org/lzma/lzma-${PV/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="!app-arch/lzma"

S=${WORKDIR}/lzma-${PV/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch #207338
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
