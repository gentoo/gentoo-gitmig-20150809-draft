# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/redhat-artwork/redhat-artwork-0.120.1.2.ebuild,v 1.8 2005/04/03 21:35:38 greg_g Exp $

inherit eutils rpm libtool versionator kde-functions

MY_PV=$(replace_version_separator 2 '-')
DESCRIPTION="RedHat's Bluecurve theme for GTK1, GTK2, KDE3, GDM, Metacity and Nautilus"
HOMEPAGE="http://www.redhat.com"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/${PN}-${MY_PV}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64"
IUSE="gtk kde xmms"

# Needed to build...
DEPEND="sys-devel/autoconf
	sys-devel/automake
	media-gfx/icon-slicer
	>=x11-libs/gtk+-2.0
	gtk? (  >=media-libs/gdk-pixbuf-0.2.5
		=x11-libs/gtk+-1.2* )
	kde? (	|| ( kde-base/kcontrol kde-base/kdebase )
		|| ( kde-base/kwin kde-base/kdebase ) )
	dev-util/intltool"

# Because one may only want to use the theme with kde OR gtk OR Metacity
# OR gdm, we don't want either as run-time dependencies...
RDEPEND="virtual/x11"

MY_SV=$(get_version_component_range 1-2)
S=${WORKDIR}/${PN}-${MY_SV}

# We need to change some RedHat-specific stuff to Gentoo-style...
_replace() {
	FROM=$1
	TO=$2

	for FILE in $(fgrep -r -l "${FROM}" *); do
		echo -n Changing \"${FROM}\" to \"${TO}\" in ${FILE}...
		sed "s:${FROM}:${TO}:g" < "${FILE}" > "${FILE}.$$"
		mv "${FILE}.$$" "${FILE}"
		echo Done.
	done
}

src_compile() {
	if use kde; then
		set-qtdir 3
		set-kdedir 3
	fi

	# dies is LANG has UTF-8
	export LANG=C
	export LC_ALL=C

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.8

	rm configure
	sed -i -e "s|.*MCOPIDL.*||" \
	       -e "s|.*ARTSCCONFIG.*||" \
		acinclude.m4

	if ! use kde; then
		sed -i -e "s|dnl KDE_USE_QT||" \
		       -e "s|KDE_SET_PREFIX||" \
		       -e "s|KDE_CHECK_FINAL||" \
		       -e "s|AC_PATH_KDE||" \
		       -e "s|art/kde/Makefile||" \
		       -e "s|art/kde/kwin/Makefile||" \
		       -e "s|art/kde/kwin/Bluecurve/Makefile||" \
			configure.in

		sed -i -e "s|kde||" \
		       -e "s|qt||" \
			art/Makefile.am

		sed -i -e "s|kde||" \
		       -e "s|qt||" \
			art/Makefile.in
	fi

	# disable gtk 1.x support if gtk use keyword is not set
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

	autoreconf --force --install || die "autoreconf failed"

	# paths have to be fixed for kde
	if ! use kde; then
		# Fix paths...
		_replace "/usr/lib/qt3"          "${QTDIR}"
		_replace '${libdir}/qt3'         "${QTDIR}"
		_replace '$(libdir)/qt3'         "${QTDIR}"
		_replace "/usr/lib/kde3"         "${KDEDIR}/lib"
		_replace '${libdir}/kde3'        "${KDEDIR}/lib"
		_replace "/usr/lib/kwin.la"      "${KDEDIR}/lib/kwin.la"
		chmod +x configure
	fi

	# fix iconrc
	#mv art/gtk/make-iconrc.pl art/gtk/make-iconrc.pl.broken
	#sed 's|$ARGV\[3\]|\"/usr/share/icons/Bluecurve\"|' \
	#	art/gtk/make-iconrc.pl.broken >  art/gtk/make-iconrc.pl
	#chmod +x art/gtk/make-iconrc.pl

	./configure || die
	emake || die
}

src_install () {
	# dies is LANG has UTF-8
	export LANG=C
	export LC_ALL=C

	make prefix=${D}/usr kde_moduledir=${D}/usr/lib \
	styledir=${D}/usr/lib/kde3/plugins/styles \
	settingsdir=${D}/${QTDIR}/etc/settings install || die

	# yank redhat logos (registered trademarks, etc)
	rm -f ${D}/usr/share/gdm/themes/Bluecurve/rh_logo-header.png
	rm -f ${D}/usr/share/gdm/themes/Bluecurve/screenshot.png

	cd ${D}/usr/share/gdm/themes/Bluecurve/

	# replace redhat logo with gnome logo from happygnome theme
	sed -e 's|<normal file="rh_logo-header.png" />|<normal file="/usr/share/gdm/themes/happygnome/gnome-logo.png"/>|' \
		-e 's|<pos x="3%" y="5%" width="398" height="128" anchor="nw"/>|<pos x="3%" y="3%"/>|' \
		Bluecurve.xml > Bluecurve.xml.mod || die

	mv Bluecurve.xml.mod Bluecurve.xml

	# Bluecurve GDM screenshot has redhat logo
	# Theme copyright notice left intact... do not modify it
	sed -e 's|Screenshot=|#Screenshot=|' GdmGreeterTheme.desktop > GdmGreeterTheme.desktop.mod
	mv GdmGreeterTheme.desktop.mod GdmGreeterTheme.desktop

	# move cursors to /usr/share/cursors/${X11_IMPL}
	X11_IMPLEM_P="$(best_version virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"

	for x in Bluecurve Bluecurve-inverse; do
		dodir /usr/share/cursors/${X11_IMPLEM}/${x}
		mv ${D}/usr/share/icons/${x}/cursors ${D}/usr/share/cursors/${X11_IMPLEM}/${x}
		dosym /usr/share/cursors/${X11_IMPLEM}/${x}/cursors /usr/share/icons/${x}/cursors
	done

	# remove xmms skin if unneeded
	use xmms || rm -rf ${D}/usr/share/xmms

	cd ${S}
	dodoc AUTHORS NEWS README ChangeLog
}
