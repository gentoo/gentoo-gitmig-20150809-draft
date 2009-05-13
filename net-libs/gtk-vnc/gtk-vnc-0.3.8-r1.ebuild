# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gtk-vnc/gtk-vnc-0.3.8-r1.ebuild,v 1.1 2009/05/13 10:31:15 leio Exp $

EAPI=2

inherit base

DESCRIPTION="VNC viewer widget for GTK."
HOMEPAGE="http://gtk-vnc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples python"

# what shall we do about libview
# TODO: review nsplugin when it will be considered less experimental

RDEPEND=">=x11-libs/gtk+-2.10
	>=net-libs/gnutls-1.4
	x11-libs/cairo
	python? ( >=dev-python/pygtk-2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_with examples) \
		$(use_with python) \
		--with-coroutine=gthread \
		--without-libview
}
