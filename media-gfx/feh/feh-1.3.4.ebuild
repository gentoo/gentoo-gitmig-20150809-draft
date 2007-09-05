# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.3.4.ebuild,v 1.11 2007/09/05 20:17:34 vapier Exp $

inherit eutils autotools

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="xinerama"

RDEPEND=">=media-libs/giblib-1.2.4
	>=media-libs/imlib2-1.0.0
	>=media-libs/jpeg-6b-r4
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXext
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f configure.ac
	epatch "${FILESDIR}"/${P}-xinerama.patch
	epatch "${FILESDIR}"/${P}-headers.patch
	sed -i -e "/^docsdir =/s:doc/feh:share/doc/${PF}:" Makefile.am || die
	# the bundled autotool code was generated with automake-1.4
	# but there's no reason to restrict to that version #141427
	eautoreconf
}

src_compile() {
	econf $(use_enable xinerama) || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
