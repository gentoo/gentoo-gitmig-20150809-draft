# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/redhat-artwork/redhat-artwork-0.241.ebuild,v 1.1 2006/04/14 16:18:42 nelchael Exp $

inherit eutils rpm versionator kde-functions

MY_PV="${PV}-1"
DESCRIPTION="RedHat's Bluecurve theme for GTK1, GTK2, KDE, GDM, Metacity and Nautilus"
HOMEPAGE="http://www.redhat.com"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/${PN}-${MY_PV}.src.rpm"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="gtk kde xmms"

RDEPEND=">=x11-libs/gtk+-2.0
	gtk? ( >=media-libs/gdk-pixbuf-0.2.5
	       =x11-libs/gtk+-1.2* )
	kde? ( || ( ( kde-base/kcontrol kde-base/kwin )
	            kde-base/kdebase ) )"

DEPEND="${RDEPEND}
	media-gfx/icon-slicer
	dev-util/intltool
	|| ( x11-apps/xcursorgen virtual/x11 )"

MY_SV=$(get_version_component_range 1-2)
S=${WORKDIR}/${PN}-${MY_SV}

src_compile() {

	if use kde; then
		set-qtdir 3
		set-kdedir 3
	fi

	# dies if LANG has UTF-8
	export LANG=C
	export LC_ALL=C

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.8

	rm -f configure
	sed -i -e "s|.*MCOPIDL.*||" \
	       -e "s|.*ARTSCCONFIG.*||" \
		acinclude.m4

	if ! use kde; then
		sed -i -e "s|KDE_SET_PREFIX||" \
		       -e "s|KDE_CHECK_FINAL||" \
		       -e "s|dnl KDE_USE_QT||" \
		       -e "s|AC_PATH_KDE||" \
		       -e "s|art/kde/Makefile||" \
		       -e "s|art/kde/kwin/Makefile||" \
		       -e "s|art/kde/kwin/Bluecurve/Makefile||" \
			configure.in

		sed -i -e "s|kde||" \
		       -e "s|qt||" \
			art/Makefile.am
	fi

	if ! use gtk; then
		sed -i -e "s|AM_PATH_GTK(1.2.9, ,||" \
		       -e "s|AC_MSG_ERROR(.*GTK+-1.*||" \
		       -e "s|AC_CHECK_LIB(gtk, gtk_style_set_prop_experimental, :,||" \
		       -e "s|AC_MSG_ERROR(.*gtk_style.*||" \
		       -e "s|             \$GTK_LIBS)||" \
		       -e "s|AM_PATH_GDK_PIXBUF||" \
		       -e "s|art/gtk/Bluecurve1/Makefile||" \
		       -e "s|art/gtk/Bluecurve1/gtk/Makefile||" \
			configure.in

		sed -i -e "s|Bluecurve1||" \
			art/gtk/Makefile.am
	fi

	sed -i -e 's| $(datadir)| $(DESTDIR)$(datadir)|' \
		art/cursor/Bluecurve/Makefile.am \
		art/cursor/Bluecurve-inverse/Makefile.am \
		art/cursor/LBluecurve/Makefile.am \
		art/cursor/LBluecurve-inverse/Makefile.am \
		art/icon/Makefile.am \
		art/icon/Bluecurve/sheets/Makefile.am || die

	autoreconf --force --install || die "autoreconf failed"
	intltoolize --force

	sed -i -e "s|GtkStyle|4|" art/qt/Bluecurve/bluecurve.cpp || die

	econf || die
	emake QTDIR="${QTDIR}" styledir="${QTDIR}/plugins/styles" || die

}

src_install () {

	# dies if LANG has UTF-8
	export LANG=C
	export LC_ALL=C

	make QTDIR="${QTDIR}" styledir="${QTDIR}/plugins/styles" \
	     DESTDIR="${D}" install || die

	# yank redhat logos (registered trademarks, etc)
	rm -f ${D}/usr/share/gdm/themes/Bluecurve/rh_logo-header.png
	rm -f ${D}/usr/share/gdm/themes/Bluecurve/screenshot.png

	cd ${D}/usr/share/gdm/themes/Bluecurve/

	# replace redhat logo with gnome logo from happygnome theme
	sed -i -e 's|<normal file="rh_logo-header.png"/>|<normal file="/usr/share/gdm/themes/happygnome/gnome-logo.png"/>|' \
	       -e 's|<pos x="3%" y="5%" width="398" height="128" anchor="nw"/>|<pos x="3%" y="3%"/>|' \
		Bluecurve.xml || die

	# Bluecurve GDM screenshot has redhat logo
	# Theme copyright notice left intact... do not modify it
	sed -i -e 's|Screenshot=|#Screenshot=|' GdmGreeterTheme.desktop

	X11_IMPLEM="xorg-x11"

	for x in Bluecurve Bluecurve-inverse; do
		dodir /usr/share/cursors/${X11_IMPLEM}/${x}
		mv ${D}/usr/share/icons/${x}/cursors ${D}/usr/share/cursors/${X11_IMPLEM}/${x}
		dosym /usr/share/cursors/${X11_IMPLEM}/${x}/cursors /usr/share/icons/${x}/cursors
	done

	# remove xmms skin if unneeded
	use xmms || rm -rf "${D}/usr/share/xmms"

	cd ${S}
	dodoc AUTHORS NEWS README ChangeLog

}
