# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.8-r1.ebuild,v 1.1 2005/08/27 09:06:32 svyatogor Exp $

inherit virtualx multilib eutils

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~ppc"
IUSE="nls spell dbus srv"

DEPEND=">=dev-python/pygtk-2.4.0
	>=dev-lang/python-2.3.0
	>=x11-libs/gtk+-2.4
	spell? ( >=app-text/gtkspell-2.0.4 )
	!alpha? ( dbus? ( >=sys-apps/dbus-0.23 ) )
	srv? ( >=dev-python/dnspython-1.3.3 )"

src_compile() {
	targets="idle trayicon"
	use nls && targets="${targets} translation"
	use spell && targets="${targets} gtkspell"
	Xemake ${targets} || die "Xmake failed"
}

src_install() {
	Xemake PREFIX=/usr DESTDIR=${D} LIBDIR=/$(get_libdir) install || die
	dodoc README AUTHORS COPYING
}
