# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gst-editor/gst-editor-0.5.0.ebuild,v 1.1 2003/03/20 12:49:35 lu_zero Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GStreamer graphical pipeline editor"
#SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
SRC_URI="http://www.gstreamer.net/releases/${PN}/${PV}/src/${P}.tar.gz"
HOMEPAGE="http://www.gstreamer.net/apps/gst-editor/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/gstreamer-0.4.1
	>=x11-libs/gtk+-2
    >=gnome-base/libgnomeui-2
    >=gnome-base/libbonoboui-2
    >=gnome-base/libglade-2
    >=gnome-base/ORBit2-2
    >=x11-libs/pango-1
    >=dev-libs/atk-1
    >=gnome-base/gnome-vfs-2
    dev-libs/libxml2
    net-libs/linc
    media-libs/libart_lgpl
    >=media-libs/freetype-2
	>=gnome-base/libgnomecanvas-2
	app-text/scrollkeeper
	>=gnome-base/gconf-1.2.0"

src_compile() {
	econf || die "Configuration failed"
	emake || die "Compilation failed"
}
src_install () {
	einstall || die	"Installation failed"
	
	dodoc AUTHORS COPYING ChangeLog HACKING IDEAS NEWS README RELEASE TODO 
}

pkg_postinst () {
	einfo "Updating Scrollkeeper"
	scrollkeeper-update
}
