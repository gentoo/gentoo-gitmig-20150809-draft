# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.4.1.ebuild,v 1.8 2010/07/07 18:20:15 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="https://derf.homelinux.org/~derf/projects/feh/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc"
IUSE="xinerama"

COMMON_DEPEND="x11-libs/libX11
	media-libs/libpng
	media-libs/imlib2
	>=media-libs/giblib-1.2.4
	xinerama? ( x11-libs/libXinerama
		x11-libs/libXext )"
RDEPEND="${COMMON_DEPEND}
	media-libs/jpeg:0"
DEPEND="${COMMON_DEPEND}
	x11-libs/libXt
	x11-proto/xproto"

src_prepare() {
	mv -vf configure.in configure.ac
	sed -i -e "/^docsdir =/s:doc/feh:share/doc/${PF}:" Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable xinerama)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
