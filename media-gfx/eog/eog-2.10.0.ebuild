# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.10.0.ebuild,v 1.8 2005/08/08 14:56:21 corsair Exp $

inherit gnome2 eutils

DESCRIPTION="Eye Of Gnome, an image viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="jpeg"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2.6
	dev-libs/popt
	>=gnome-base/gnome-vfs-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomecanvas-2.6
	>=gnome-base/libglade-2.4
	>=media-libs/libart_lgpl-2.3.16
	jpeg? ( >=media-libs/libexif-0.5.12
		media-libs/jpeg )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_with jpeg libjpeg) $(use_with jpeg libexif)"
USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog README NEWS HACKING THANKS TODO"

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
