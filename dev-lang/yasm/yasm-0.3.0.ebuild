# Copyright 2003-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yasm/yasm-0.3.0.ebuild,v 1.1 2004/02/09 08:02:58 augustus Exp $

DESCRIPTION="assembler that supports amd64"
HOMEPAGE="http://www.tortall.net/projects/yasm/"
SRC_URI="http://www.tortall.net/projects/yasm/releases/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND="${DEPEND}"

src_install() {
    make DESTDIR=${D} install || die

    dodoc AUTHORS COPYING INSTALL Artistic.txt BSD.txt GNU_GPL-2.0 GNU_LGPL-2.0
}
