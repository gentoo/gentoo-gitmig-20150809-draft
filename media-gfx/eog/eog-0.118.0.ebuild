# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-0.118.0.ebuild,v 1.1 2002/05/23 19:15:18 spider Exp $

 
# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="the Eye Of Gnome - Image Viewer and Cataloger for Gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.8
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/libxml2-2.4.17
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/bonobo-activation-0.9.5
	>=gnome-base/libgnomecanvas-1.113.0
	>=gnome-extra/libgnomeprint-1.111.0
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

src_compile() {
	libtoolize --copy --force
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--enable-platform-gnome-2 \
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
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS HACKING  DEPENDS THANKS  TODO 
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	for SCHEMA in eog.schemas ; do
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
	scrollkeeper-update -p /var/lib/scrollkeeper
}

