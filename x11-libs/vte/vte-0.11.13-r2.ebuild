# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.11.13-r2.ebuild,v 1.7 2005/08/08 15:04:23 corsair Exp $

inherit eutils gnome2

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="debug doc python static"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.2
	>=x11-libs/pango-1.1
	>=media-libs/freetype-2.0.2
	media-libs/fontconfig
	sys-libs/ncurses
	python? ( >=dev-python/pygtk-2.4
		>=dev-lang/python-2.2 )
	virtual/x11"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING NEWS README"
G2CONF="${G2CONF} $(use_enable debug debugging) $(use_enable python) \
$(use_enable static)"

src_unpack() {
	unpack ${A}
	cd ${S}/src

	# Apply the, shift-<up,down> scroll one
	# line at a time patch.
	epatch ${FILESDIR}/${PN}-line-scroll.patch

	cd ${S}
	# Reduce memory use. See bug #96702.
	epatch ${FILESDIR}/${P}-memory_fix.patch
	# Resolve all symbols at execution time for gnome-pty-helper. See bug
	# #91617.
	epatch ${FILESDIR}/${PN}-no_lazy_bindings.patch

	cd gnome-pty-helper
	WANT_AUTOMAKE=1.9
	einfo "Running aclocal"
	aclocal || die "Aclocal failed"
	einfo "Running automake"
	automake || die "Automake failed"
}
