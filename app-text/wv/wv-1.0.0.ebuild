# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.0.0.ebuild,v 1.5 2004/01/07 14:48:22 gustavoz Exp $

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://www.wvware.com"

IUSE="xml2"
KEYWORDS="x86 ~ppc sparc hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-libs/zlib
	media-libs/libpng
	>=media-libs/libwmf-0.2.2
	xml2? ( dev-libs/libxml2 )"

src_compile() {

	econf \
		`use_with xml2 libxml2` \
		--with-docdir=/usr/share/doc/${PF} \
		|| die

	make || die

}

src_install () {

	einstall

	insinto /usr/include
	doins wvinternal.h

	rm -f ${D}/usr/share/man/man1/wvConvert.1
	dosym  /usr/share/man/man1/wvWare.1 /usr/share/man/man1/wvConvert.1

}
