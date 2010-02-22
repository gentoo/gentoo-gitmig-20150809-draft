# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.3.5.ebuild,v 1.1 2010/02/22 08:24:00 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="https://derf.homelinux.org/~derf/projects/feh/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}.orig.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama"

RDEPEND="!<sci-astronomy/xephem-3.7.3
	>=media-libs/giblib-1.2.4
	>=media-libs/imlib2-1.0.0
	>=media-libs/jpeg-6b:0
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXext
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto"

src_prepare() {
	rm -f configure.ac
	epatch "${FILESDIR}"/${PN}-1.3.4-xinerama.patch \
		"${FILESDIR}"/${PN}-1.3.4-headers.patch
	sed -i -e "/^docsdir =/s:doc/feh:share/doc/${PF}:" Makefile.am || die
	# the bundled autotool code was generated with automake-1.4
	# but there's no reason to restrict to that version #141427
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable xinerama)
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
