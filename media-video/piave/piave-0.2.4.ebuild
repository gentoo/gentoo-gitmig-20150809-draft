# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/piave/piave-0.2.4.ebuild,v 1.6 2006/08/28 22:42:19 mr_bones_ Exp $

DESCRIPTION="PIAVE - Piave Is A Video Editor"
HOMEPAGE="http://modesto.sourceforge.net/piave/index.html"
SRC_URI="mirror://sourceforge/modesto/${P}.tar.gz"

IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

RDEPEND=">=dev-libs/libxml2-2.5.11
	>=dev-cpp/libxmlpp-0.21.0
	>=dev-libs/glib-1.2.10-r5
	>=media-libs/libsndfile-1.0.11
	>=media-libs/gdk-pixbuf-0.22.0
	>=media-libs/libsdl-1.2.6-r2
	>=media-libs/sdl-image-1.2.3
	<=media-libs/libdv-0.102
	>=media-libs/libsndfile-1.0.5
	>=media-libs/libvorbis-1.0.1
	>=sys-libs/libraw1394-0.9.0
	>=sys-libs/libavc1394-0.4.1
	media-libs/nas
	|| ( (
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXext
	    ) virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15.0"

src_compile() {
	cd ${S}

	`use_enable nls` \
	myconf=${myconf}" --with-gnu-ld"
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
#	sed -i -e /^mkinstalldirs/s/$.*\`/'..\/mkinstalldirs'/ po/Makefile || die
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
