# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-0.10.1.ebuild,v 1.3 2004/12/04 20:00:44 corsair Exp $

inherit gnuconfig

DESCRIPTION="library that provides direct access to the IEEE 1394 bus"
HOMEPAGE="http://sourceforge.net/projects/libraw1394/"
SRC_URI="http://www.linux1394.org/files/${PN}/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}
