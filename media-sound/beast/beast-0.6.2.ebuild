# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast/beast-0.6.2.ebuild,v 1.2 2004/08/03 11:33:39 dholm Exp $

inherit eutils

IUSE="debug mad static"

DESCRIPTION="BEAST - the Bedevilled Sound Engine"
HOMEPAGE="http://beast.gtk.org"
SRC_URI="ftp://beast.gtk.org/pub/beast/v${PV%.[0-9]}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0.0
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

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myconf="--with-gnu-ld"

	use debug || myconf="${myconf} --disable-debug"

	use static || myconf="${myconf} --disable-static"

	econf ${myconf} || die "configure failed"

	emake || die "configure failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
