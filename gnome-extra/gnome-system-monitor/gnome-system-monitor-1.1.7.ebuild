# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-1.1.7.ebuild,v 1.2 2002/07/11 06:30:26 drobbins Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="Procman - The Gnome System Monitor"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.0.2
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libgnome-1.110.0
	>=gnome-base/gconf-1.1.8-r1
	>=gnome-base/libgtop-1.90.2-r1
	>=x11-libs/libwnck-0.12
	>=gnome-base/libgnomecanvas-1.112.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	 >=dev-util/intltool-0.17
	 ${RDEPEND}"
	 
src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	# whoa, gconf is no go.
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
		
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	unset CFONG_DISABLE_MAKEFILE_SCHEMA_INSTALL
 	dodoc AUTHORS ChangeLog COPYING HACKING README* INSTALL NEWS TODO
}


pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2"
		for SCHEMA in gnome-system-monitor.schemas ; do
			echo $SCHEMA
			/usr/bin/gconftool-2  --makefile-install-rule /etc/gconf/schemas/${SCHEMA}
		done
	echo ">>> Updating scrollkeper"
	scrollkeeper-update -p /var/lib/scrollkeeper
}


