# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/celestia/celestia-1.3.0.ebuild,v 1.1 2003/05/12 06:11:26 george Exp $

inherit flag-o-matic kde-functions

IUSE="gnome"

DESCRIPTION="Celestia is a free real-time space simulation that lets you experience our universe in three dimensions"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.shatters.net/celestia"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

# gnome and kde interfaces are exlcusive; gnome takes precedence
DEPEND=">=media-libs/glut-3.7-r2
	virtual/glu
	media-libs/jpeg
	media-libs/libpng
	gnome? ( =x11-libs/gtk+-1.2*
		<x11-libs/gtkglarea-1.99.0
		=gnome-base/gnome-libs-1.4* )
	!gnome? ( >=kde-base/kdelibs-3.0.5 )"

pkg_setup() {
	einfo	"Please note:"
	einfo	"if you experience problems building celestia with nvidia drivers,"
	einfo	"you can try:"
	einfo	"opengl-update xfree"
	einfo	"emerge celestia"
	einfo	"opengl-update nvidia"
	einfo	"------------"
	einfo	"NOTE: the gnome and kde GUIs are mutually exclusive. If you're getting"
	einfo 	"the wrong one, run either:"
	einfo	"'USE=gnome emerge celestia' (for the gnome interface)"
	einfo	"or:"
	einfo	"'USE=-gnome emerge celestia' (for the kde interface)"
	einfo	"as appropriate."
}

src_compile() {
	local myconf

	filter-flags "-funroll-loops -frerun-loop-opt"

	# currently celestia's "gtk support" requires gnome
	if [ -n "`use gnome`" ]; then
	    myconf="$myconf --with-gtk --without-kde"
	else
	    myconf="--with-kde --without-gtk"
	    # fix for badly written configure script
	    set-kdedir 3
	    set-qtdir 3
	    export kde_widgetdir="$KDEDIR/lib/kde3/plugins/designer"
	fi

	./configure --prefix=/usr ${myconf} || die

	emake all || die
}

src_install() {
	make install prefix=${D}/usr

	dodoc AUTHORS COPYING NEWS README TODO controls.txt
	dohtml manual/*.html manual/*.css
}
