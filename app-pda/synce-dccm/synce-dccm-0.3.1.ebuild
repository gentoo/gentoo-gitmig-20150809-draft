# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-dccm/synce-dccm-0.3.1.ebuild,v 1.1 2002/11/28 10:10:51 zwelch Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync." 
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/synce/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome"
DEPEND="virtual/glibc
	app-pda/synce-libsynce"

src_compile() {
	econf || die
	emake || die 
}

src_install() {
	make DESTDIR="${D%/}" install || die
}

