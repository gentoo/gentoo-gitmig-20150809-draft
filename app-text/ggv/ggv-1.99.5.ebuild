# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.99.5.ebuild,v 1.1 2002/05/23 00:25:46 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"



S=${WORKDIR}/${P}
DESCRIPTION="your favourite PostScript previewer"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/ggv/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/libbonoboui-1.113.0
	>=gnome-base/libgnome-1.113.0
	>=gnome-base/ORBit2-2.3.106
	>=gnome-base/libglade-1.99.9"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"

	
src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib/ \
		--disable-install-schemas \
		--enable-platform-gnome-2 \
		${myconf} \
		--enable-debug=yes || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make  prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "install failed"
    unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO* 
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2"
		for SCHEMA in ggv.schemas ; do
			echo $SCHEMA
			/usr/bin/gconftool-2  --makefile-install-rule \
				/etc/gconf/schemas/${SCHEMA}
		done
	echo ">>> Scrollkeeper-update"
		scrollkeeper-update -p /var/lib/scrollkeeper
}
