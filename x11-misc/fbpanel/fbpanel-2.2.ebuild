# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-2.2.ebuild,v 1.3 2003/11/16 23:15:02 pyrania Exp $

DESCRIPTION="fbpanel is a light-weight X11 desktop panel"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://fbpanel.sourceforge.net/"
IUSE=""

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"
DEPEND=">=x11-libs/gtk+-1.2
	media-libs/gdk-pixbuf"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die
}

src_install () {
	dobin ${S}/fbpanel
	dodoc README CREDITS COPYING
	docinto config
	dodoc config/*
}
