# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kstars/kstars-0.6.ebuild,v 1.2 2001/09/22 07:01:10 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fun and educational desktop planetarium program for KDE2"
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
    ./configure --prefix=/usr --host=${CHOST} ${myconf} ; assert
    make ; assert "couldnt compile :("
}

src_install () {
    # ugh. hopefully the authors next release will be fixed.
    patch -p0 < ${FILESDIR}/destdir-icons.diff ; assert "bad patchfile"
    make DESTDIR=${D} install ; assert
    dodoc AUTHORS COPYING ChangeLog README TODO
}
