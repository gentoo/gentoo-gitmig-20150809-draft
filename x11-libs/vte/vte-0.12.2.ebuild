# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.12.2.ebuild,v 1.10 2006/10/20 22:01:50 agriffis Exp $

inherit eutils autotools gnome2

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="debug doc opengl python"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=x11-libs/pango-1.1
	>=media-libs/freetype-2.0.2
	media-libs/fontconfig
	sys-libs/ncurses
	python? (
		>=dev-python/pygtk-2.4
		>=dev-lang/python-2.2 )
	opengl? (
		virtual/opengl
		virtual/glu )
	|| ( x11-libs/libX11 virtual/x11 )
	virtual/xft"

# No need to specify gettext. See bug #134436.
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.0 )
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.31"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README"


pkg_setup() {
	G2CONF="$(use_enable debug debugging) \
		$(use_enable python) \
		$(use_with opengl glX) \
		--with-xft2
		--with-pangox"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Resolve all symbols at execution time for gnome-pty-helper. See bug
	# #91617.
	epatch "${FILESDIR}"/${PN}-no_lazy_bindings.patch

	# Allow compilation on systems without gettext (bug #134436).
	epatch "${FILESDIR}"/${PN}-0.12-nonls.patch

	cd "${S}/gnome-pty-helper"
	eautoreconf || die "eautoreconf failed"
}
