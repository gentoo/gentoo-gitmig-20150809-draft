# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gini/gini-0.5.1.ebuild,v 1.1 2003/12/18 21:34:20 mholzer Exp $

IUSE=""

DESCRIPTION="gini is a free streaming media server for unix-like operating systems"
HOMEPAGE="http://gini.sf.net"
SRC_URI="mirror://sourceforge/gini/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

DEPEND="dev-libs/glib"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS BUGS README TODO COPYING ChangeLog INSTALL NEWS
}
