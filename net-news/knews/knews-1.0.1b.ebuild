# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/knews/knews-1.0.1b.ebuild,v 1.1 2001/04/23 18:31:57 michael Exp $

#P=knews-1.0.1b
A=knews-1.0b.1.tar.gz
S=${WORKDIR}/knews-1.0b.1
DESCRIPTION="A threaded newsreader for X."
SRC_URI="http://www.matematik.su.se/~kjj/${A}"
HOMEPAGE="http://www.matematik.su.se/~kjj/"

DEPEND=">=x11-base/xfree-4.0
        >=media-libs/jpeg-6
	>=media-libs/libpng-1.0.9
	>=media-libs/compface-1.4"

# If knews used autoconf, we wouldn't need this patch.
src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch
}

src_compile() {
    try xmkmf
    try make Makefiles
    try make clean
    try make all
    try pushd util/knewsd
    try xmkmf
    try make all
    try popd
}

src_install () {
    #Install knews
    try make DESTDIR=${D} install
    try make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
             MANPATH=/usr/share/man MANSUFFIX=1 install.man

    #Install knewsd
    try pushd util/knewsd
    try make DESTDIR=${D} install
    try make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
             MANPATH=/usr/share/man MANSUFFIX=1 install.man
    try popd

    #Other docs.
    dodoc COPYING COPYRIGHT Changes README
}

