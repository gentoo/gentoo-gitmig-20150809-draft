# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libavc1394/libavc1394-0.4.1.ebuild,v 1.14 2004/10/19 17:52:33 kloeri Exp $

DESCRIPTION="library for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set"
HOMEPAGE="http://sourceforge.net/projects/libavc1394/"
SRC_URI="mirror://sourceforge/libavc1394/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha"
IUSE=""

DEPEND=">=sys-libs/libraw1394-0.8"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
