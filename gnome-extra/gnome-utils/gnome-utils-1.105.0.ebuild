# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-1.105.0.ebuild,v 1.1 2002/05/22 22:27:09 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Utilities for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/atk-1.0.0
	>=x11-libs/gtk+-2.0.0
	>=app-text/scrollkeeper-0.3.4
	=media-libs/freetype-2.0*
	>=x11-libs/libzvt-1.112.0
	>=gnome-base/libglade-1.99.10
	>=gnome-base/gconf-1.1.9
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/gnome-panel-1.5.21
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/ORBit2-2.3.106
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/libgnomecanvas-1.112.1
	>=gnome-base/bonobo-activation-0.9.5
	>=gnome-extra/libgtkhtml-1.99.3
	>=dev-libs/libxml2-2.4.17
	>=sys-libs/ncurses-5.2-r3
	>=gnome-base/libgtop-1.90.2-r1"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"
	
src_compile() {
	libtoolize --copy --force
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--disable-guname-capplet \
		--enable-gcolorsel-applet \
		--with-ncurses \
		--enable-debug=yes || die "configure failure"
	emake || die "compile failure"
}

src_install() {
	# whoa, gconf is no go.
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL    
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS  README* THANKS
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> Gconf2 update"
	for SCHEMA in gdict.schemas gcharmap.schemas ; do
		echo $SCHEMA
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
	echo ">>> Scrollkeeper-update"
	scrollkeeper-update -vp /var/lib/scrollkeeper
}
		
