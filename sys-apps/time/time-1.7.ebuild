# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/time/time-1.7.ebuild,v 1.2 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A command that displays info about resources used by a program"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/time/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/time.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
        ./configure --prefix=/usr \
                --mandir=/usr/share/man || die
        emake || die
}

src_install () {
        make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install || die
        dodoc ChangeLog COPYING README
        dodoc AUTHORS NEWS
}

