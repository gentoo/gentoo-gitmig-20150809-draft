# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gaul-devel/gaul-devel-0.1849-r2.ebuild,v 1.1 2010/02/13 16:42:19 jlec Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Genetic Algorithm Utility Library"
HOMEPAGE="http://GAUL.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaul/${P}-0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug slang"

DEPEND=">=sys-apps/sed-4
	slang? ( >=sys-libs/slang-2.1.3 )"

S=${WORKDIR}/${P}-0

src_prepare() {
	epatch "${FILESDIR}"/${P}-slang2-error.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_configure() {
	local myconf
	use slang || myconf="--enable-slang=no"
	if use debug ; then
		myconf="${myconf} --enable-debug=yes --enable-memory-debug=yes"
	else
		myconf="${myconf} --enable-g=no"
	fi
	econf ${myconf}
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc README || die
}
