# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gtk-splitter/gtk-splitter-2.2.ebuild,v 1.3 2004/06/03 15:58:30 dholm Exp $

DESCRIPTION="split/combine files !"
HOMEPAGE="http://gtk-splitter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="crypt"

DEPEND=">=x11-libs/gtk+-2
	crypt? ( >=app-crypt/mhash-0.8 )"
RDEPEND=">=dev-util/pkgconfig-0.12"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
