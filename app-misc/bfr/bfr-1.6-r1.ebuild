# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfr/bfr-1.6-r1.ebuild,v 1.3 2005/06/06 16:12:46 slarti Exp $

DESCRIPTION="Buffer (bfr) is a general-purpose command-line pipe buffer"
HOMEPAGE="http://www.glines.org/software/buffer.html"
SRC_URI="http://www.glines.org/bin/pk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS INSTALL ChangeLog NEWS README TODO
}
