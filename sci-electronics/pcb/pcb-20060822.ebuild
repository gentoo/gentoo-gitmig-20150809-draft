# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/pcb/pcb-20060822.ebuild,v 1.1 2006/09/02 14:26:43 calchan Exp $

inherit eutils

DESCRIPTION="tool for the layout of printed circuit boards"
HOMEPAGE="http://pcb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
	media-libs/gd"
DEPEND="${RDEPEND}
	=dev-lang/tk-8*
	|| (
		virtual/x11
		x11-proto/xproto
	   )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/\(^START-INFO\)/INFO-DIR-SECTION Miscellaneous\n\1/' doc/pcb.info || die "sed failed"
}

src_compile() {
	econf --disable-dependency-tracking || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
	newicon win32/pcb_icon_big.xpm pcb.xpm
	make_desktop_entry pcb PCB pcb.xpm Electronics
}
