# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/magicfilter/magicfilter-1.2.ebuild,v 1.1 2001/09/08 14:33:06 agriffis Exp $

A=magicfilter-1.2.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Customizable, extensible automatic printer filter"
SRC_URI="ftp://metalab.unc.edu/pub/linux/system/printing/${A}"
HOMEPAGE="http://www.gnu.org/directory/magicfilter.html"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_unpack() {
    cd ${WORKDIR}
    unpack ${A}
    # This is the patch directly from the Debian package.  It's included
    # here (instead of fetching from Debian) because their package
    # revisions will change faster than this ebuild will keep up...
    cd ${S}
    patch -p1 < ${FILESDIR}/magicfilter_1.2-39.diff
}

src_compile() {
    cd ${S}
    ./configure --host="${CHOST}" || die
    emake
    # Fixup the filters for /usr/sbin/magicfilter
    cd filters
    for f in *-filter; do
	mv $f $f.old
	( read l; echo '#!/usr/sbin/magicfilter'; cat ) <$f.old >$f
    done
}

src_install() {
    cd ${S}
    dodir /usr/sbin /usr/share/man/man8 /etc/magicfilter
    install -m 755 magicfilter ${D}/usr/sbin
    install -m 755 magicfilter.man ${D}/usr/share/man/man8/magicfilter.8
    install -m 755 magicfilterconfig ${D}/usr/sbin
    install -m 644 magicfilterconfig.8 ${D}/usr/share/man
    cp -p filters/*-filter ${D}/etc/magicfilter
    # Should these eventually be made into a patch...?
    install -m 755 ${FILESDIR}/*-filter ${D}/etc/magicfilter
    install -m 755 ${FILESDIR}/escp-text-helper ${D}/etc/magicfilter
    gzip -9f ${D}/usr/share/man/*/*
    gzip -9f filters/README*
    dodoc README QuickInst TODO debian/copyright 
    docinto filters
    dodoc filters/README*
}
