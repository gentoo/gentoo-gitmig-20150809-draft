# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/latex2html/latex2html-2000.1b.ebuild,v 1.1 2001/06/27 01:31:12 tadpol Exp $

#darn weird naming...
P=latex2html-2K.1beta
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="LATEX2HTML is a convertor written in Perl that converts LATEX documents to HTML."
SRC_URI=" http://saftsack.fs.uni-bayreuth.de/~latex2ht/current/${A}"
HOMEPAGE="http://www.latex2html.org"

DEPEND="virtual/glibc"

RDEPEND="sys-devel/perl
	app-text/ghostscript
	media-libs/netpbm
	app-text/tetex
	"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make
    try make check
#    try make test
}

src_install () {
    # modify cfgcache.pm
    [ -f cfgcache.pm.backup ] && mv cfgcache.pm.backup cfgcache.pm
    cat cfgcache.pm | sed -e "/BINDIR/s:/usr/bin:${D}usr/bin:" \
                          -e "/LIBDIR/s:/usr/lib:${D}usr/lib:" \
                          -e "/TEXPATH/s:/usr/share:${D}usr/share:" \
                          -e '/MKTEXLSR/s:/usr/bin/mktexlsr::' > cfgcache.NEW
    mv cfgcache.pm cfgcache.pm.backup
    mv cfgcache.NEW cfgcache.pm
    
    dodir /usr/bin /usr/lib/latex2html /usr/share/texmf/tex/latex/html
    try make install

    cp cfgcache.pm.backup ${D}/usr/lib/latex2html/cfgcache.pm
    #Install docs
    dodoc BUGS Changes FAQ INSTALL LICENSE MANIFEST README TODO
}

pkg_postinst() {
    einfo "Running mktexlsr to rebuild ls-R database...."
    mktexlsr
}


# vim: ai et sw=4 ts=4
