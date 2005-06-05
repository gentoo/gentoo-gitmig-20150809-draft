# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.7.1.ebuild,v 1.1 2005/06/05 13:31:38 sergey Exp $

inherit virtualx

DESCRIPTION="Jabber client written in PyGTK."
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64"
IUSE=""

DEPEND=">=dev-python/pygtk-2.4.0
	>=dev-lang/python-2.3.0
	>=x11-libs/gtk+-2.4"

src_compile() {
	Xmake || die "Xmake failed"
}
src_install() {
	Xmake DESTDIR=${D} install || die
	dodoc README AUTHORS COPYING
}
