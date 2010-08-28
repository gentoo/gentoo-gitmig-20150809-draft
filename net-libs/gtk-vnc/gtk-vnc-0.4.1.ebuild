# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gtk-vnc/gtk-vnc-0.4.1.ebuild,v 1.4 2010/08/28 21:45:53 eva Exp $

EAPI="2"

inherit base gnome.org

DESCRIPTION="VNC viewer widget for GTK."
HOMEPAGE="http://live.gnome.org/gtk-vnc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples python sasl"

# libview is used in examples/gvncviewer -- no need
# TODO: review nsplugin when it will be considered less experimental

RDEPEND=">=x11-libs/gtk+-2.18:2
	>=net-libs/gnutls-1.4
	x11-libs/cairo
	x11-libs/libX11
	python? ( >=dev-python/pygtk-2 )
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.35"

src_configure() {
	econf \
		$(use_with examples) \
		$(use_with python) \
		$(use_with sasl) \
		--with-coroutine=gthread \
		--without-libview \
		--with-gtk=2.0 \
		--disable-introspection \
		--disable-static
}

src_install() {
	# bug #328273
	MAKEOPTS="${MAKEOPTS} -j1" \
		base_src_install
	dodoc AUTHORS ChangeLog NEWS README || die
}
