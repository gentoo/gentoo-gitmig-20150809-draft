# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/krecord/krecord-1.16.ebuild,v 1.1 2005/10/17 15:17:53 greg_g Exp $

inherit kde-functions

DESCRIPTION="A KDE sound recorder."
HOMEPAGE="http://bytesex.org/krecord.html"
SRC_URI="http://dl.bytesex.org/releases/krecord/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=kde-base/kdelibs-3"

set-kdedir 3

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" \
	     prefix=/usr \
	     appsdir="${D}/usr/share/applnk/Multimedia" \
	     datadir="${D}/usr/share/apps/krecord" \
	     htmldir="${D}/usr/share/doc/HTML/en/krecord" \
	     install || die

	dodoc Changes README VERSION
}
