# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gtk-vnc/gtk-vnc-0.4.2_pre20100917.ebuild,v 1.1 2010/10/13 21:22:02 cardoe Exp $

EAPI="2"

inherit base
# gnome.org

DESCRIPTION="VNC viewer widget for GTK."
HOMEPAGE="http://live.gnome.org/gtk-vnc"

SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	dev-perl/Text-CSV
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
