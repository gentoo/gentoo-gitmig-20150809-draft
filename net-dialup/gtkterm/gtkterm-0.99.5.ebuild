# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gtkterm/gtkterm-0.99.5.ebuild,v 1.4 2006/01/02 17:36:19 hansmi Exp $

DESCRIPTION="A serial port terminal written in GTK+, similar to Windows' HyperTerminal."
HOMEPAGE="http://www.jls-info.com/julien/linux/"
SRC_URI="http://www.jls-info.com/julien/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	x11-libs/vte"

src_compile() {
	econf ${myconf} || die './configure failed'
	emake || die
}

src_install() {
	einstall || die
}
