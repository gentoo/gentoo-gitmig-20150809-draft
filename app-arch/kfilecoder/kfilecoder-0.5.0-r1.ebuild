# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/kfilecoder/kfilecoder-0.5.0-r1.ebuild,v 1.6 2001/09/19 19:37:47 danarmak Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Archiver with passwd management "
SRC_URI="http://download.sourceforge.net/kfilecoder/${A}"
HOMEPAGE="http://kfilecoder.sourceforge.net"

DEPEND=">=kde-base/kdebase-2.1.1"

RDEPEND=$DEPEND

src_compile() {
    rm config.cache
    ./configure --host=${CHOST} || die
    make || die

}

src_install () {
    make DESTDIR=${D} kde_locale=${D}${KDEDIR}/share/locale install || die
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

