# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/pcb/pcb-20050315.ebuild,v 1.6 2006/02/06 07:53:49 phosphan Exp $

DESCRIPTION="tool for the layout of printed circuit boards"
HOMEPAGE="http://pcb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="Xaw3d"

RDEPEND=">=x11-libs/gtk+-2.4
		 Xaw3d? ( x11-libs/Xaw3d )"
DEPEND="${RDEPEND}
	|| (
		virtual/x11
		x11-proto/xproto
	   )
	=dev-lang/tk-8*"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/\(^START-INFO\)/INFO-DIR-SECTION Miscellaneous\n\1/' doc/pcb.info
}

src_compile() {
	local myconf=""
	use Xaw3d \
		&& myconf="--with-xaw=Xaw3d" \
		|| myconf="--with-xaw=Xaw"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
