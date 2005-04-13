# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast/beast-0.6.5.ebuild,v 1.1 2005/04/13 20:18:47 luckyduck Exp $

inherit eutils

IUSE="debug mad static"

DESCRIPTION="BEAST - the Bedevilled Sound Engine"
HOMEPAGE="http://beast.gtk.org"
SRC_URI="ftp://beast.gtk.org/pub/beast/v${PV%.[0-9]}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.4.11
	>=sys-libs/zlib-1.1.3
	>=dev-util/guile-1.6
	>=media-libs/libart_lgpl-2.3.8
	>=gnome-base/libgnomecanvas-2.0
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0
	mad? ( media-sound/madplay )"
DEPEND="dev-util/pkgconfig
	dev-lang/perl
	media-libs/ladspa-cmt
	media-libs/ladspa-sdk
	${RDEPEND}"

src_compile() {
	local myconf="--with-gnu-ld"

	econf ${myconf} \
		$(use_enable debug) \
		$(use_enable static) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
