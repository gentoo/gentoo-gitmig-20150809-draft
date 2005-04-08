# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimageview/gimageview-0.2.27-r1.ebuild,v 1.5 2005/04/08 17:22:13 corsair Exp $

inherit eutils

DESCRIPTION="Powerful GTK+ based image & movie viewer"
HOMEPAGE="http://gtkmmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkmmviewer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ppc64"
# mng, xine, and mplayer are local flags
IUSE="gnome nls gtk gtk2 imlib wmf mng svg xine mplayer"

DEPEND="virtual/x11
	media-libs/libpng
	nls?  ( sys-devel/gettext )
	wmf?  ( >=media-libs/libwmf-0.2.8 )
	mng?  ( >=media-libs/libmng-1.0.3 )
	svg?  ( >=gnome-base/librsvg-1.0.3 )
	xine?    ( >=media-libs/xine-lib-0.9.13-r3 )
	mplayer? ( >=media-video/mplayer-0.92 )
	gtk? ( gtk2? ( =x11-libs/gtk+-2* )
		!gtk2? ( =x11-libs/gtk+-1.2* ) )
	!gtk? ( || (
		imlib? ( media-libs/imlib )
		media-libs/gdk-pixbuf
		) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sort_fix.diff
	epatch ${FILESDIR}/${P}-gtk12_fix.diff
}

src_compile() {
	local myconf=""

	if ! use gtk2 && use imlib; then
		myconf="--disable-gdk-pixbuf"
	else
		myconf="--disable-imlib"
	fi

	econf \
		$(use_enable nls) \
		$(use_with wmf libwmf) \
		$(use_with mng libmng) \
		$(use_with svg librsvg) \
		$(use_with xine) \
		$(use_enable mplayer) \
		$(use_with gtk2) \
		${myconf} --enable-splash || die

	emake || die
}

src_install() {
	# make DESTDIR=${D} install doesn't work
	einstall || die
	use gnome || rm -r ${D}/usr/share/gnome/ ${D}/usr/share/pixmaps/
}

pkg_postinst() {
	einfo ""
	einfo "If you want to open archived files, you have to emerge"
	einfo "'app-arch/rar' and/or 'app-arch/lha'."
	einfo "e.g.) # emerge app-arch/rar"
	einfo ""
}
