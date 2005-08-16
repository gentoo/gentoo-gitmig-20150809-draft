# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeui/libgnomeui-2.11.2.ebuild,v 1.1 2005/08/16 22:21:59 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="User Interface routines for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc jpeg static"

RDEPEND=">=x11-libs/gtk+-2.6
	>=x11-libs/pango-1.1.2
	>=dev-libs/popt-1.5
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2.7.3
	>=gnome-base/gnome-keyring-0.4
	jpeg? ( media-libs/jpeg )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

PDEPEND="x11-themes/gnome-themes
	x11-themes/gnome-icon-theme"

DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable static) $(use_with jpeg libjpeg)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# cleanliness is ... (#68698)
	epatch ${FILESDIR}/${PN}-2.8.0-ditch_ancient_pics.patch

	# Remove unnecessary esaund/audofile checks and implement the
	# --without-jpeg switch
	epatch ${FILESDIR}/${PN}-2.10.1-gentoo.patch

	export WANT_AUTOMAKE=1.7
	cp aclocal.m4 old_macros.m4
	aclocal -I . || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}
