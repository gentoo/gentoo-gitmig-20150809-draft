# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.2.0_pre1.ebuild,v 1.18 2007/01/19 15:30:46 masterdriverz Exp $

inherit eutils

IUSE="jpeg mplayer nls static xine"

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	mplayer? ( media-video/mplayer )
	jpeg? ( media-libs/jpeg )
	>=x11-libs/gtk+-2.0
	xine? ( =media-libs/xine-lib-1* )
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

SLOT="0"
KEYWORDS="x86 ppc amd64"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"

S="${WORKDIR}/${P/_/}"

src_compile() {
	local myflags
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
