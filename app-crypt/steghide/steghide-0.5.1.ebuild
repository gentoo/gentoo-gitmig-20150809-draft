# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/steghide/steghide-0.5.1.ebuild,v 1.13 2010/01/22 16:39:58 ssuominen Exp $

EAPI=1
inherit autotools eutils

DESCRIPTION="A steganography program which hides data in various media files"
HOMEPAGE="http://steghide.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

DEPEND=">=app-crypt/mhash-0.8.18-r1
	>=dev-libs/libmcrypt-2.5.7
	media-libs/jpeg:0
	>=sys-libs/zlib-1.1.4-r2"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_compile() {
	econf $(use_enable debug)
	emake LIBTOOL="$(type -p libtool)" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install \
		|| die "emake install failed."
	prepalldocs
}
