# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sjog/sjog-0.6.ebuild,v 1.5 2004/03/14 10:53:19 mr_bones_ Exp $

DESCRIPTION="sjog - tool for the Sony Vaio jogdial"
HOMEPAGE="http://sjog.sourceforge.net/"
SRC_URI="mirror://sourceforge/sjog/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	=dev-libs/glib-1.2*"

src_compile() {
	econf

	emake || die
}

src_install() {
	einstall
}
