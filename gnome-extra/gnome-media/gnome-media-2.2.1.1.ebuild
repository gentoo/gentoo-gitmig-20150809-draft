# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.2.1.1.ebuild,v 1.4 2003/03/01 14:45:24 weeve Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Multimedia related programs for the Gnome2 desktop"
HOMEPAGE="http://www.prettypeople.org/~iain/gnome-media/"
LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="x86 ~ppc ~sparc"

RDEPEND=">=media-sound/esound-0.2.23
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2
	>=gnome-base/gnome-vfs-2
	dev-libs/libxml2
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libbonobo-2
	>=gnome-base/bonobo-activation-2
	>=gnome-base/gail-0.0.3
	>=media-libs/gstreamer-0.5.2
	>=media-libs/gst-plugins-0.5.2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.21
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"



src_install() {
	[ -x ${ROOT}/bin/wc ] && dodir /var/lib/scrollkeeper
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR=${D} install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
	if [ -n "${DOCS}" ]
		then dodoc ${DOCS}
	fi
	[ -x ${ROOT}/bin/wc ] && [ `ls -al ${D}/var/lib/scrollkeeper | wc -l` -eq 3 ] && \
		rm -rf ${D}/var/lib/scrollkeeper
		# only update scrollkeeper if this package needs it
	[ ! -d ${D}/var/lib/scrollkeeper ] && SCROLLKEEPER_UPDATE="0"
}
		
