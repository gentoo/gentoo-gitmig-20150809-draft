# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shell/xmms-shell-0.99.0-r1.ebuild,v 1.6 2003/04/25 14:15:10 vapier Exp $

DESCRIPTION="simple utility to control XMMS externally"
SRC_URI="http://download.sourceforge.net/xmms-shell/${P}.tar.gz"
HOMEPAGE="http://www.loganh.com/xmms-shell/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="readline"

DEPEND=">=media-sound/xmms-1.2.7
	readline? ( >=sys-libs/readline-4.1 )"

src_unpack() {
	unpack ${A}
	# shall be sent upstream
	patch -p0 <${FILESDIR}/${PN}-gcc3.patch
}

src_compile() {
	econf `use_with readline` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}
