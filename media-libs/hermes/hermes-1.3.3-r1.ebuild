# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hermes/hermes-1.3.3-r1.ebuild,v 1.2 2006/08/20 21:50:16 vapier Exp $

inherit eutils autotools

MY_P=${P/h/H}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Library for fast colorspace conversion and other graphics routines"
HOMEPAGE="http://www.clanlib.org/hermes/"
SRC_URI="http://distro.ibiblio.org/pub/linux/distributions/sorcerer/sources/Hermes/${PV}/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-amd64.patch
	epatch "${FILESDIR}"/${P}-destdir.patch
	eautoreconf
}

src_compile() {
	econf --disable-x86asm || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog FAQ NEWS README TODO*

	dohtml docs/api/*.htm
	docinto print
	dodoc docs/api/*.ps
	docinto txt
	dodoc docs/api/*.txt
	docinto sgml
	dodoc docs/api/sgml/*.sgml
}
