# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.2.ebuild,v 1.2 2003/07/02 11:55:13 aliz Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync." 
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gnome"

DEPEND="virtual/glibc
	app-pda/synce-libsynce"

src_compile() {
	econf
	emake || die 
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
