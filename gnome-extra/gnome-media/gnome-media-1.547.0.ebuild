# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-1.547.0.ebuild,v 1.1 2002/05/22 22:19:39 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Multimedia related programs for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/ http://www.prettypeople.org/~iain/gnome-media/"
LICENSE="GPL-2 FDL-1.1"
SLOT="2"


RDEPEND=">=media-sound/esound-0.2.25
	>=dev-libs/glib-2.0.0
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/gconf-1.1.8-r1
	>=gnome-base/ORBit2-2.3.106
	>=gnome-base/libbonobo-1.112.0-r1
	>=gnome-base/bonobo-activation-0.9.5
	>=app-text/scrollkeeper-0.3.4
	>=gnome-base/gail-0.9"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	${RDEPEND}"

src_compile() {
	libtoolize --copy --force
	local myopts
	myopts=""
# 	use alsa &&  myopts="$myopts --enable-alsa=yes" || myopts="$myopts --enable-alsa=no"
# this breaks with alsa 0.9

	./configure --host=${CHOST} \
		${myopts} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc AUTHORS COPYING COPYING-DOCS  ChangeLog INSTALL NEWS README  TODO
}


pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> Gconf2 update"
	for SCHEMA in CDDB-Slave2.schemas gnome-cd.schemas gnome-sound-recorder.schemas gnome-volume-control.schemas ; do
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
	scrollkeeper-update -p /var/lib/scrollkeeper
}
