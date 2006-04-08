# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libavc1394/libavc1394-0.5.0.ebuild,v 1.5 2006/04/08 18:11:59 blubb Exp $

DESCRIPTION="library for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set"
HOMEPAGE="http://www.linux1394.org/ http://sourceforge.net/projects/libavc1394/"
SRC_URI="mirror://sourceforge/libavc1394/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/libraw1394-0.8"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
