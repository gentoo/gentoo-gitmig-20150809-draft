# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/ccd2iso/ccd2iso-0.1.ebuild,v 1.2 2004/02/12 02:08:58 vapier Exp $

DESCRIPTION="Converts CloneCD images (popular under Windows) to ISOs"
HOMEPAGE="http://sourceforge.net/projects/ccd2iso/"
SRC_URI="mirror://sourceforge/ccd2iso/${PN}.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
