# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfr/bfr-1.6.ebuild,v 1.6 2004/12/03 17:59:09 slarti Exp $

DESCRIPTION="Buffer (bfr) is a general-purpose command-line pipe buffer"
HOMEPAGE="http://www.glines.org:8000/software/buffer.html"
SRC_URI="http://www.glines.org:8000/bin/pk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~ppc64"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR=${S} install || die "install failed"
	dodoc AUTHORS INSTALL ChangeLog NEWS README TODO
}
