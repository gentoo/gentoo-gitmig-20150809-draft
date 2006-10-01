# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-1.2.1.ebuild,v 1.5 2006/10/01 12:50:08 dertobi123 Exp $

DESCRIPTION="library that provides direct access to the IEEE 1394 bus"
HOMEPAGE="http://www.linux1394.org/"
SRC_URI="mirror://sourceforge/libraw1394/${P}.tar.gz
	http://www.linux1394.org/dl/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ppc ppc64 sh ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
