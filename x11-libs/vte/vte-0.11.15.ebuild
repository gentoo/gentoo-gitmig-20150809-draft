# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.11.15.ebuild,v 1.1 2005/08/26 12:19:30 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc python static"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.2
	>=x11-libs/pango-1.1
	>=media-libs/freetype-2.0.2
	media-libs/fontconfig
	sys-libs/ncurses
	python? (
		>=dev-python/pygtk-2.4
		>=dev-lang/python-2.2 )
	virtual/x11"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog HACKING NEWS README"


pkg_setup() {
	G2CONF="$(use_enable debug debugging) $(use_enable python) \
		$(use_enable static)"
}

src_unpack() {
	unpack "${A}"
	cd "${S}/src"

	# Apply the, shift-<up,down> scroll one
	# line at a time patch.
	epatch ${FILESDIR}/${PN}-line-scroll.patch

	cd "${S}"
	# Resolve all symbols at execution time for gnome-pty-helper. See bug
	# #91617.
	epatch ${FILESDIR}/${PN}-no_lazy_bindings.patch

	cd gnome-pty-helper
	WANT_AUTOMAKE=1.9
	aclocal  || die "aclocal failed"
	automake || die "automake failed"
}
