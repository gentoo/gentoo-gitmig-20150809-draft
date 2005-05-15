# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/piave/piave-0.2.4-r1.ebuild,v 1.7 2005/05/15 13:53:12 flameeyes Exp $

inherit eutils

DESCRIPTION="PIAVE - Piave Is A Video Editor"
HOMEPAGE="http://modesto.sourceforge.net/piave/index.html"
SRC_URI="mirror://sourceforge/modesto/${P}.tar.gz"

IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND="virtual/x11
	>=dev-libs/libxml2-2.5.11
	>=dev-cpp/libxmlpp-0.21.0
	>=media-libs/gdk-pixbuf-0.22.0
	>=media-libs/libsdl-1.2.6-r2
	>=media-libs/sdl-image-1.2.3
	<=media-libs/libdv-0.102
	>=media-libs/libsndfile-1.0.5
	>=media-libs/libvorbis-1.0.1
	>=sys-libs/libraw1394-0.9.0
	>=sys-libs/libavc1394-0.4.1
	media-libs/nas"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15.0"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/piave-0.2.4-include-arts.diff
	epatch ${FILESDIR}/piave-0.2.4-gcc34.patch
}

src_compile() {
	econf \
		$(use_enable nls) \
		|| die "configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
