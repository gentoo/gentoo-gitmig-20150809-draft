# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-2.10.1-r1.ebuild,v 1.6 2005/08/26 17:49:39 gustavoz Exp $

inherit eutils gnome2

DESCRIPTION="Essential Gnome Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE="doc esd static"

RDEPEND=">=dev-libs/glib-2.0.3
	>=gnome-base/gconf-2
	>=gnome-base/libbonobo-2
	>=gnome-base/gnome-vfs-2.5.3
	>=dev-libs/popt-1.5
	esd? ( >=media-sound/esound-0.2.26
		>=media-libs/audiofile-0.2.3 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	>=dev-util/pkgconfig-0.17
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} --disable-schemas-install $(use_enable static) \
$(use_enable esd)"

DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch to fix gcc4 compile problem see: bug #85558
	epatch ${FILESDIR}/${PN}-gcc4.patch
	# Adding switch to properly enable/disable esound support. See bug #6920.
	epatch ${FILESDIR}/${P}-esd_switch.patch

	export WANT_AUTOMAKE=1.7
	cp aclocal.m4 old_macros.m4
	einfo "Running aclocal"
	aclocal -I . || die "Aclocal failed"
	einfo "Running autoconf"
	autoconf || die "Autoconf failed"
}

