# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/birthday/birthday-1.5.ebuild,v 1.2 2003/02/13 08:53:07 vapier Exp $

DESCRIPTION="Displays a list of events happening in the near future"
HOMEPAGE="http://users.zetnet.co.uk/mortia/source/"
SRC_URI="http://users.zetnet.co.uk/mortia/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/glibc"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}


