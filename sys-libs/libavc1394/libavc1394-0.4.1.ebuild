# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libavc1394/libavc1394-0.4.1.ebuild,v 1.5 2003/06/22 05:10:31 seemant Exp $

DESCRIPTION="libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set."
HOMEPAGE="http://sourceforge.net/projects/libavc1394/"
LICENSE="LGPL-2.1"
SRC_URI="mirror://sourceforge/libavc1394/${P}.tar.gz"
S=${WORKDIR}/${P}
IUSE=""
DEPEND=">=libraw1394-0.8"
SLOT="0"
KEYWORDS="x86 ~ppc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
