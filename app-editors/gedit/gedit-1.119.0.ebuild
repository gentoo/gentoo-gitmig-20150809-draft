# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-1.119.0.ebuild,v 1.1 2002/05/23 00:36:45 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="A text editor for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}2/${PN}2-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/pango-1.0.0
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.8
	>=gnome-base/libglade-1.99.10
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/ORBit2-2.3.106
	>=gnome-extra/libgnomeprintui-1.113.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

	
src_compile() {
	libtoolize --copy --force || die "libtool failed!" 
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--enable-debug=yes || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL    
		
	dodoc AUTHORS BUGS ChangeLog COPYING FAQ INSTALL NEWS  README*  THANKS TODO
}




pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	for SCHEMA in gedit.schemas ; do
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
	scrollkeeper-update -p /var/lib/scrollkeeper
}

