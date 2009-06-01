# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-2.26.2.0.ebuild,v 1.1 2009/06/01 21:03:22 eva Exp $

EAPI="2"

inherit autotools eutils gnome2 flag-o-matic

DESCRIPTION="A versatile IDE for GNOME"
HOMEPAGE="http://www.anjuta.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug devhelp doc glade graphviz sourceview subversion +symbol-db valgrind test"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.12.10
	>=gnome-base/orbit-2.6
	>=gnome-base/libglade-2.3
	>=gnome-base/libgnome-2.12
	>=gnome-base/libgnomeui-2.12
	>=gnome-base/gconf-2.12
	>=x11-libs/vte-0.13.1
	>=dev-libs/libxml2-2.4.23
	>=dev-libs/gdl-2.26
	>=app-text/gnome-doc-utils-0.3.2
	>=x11-libs/libwnck-2.12
	>=sys-devel/binutils-2.15.92
	>=dev-libs/libunique-1
	symbol-db? (
		gnome-extra/libgda:4
		dev-util/ctags )

	dev-libs/libxslt
	>=dev-lang/perl-5
	sys-devel/autogen

	devhelp? (
		>=dev-util/devhelp-0.22
		>=net-libs/webkit-gtk-1 )
	glade? ( >=dev-util/glade-3.6.0 )
	inherit-graph? ( >=media-gfx/graphviz-2.6.0 )
	sourceview? (
		>=x11-libs/gtk+-2.10
		>=gnome-base/libgnome-2.14
		>=x11-libs/gtksourceview-2.4 )
	subversion? (
		>=dev-util/subversion-1.5.0
		>=net-misc/neon-0.28.2
		>=dev-libs/apr-1
		>=dev-libs/apr-util-1 )
	valgrind? ( dev-util/valgrind )"
DEPEND="${RDEPEND}
	!!dev-libs/gnome-build
	>=sys-devel/gettext-0.14
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.20
	>=app-text/scrollkeeper-0.3.14-r2
	doc? ( >=dev-util/gtk-doc-1.4 )
	test? (
		~app-text/docbook-xml-dtd-4.1.2
		~app-text/docbook-xml-dtd-4.5 )"

DOCS="AUTHORS ChangeLog FUTURE MAINTAINERS README ROADMAP THANKS TODO"

pkg_setup() {
	if ! use symbol-db; then
		elog "You disabled symbol-db which will disallow using projects."
	fi

	G2CONF="${G2CONF}
		--docdir=/usr/share/doc/${PF}
		$(use_enable debug)
		$(use_enable devhelp plugin-devhelp)
		$(use_enable glade plugin-glade)
		$(use_enable valgrind plugin-valgrind)
		$(use_enable sourceview plugin-sourceview)
		$(use_enable !sourceview plugin-scintilla)
		$(use_enable subversion plugin-subversion)
		$(use_enable symbol-db plugin-symbol-db)
		$(use_enable graphviz)" # Toggles inherit-plugin and performance-plugin

	# Conflics wiht -pg in a plugin, bug #266777
	filter-flags -fomit-frame-pointer
}

src_prepare() {
	gnome2_src_prepare

	# Make Symbol DB optional
	epatch "${FILESDIR}/${PN}-2.26.0.0-symbol-db-optional.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	ebeep 1
	elog ""
	elog "Some project templates may require additional development"
	elog "libraries to function correctly. It goes beyond the scope"
	elog "of this ebuild to provide them."
	epause 5
}
