# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Terry Chan <tchan@enteract.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}
DESCRIPTION="Smart decoder/encoder for Mime, [uu|xx]encoded and Binhex files."
SRC_URI="http://www.fpx.de/fp/Software/UUDeview/download/${P}.tar.gz"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
DEPEND="virtual/glibc"
#RDEPEND=""

src_compile() {
	./configure --mandir=/usr/share/man --prefix=/usr --disable-minews || die
	emake || die
}

src_install () {
	dodoc HISTORY
	doman man/uu*.1
        dobin unix/uudeview unix/uuenview
}

