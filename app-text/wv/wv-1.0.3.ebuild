# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.0.3.ebuild,v 1.1 2004/11/30 23:16:58 foser Exp $

inherit eutils

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://wvware.sourceforge.net"

IUSE="xml2 wmf"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~ia64 ~amd64 ~ppc64"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="sys-libs/zlib
	dev-libs/glib
	media-libs/libpng
	wmf? ( >=media-libs/libwmf-0.2.2 )
	xml2? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {

	econf \
		`use_with xml2 libxml2` \
		`use_with wmf libwmf` \
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
