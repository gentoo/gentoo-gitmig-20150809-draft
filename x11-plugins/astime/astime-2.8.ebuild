# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/astime/astime-2.8.ebuild,v 1.1 2003/06/17 00:03:17 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Analogue clock utility for X Windows."
HOMEPAGE="http://www.tigr.net/"
SRC_URI="http://www.tigr.net/afterstep/download/astime/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jpeg"

DEPEND="virtual/x11
        jpeg? ( media-libs/jpeg )"

src_compile() {
	local myconf
	use jpeg || myconf="--disable-jpeg"

	econf $myconf
	emake 
}

src_install () {
	into /usr

	mv astime.man astime.1
	doman astime.1

	dobin astime
	dodoc README INSTALL LICENSE
}
