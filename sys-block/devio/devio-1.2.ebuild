# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/devio/devio-1.2.ebuild,v 1.1 2006/01/24 02:19:01 vapier Exp $

DESCRIPTION="correctly read (or write) a region of a block device"
HOMEPAGE="http://devio.sourceforge.net/"
SRC_URI="mirror://sourceforge/devio/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
