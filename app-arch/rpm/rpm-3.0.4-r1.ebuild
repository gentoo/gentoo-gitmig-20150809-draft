# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-3.0.4-r1.ebuild,v 1.3 2000/08/23 07:00:07 drobbins Exp $

P=rpm-3.0.4
A="${P}.tar.gz bzip2-0.9.5d.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${P}.tar.gz
	 ftp://ftp.kernel.org/pub/software/utils/compress/bzip2/bzip2-0.9.5d.tar.gz"
HOMEPAGE="http://www.rpm.org/"

src_unpack () {
    unpack ${P}.tar.gz
    unpack bzip2-0.9.5d.tar.gz
    cd ${WORKDIR}/bzip2-0.9.5d
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {
    cd ${WORKDIR}/bzip2-0.9.5d
    make $MAKEOPTS "MAKE = make $MAKEOPTS" all
    cd ${S}
    export CFLAGS="-I ${WORKDIR}/bzip2-0.9.5d ${CFLAGS} -L ${WORKDIR}/bzip2-0.9.5d -lbz2"
    # there is no shared Version of bzlib so we can only build the static version :-(
    ./configure --prefix=/usr --with-catgets
    make
}

src_install() {
    make DESTDIR=${D} install
    mv ${D}/bin/rpm ${D}/usr/bin
    rm -rf ${D}/bin
    if [ -z "$DBUG" ]
    then
        strip ${D}/usr/bin/*
    #    strip --strip-unneeded ${D}/usr/lib/*.so*
    fi
    prepman
    for i in ja pl ru
    do
      gzip -9 ${D}/usr/man/$i/man8/*.8
    done
    cd ${S}
    dodoc CHANGES COPYING CREDITS GROUPS README* RPM* TODO
    cd ${WORKDIR}/bzip2-0.9.5d
    insinto /usr/lib/rpm
    doins libbz2.a
}




