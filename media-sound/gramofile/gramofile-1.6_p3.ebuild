# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gramofile/gramofile-1.6_p3.ebuild,v 1.1 2007/08/19 08:55:05 drac Exp $

inherit eutils toolchain-funcs

MY_P=${PN}-1.6P

DESCRIPTION="An audio program for analog to digital remastering."
HOMEPAGE="http://www.opensourcepartners.nl/~costar/gramofile"
SRC_URI="http://www.opensourcepartners.nl/~costar/${PN}/${MY_P}.tar.gz
	http://www.opensourcepartners.nl/~costar/${PN}/tappin3a.patch
	http://www.opensourcepartners.nl/~costar/${PN}/tappin3c.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	=sci-libs/fftw-2*"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/tappin3a.patch
	epatch "${DISTDIR}"/tappin3c.patch
	epatch "${FILESDIR}"/${P}-64bit.patch
	epatch "${FILESDIR}"/${P}-implicit-declarations.patch
}

src_compile() {
	# We need the prototype on amd64 or basename defaults to returning int -
	# causint segfault... bug #128378
	sed -i -e "s/-DREDHAT50//" bplaysrc/Makefile

	emake CFLAGS="${CFLAGS} -Wall -DTURBO_MEDIAN -DTURBO_BUFFER" \
		CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	dobin gramofile bplay_gramo brec_gramo
	dodoc ChangeLog README TODO *.txt
}
