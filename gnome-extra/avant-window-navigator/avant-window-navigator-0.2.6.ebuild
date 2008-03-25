# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.2.6.ebuild,v 1.1 2008/03/25 20:17:27 wltjr Exp $

inherit gnome2 autotools

DESCRIPTION="Fully customisable dock-like window navigator."
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PV%.*}/${PV}/+download/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
# vala is not in tree yet
#IUSE="gconf gnome vala xfce"
IUSE="gconf gnome xfce"

# Replace gnome-vfs with gvfs when unmasked
#		gnome-base/gvfs

DEPEND="
	dev-util/gtk-doc
	x11-libs/gtk+
	x11-libs/libwnck
	gconf? ( gnome-base/gconf )
	gnome? (
		gnome-base/gnome-desktop
		gnome-base/gnome-vfs
		gnome-base/libgnome
	)
	xfce? ( xfce-base/thunar )
	!gnome? ( !xfce? ( >=dev-libs/glib-2.15.0 ) )"

RDEPEND="${DEPEND}
	dev-python/pyxdg"
# vala is not in tree yet
#	vala? ( dev-lang/vala )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gtkdocize || die "gtkdocsize failed"
	eautoreconf || die "eautoreconf failed"
	intltoolize --copy --force || die "intltoolize failed"
}

src_compile() {
	local myconf

	# These are alternatives so it won't work with use_with
	if use gnome; then myconf="--with-desktop=gnome"
	elif use xfce; then myconf="--with-desktop=xfce4"
	else myconf="--with-desktop=agnostic"
	fi

	econf ${myconf} \
		$(use_enable gconf) \
		$(use_enable vala) \
		|| die "econf failed"

	emake || die "emake failed"
}
