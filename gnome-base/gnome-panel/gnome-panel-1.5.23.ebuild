# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="The Panel for Gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 FDL-1.1 LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-util/intltool-0.17
	>=dev-libs/libxml2-2.4.22
	>=dev-libs/atk-1.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-0.9.9
	>=gnome-base/gconf-1.1.10
	>=gnome-base/gnome-vfs-1.9.11
	>=media-libs/libart_lgpl-2.3.8
	>=gnome-base/libbonobo-1.117.0
	>=gnome-base/libbonoboui-1.117.0
	>=gnome-base/libglade-1.99.10
	>=gnome-base/libgnome-1.117.0
	>=gnome-base/libgnomecanvas-1.117.0
	>=gnome-base/libgnomeui-1.117.0
	>=x11-libs/libwnck-0.7
	>=net-libs/linc-0.5.0
	>=media-libs/audiofile-0.2.3
	>=sys-libs/zlib-1.1.4
	>=gnome-base/gnome-desktop-1.5.21
	>=app-text/scrollkeeper-0.3.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"
	
src_compile() {
	# heh, we are a bit quick here.. timezones
	find . -exec touch "{}" \;
	libtoolize --copy --force
	local myflags
	use doc && myflags="--enable-gtk-doc" || myflags="--disable-gtk-doc"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		${myflags} \
		--enable-debug=yes || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		localstatedir=/var/lib \
		scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ \
		install || die
    	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
 	dodoc AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS  README* 
}


pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2 (panel)" 
	for SCHEMA in clock.schemas panel-global-config.schemas panel-per-panel-config.schemas mailcheck.schemas pager.schemas tasklist.schemas fish.schemas ; do
		echo ${SCHEMA}
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
		echo ">>> attempting to update scrollkeeper"
		scrollkeeper-update -p /var/lib/scrollkeeper
}
					





