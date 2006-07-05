# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.0.0-r1.ebuild,v 1.6 2006/07/05 07:35:16 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://wvware.sourceforge.net"

IUSE="xml wmf"
KEYWORDS="x86 ppc sparc hppa alpha ia64 amd64 ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-libs/zlib
	media-libs/libpng
	wmf? ( >=media-libs/libwmf-0.2.2 )
	xml? ( dev-libs/libxml2 )"

src_unpack() {

	unpack ${A}

	# Fix vulnerability (#56595)
	epatch ${FILESDIR}/${P}-fix_overflow.patch

}

src_compile() {

	econf \
		`use_with xml libxml2` \
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
