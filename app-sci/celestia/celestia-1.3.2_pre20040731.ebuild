# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/celestia/celestia-1.3.2_pre20040731.ebuild,v 1.1 2004/08/05 03:54:48 morfic Exp $


inherit eutils flag-o-matic kde-functions

#IUSE="kde gnome"
IUSE="kde"

SNAPSHOT="${PV/*_pre}"
S="${WORKDIR}/${P/_*}"
DESCRIPTION="Celestia is a free real-time space simulation that lets you experience our universe in three dimensions"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI="http://celestia.teyssier.org/download/daily/${PN}-cvs.${SNAPSHOT}.tgz"
HOMEPAGE="http://www.shatters.net/celestia"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~x86"

# gnome and kde interfaces are exlcusive
DEPEND=">=media-libs/glut-3.7-r2
	virtual/glu
	media-libs/jpeg
	media-libs/libpng
	kde? ( >=kde-base/kdelibs-3.0.5 )"
#	!kde? ( gnome? ( =x11-libs/gtk+-1.2*
#				=gnome-base/gnome-libs-1.4*
#				<x11-libs/gtkglarea-1.99.0 ) )

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
	einfo	"------------"
	einfo	"NOTE: the gnome and kde GUIs are mutually exclusive, kde is"
	einfo	"recommended. If you're getting the wrong one, run either:"
	einfo	"'USE=\"gnome -kde\" emerge celestia' (for the gnome interface)"
	einfo	"or:"
	einfo	"'USE=\"kde\" emerge celestia' (for the kde interface)"
	einfo	"as appropriate."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	# the patch didn't apply correcty. Had no time to check if the patch 
	# is no longer necessary
#	epatch ${FILESDIR}/${PN}-1.3.1-gtkmain.patch
	# adding gcc-3.4 support as posted in
	# (http://bugs.gentoo.org/show_bug.cgi?id=53479#c2)
	epatch ${FILESDIR}/resmanager.h.patch || die

	# alright this snapshot seems to have some trouble with installing a 
	# file properly. It wants to install celestia.schemas in / which leads
	# to an ACCESS VIOLATION. Unfortunately this file even gets installed
	# when no gtk/gnome is enabled
	# The following lines prevents this but thinkabout as a dirty hack
	cd ${S}/src/celestia/gtk || die
	sed -i -e 's:GCONF_SCHEMA_FILE_DIR = @GCONF_SCHEMA_FILE_DIR@:GCONF_SCHEMA_FILE_DIR = $(pkgdatadir)/schemas:g' Makefile.in || die
	sed -i -e 's:GCONF_SCHEMA_FILE_DIR = @GCONF_SCHEMA_FILE_DIR@:GCONF_SCHEMA_FILE_DIR = $(pkgdatadir)/schemas:g' data/Makefile.in || die
	cd ${S} || die

}

src_compile() {
	local myconf

	filter-flags "-funroll-loops -frerun-loop-opt"
	addwrite ${QTDIR}/etc/settings
	# currently celestia's "gtk support" requires gnome
	if  use kde ; then
	    myconf="$myconf --with-kde --without-gtk"
#	elif  use gnome ; then
#	    myconf="--without-kde --with-gtk"
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

	# removed NEWS as it is not included in this snapshot
	dodoc AUTHORS COPYING README TODO controls.txt
	dohtml manual/*.html manual/*.css
}
