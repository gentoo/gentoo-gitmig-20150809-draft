# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.0.0.ebuild,v 1.5 2002/07/25 04:47:22 spider Exp $

inherit libtool

# disabling debug now
# inherit debug


S=${WORKDIR}/${P}
DESCRIPTION="Utilities for the Gnome2 desktop"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/pango-1.0.3
	>=dev-libs/atk-1.0.2
	>=x11-libs/gtk+-2.0.5
	>=app-text/scrollkeeper-0.3.4
	=media-libs/freetype-2.0*
	>=x11-libs/libzvt-1.99999.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/gnome-panel-2.0.1
	>=gnome-base/gnome-vfs-2.0.0
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/bonobo-activation-1.0.0-r1
	>=gnome-extra/libgtkhtml-2.0.0
	>=dev-libs/libxml2-2.4.22
	>=sys-libs/ncurses-5.2-r5
	>=gnome-base/libgtop-2.0.0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"
	
src_compile() {
	elibtoolize
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
		
