# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kstars/kstars-0.6.ebuild,v 1.1 2001/09/13 04:02:15 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A desktop planetarium for KDE2"
HOMEPAGE="http://kstars.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz
         http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

DEPEND=">=kde-base/kdelibs-2.1
        objprelink? ( dev-util/objprelink )"

src_unpack() {
    unpack ${P}.tar.gz
    cd ${S}
    use objprelink && patch -p0 < ${DISTDIR}/kde-admin-acinclude.patch
}

src_compile() {
    local myconf
    use qtmt && myconf="${myconf} --enable-mt"
    ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf || die
    make || die
}

src_install () {
    # ugh.
    patch -p0 < ${FILESDIR}/destdir-icons.diff
    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog README TODO
}
