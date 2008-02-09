# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gaul-devel/gaul-devel-0.1849-r1.ebuild,v 1.3 2008/02/09 16:29:09 drac Exp $

inherit autotools

DESCRIPTION="Genetic Algorithm Utility Library"
HOMEPAGE="http://GAUL.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaul/${P}-0.tar.bz2"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="debug slang"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	slang? ( >=sys-libs/slang-2.1.3 )"

S=${WORKDIR}/${P}-0

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-slang2-error.patch
}

src_compile() {
	local myconf
	use slang || myconf="--enable-slang=no"
	if use debug ; then
		myconf="${myconf} --enable-debug=yes --enable-memory-debug=yes"
	else
		myconf="${myconf} --enable-g=no"
	fi
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "Install failed"
	dodoc README
}
