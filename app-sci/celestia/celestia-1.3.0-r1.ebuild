# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/celestia/celestia-1.3.0-r1.ebuild,v 1.7 2004/11/16 08:40:52 phosphan Exp $

inherit flag-o-matic kde-functions

IUSE="kde gnome"

DESCRIPTION="Celestia is a free real-time space simulation that lets you experience our universe in three dimensions"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.shatters.net/celestia"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

# gnome and kde interfaces are exlcusive
DEPEND=">=media-libs/glut-3.7-r2
	virtual/glu
	media-libs/jpeg
	media-libs/libpng
	!kde? ( gnome? ( =x11-libs/gtk+-1.2*
				=gnome-base/gnome-libs-1.4*
				<x11-libs/gtkglarea-1.99.0 ) )
	kde? ( >=kde-base/kdelibs-3.0.5 )"

pkg_setup() {
	# Set up X11 implementation
	X11_IMPLEM_P="$(portageq best_version "${ROOT}" virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"

	einfo	"Please note:"
	einfo	"if you experience problems building celestia with nvidia drivers,"
	einfo	"you can try:"
	einfo	"opengl-update ${X11_IMPLEM}"
	einfo	"emerge celestia"
	einfo	"opengl-update nvidia"
	einfo	""
	einfo	"NOTE: the gnome and kde GUIs are mutually exclusive, kde is"
	einfo	"recommended. If you're getting the wrong one, run either:"
	einfo	"'USE=\"gnome -kde\" emerge celestia' (for the gnome interface)"
	einfo	"or:"
	einfo	"'USE=\"kde\" emerge celestia' (for the kde interface)"
	einfo	"as appropriate."
}

src_compile() {
	local myconf

	filter-flags "-funroll-loops -frerun-loop-opt"
	addwrite ${QTDIR}/etc/settings
	# currently celestia's "gtk support" requires gnome
	if use kde ; then
	    myconf="$myconf --with-kde --without-gtk"
	elif use gnome ; then
	    myconf="--without-kde --with-gtk"
	else
		myconf="--without-kde --without-gtk"
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
