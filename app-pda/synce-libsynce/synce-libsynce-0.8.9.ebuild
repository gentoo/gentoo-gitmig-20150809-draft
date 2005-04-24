# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-libsynce/synce-libsynce-0.8.9.ebuild,v 1.7 2005/04/24 11:30:27 hansmi Exp $

inherit eutils

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-libs/check-0.8.3.1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/${P}-gcc33.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
