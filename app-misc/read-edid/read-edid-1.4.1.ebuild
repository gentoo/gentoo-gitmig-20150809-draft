# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/read-edid/read-edid-1.4.1.ebuild,v 1.3 2002/07/26 02:16:31 kabau Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Read edid is a program that can get information from a pnp monitor."
HOMEPAGE="http://john.fremlin.de/programs/linux/read-edid/index.html"
DEPEND=""
#RDEPEND=""
SRC_URI="http://john.fremlin.de/programs/linux/read-edid/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog LRMI NEWS README
}
