# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gtkterm/gtkterm-0.99.3.ebuild,v 1.8 2005/02/28 22:56:30 astinus Exp $

DESCRIPTION="A serial port terminal written in GTK+, similar to Windows' HyperTerminal."
HOMEPAGE="http://www.jls-info.com/julien/linux/"
SRC_URI="http://www.jls-info.com/julien/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~sparc ~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"

src_compile() {
	econf ${myconf} || die './configure failed'
	emake || die
}

src_install() {
	einstall || die
}
