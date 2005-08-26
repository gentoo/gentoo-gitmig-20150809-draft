# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.10.2.ebuild,v 1.5 2005/08/26 18:49:51 gustavoz Exp $

inherit eutils gnome2

DESCRIPTION="Eye Of Gnome, an image viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE="jpeg"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2.5.90
	>=gnome-base/gnome-vfs-2.5.91
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/libgnomecanvas-2.5.92
	>=gnome-base/libglade-2.3.6
	>=media-libs/libart_lgpl-2.3.16
	dev-libs/popt
	jpeg? ( >=media-libs/libexif-0.5.12
		media-libs/jpeg )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/intltool
	dev-util/pkgconfig"

G2CONF="${G2CONF} $(use_with jpeg libjpeg) $(use_with jpeg libexif)"
USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"

src_unpack() {

	unpack ${A}
	cd ${S}
	# build fix without jpeg support
	epatch ${FILESDIR}/${PN}-2.8.0-jpeg_build.patch

}

src_install() {

	# fix #92920 FIXME
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}
