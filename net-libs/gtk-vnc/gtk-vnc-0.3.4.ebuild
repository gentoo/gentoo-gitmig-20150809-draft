# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gtk-vnc/gtk-vnc-0.3.4.ebuild,v 1.3 2008/04/24 18:10:01 corsair Exp $

inherit gnome2

DESCRIPTION="VNC viewer widget for GTK."
HOMEPAGE="http://gtk-vnc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="debug python opengl"

# what shall we do about libview
RDEPEND=">=x11-libs/gtk+-2.10
	>=net-libs/gnutls-1.4
	python? ( >=dev-python/pygtk-2 )
	opengl? ( >=x11-libs/gtkglext-1.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_with python)
		$(use_with opengl gtkglext)
		--with-coroutine=gthread
		--without-libview"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
