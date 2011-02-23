# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gtk-vnc/gtk-vnc-0.4.2-r2.ebuild,v 1.2 2011/02/23 23:09:09 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="python? 2:2.4"

inherit base gnome.org python

DESCRIPTION="VNC viewer widget for GTK."
HOMEPAGE="http://live.gnome.org/gtk-vnc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples +introspection python sasl"

# libview is used in examples/gvncviewer -- no need
# TODO: review nsplugin when it will be considered less experimental

RDEPEND=">=dev-libs/glib-2.10:2
	>=net-libs/gnutls-1.4
	>=x11-libs/cairo-1.2
	>=x11-libs/gtk+-2.18:2
	x11-libs/libX11
	introspection? ( >=dev-libs/gobject-introspection-0.9.4 )
	python? ( >=dev-python/pygtk-2:2 )
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-perl/Text-CSV
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-pre-conn-crash-fix.patch
	epatch "${FILESDIR}"/${P}-gnutls-crash-fix.patch
	epatch "${FILESDIR}"/${P}-fb-bounds-fix.patch
	epatch "${FILESDIR}"/${P}-memory-leak-fix.patch
	epatch "${FILESDIR}"/${P}-shared-flag.patch
}

src_configure() {
	econf \
		$(use_with examples) \
		$(use_enable introspection) \
		$(use_with python) \
		$(use_with sasl) \
		--with-coroutine=gthread \
		--without-libview \
		--with-gtk=2.0 \
		--disable-static
}

src_install() {
	# bug #328273
	MAKEOPTS="${MAKEOPTS} -j1" \
		base_src_install
	python_clean_installation_image
	dodoc AUTHORS ChangeLog NEWS README || die
}
