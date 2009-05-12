# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gramofile/gramofile-1.6.ebuild,v 1.19 2009/05/12 20:10:24 ssuominen Exp $

inherit eutils

DESCRIPTION="Transfer sound from gramophone records to CD"
HOMEPAGE="http://www.opensourcepartners.nl/~costar/gramofile/"
SRC_URI="http://www.opensourcepartners.nl/~costar/${PN}/${P}.tar.gz
	http://www.opensourcepartners.nl/~costar/${PN}/tappin3a.patch
	http://www.opensourcepartners.nl/~costar/${PN}/tappin3b.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	=sci-libs/fftw-2*"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/tappin3a.patch
	epatch "${DISTDIR}"/tappin3b.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin gramofile bplay_gramo brec_gramo || die "dobin failed"
	dodoc ChangeLog README TODO *.txt
}
