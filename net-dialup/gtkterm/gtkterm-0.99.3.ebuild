# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gtkterm/gtkterm-0.99.3.ebuild,v 1.3 2004/04/16 16:37:31 weeve Exp $

DESCRIPTION="A serial port terminal written in GTK+, similar to Windows' HyperTerminal."
HOMEPAGE="http://www.jls-info.com/julien/linux/"
SRC_URI="http://www.jls-info.com/julien/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"
S=${WORKDIR}/${P}

src_compile() {
	econf ${myconf} || die './configure failed'
	emake || die
}

src_install() {
	einstall || die
}
