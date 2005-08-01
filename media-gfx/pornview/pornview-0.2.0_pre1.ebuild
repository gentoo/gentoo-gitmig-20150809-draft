# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.2.0_pre1.ebuild,v 1.14 2005/08/01 20:56:27 sekretarz Exp $

inherit eutils

IUSE="gtk2 jpeg mplayer nls static xine"

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	mplayer? ( media-video/mplayer )
	jpeg? ( media-libs/jpeg )
	gtk2? ( >=x11-libs/gtk+-2.0 )
	!gtk2? ( =x11-libs/gtk+-1.2*
		>=media-libs/gdk-pixbuf-0.16 )
	xine? ( =media-libs/xine-lib-1* )
	nls? ( sys-devel/gettext )"

SLOT="0"
KEYWORDS="x86 ppc amd64"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"
RESTRICT="nomirror"

S="${WORKDIR}/${P/_/}"

src_compile() {
	local myflags="--with-gnu-ld"
	# --with-normal-paned     Use standard gtk+ paned

	# This is considered experimental but appears to work fine
	use gtk2 && myflags="${myflags} --with-gtk2"

	use jpeg || myflags="${myflags} --disable-exif"

	# mplayer and xine movie support cannot be installed at the same
	# time so prefer xine support over mplayer if both are available
	if use xine; then
		myflags="${myflags} --enable-xine"
	elif use mplayer; then
		myflags="${myflags} --disable-xinetest --enable-mplayer"
	else
		myflags="${myflags} --disable-xinetest"
	fi

	use nls || myflags="${myflags} --disable-nls"

	use static && myflags="${myflags} --enable-static"

	epatch ${FILESDIR}/${P}-4.diff || die
	epatch ${FILESDIR}/gtkxine.diff || die

	econf ${myflags} || die "./configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README
}
