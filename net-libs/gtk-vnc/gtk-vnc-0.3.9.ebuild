# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gtk-vnc/gtk-vnc-0.3.9.ebuild,v 1.1 2009/09/06 15:15:18 nirbheek Exp $

EAPI="2"

inherit base gnome.org

DESCRIPTION="VNC viewer widget for GTK."
HOMEPAGE="http://live.gnome.org/gtk-vnc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples python sasl"

# libview is used in examples/gvncviewer -- no need
# TODO: review nsplugin when it will be considered less experimental

RDEPEND=">=x11-libs/gtk+-2.10
	>=net-libs/gnutls-1.4
	x11-libs/cairo
	python? ( >=dev-python/pygtk-2 )
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_with examples) \
		$(use_with python) \
		$(use_with sasl) \
		--with-coroutine=gthread \
		--without-libview
}
