# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.5.8-r1.ebuild,v 1.8 2002/08/02 17:42:49 phoenix Exp $

# this r1 is a major change. it uses sed instead of patches.
# hopefully this will enable everyone to compile gv on widely
# different configurations, eliminating the gv.man/gv._man problem

S=${WORKDIR}/${P}

DESCRIPTION="gv is a standard ghostscript frontend used e.g. by LyX"

SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gv/unix/${P}.tar.gz"
HOMEPAGE="http://wwwthep.physik.uni-mainz.de/~plass/gv/"
SLOT="0"
LICENSE="GPL-2"

# There's probably more, but ghostscript also depends on it,
# so I can't identify it
DEPEND="virtual/x11 x11-libs/Xaw3d app-text/ghostscript"
KEYWORDS="ppc x86"
src_unpack() {
    
    # need to check if this can be done automatically
    
    unpack ${P}.tar.gz
    cd ${S}
    
}

src_compile() {
    
    cd ${S}
    
    cp config.Unix 1
    sed -e 's/usr\/local/usr/' 1 > config.Unix
    rm 1
    
    try xmkmf
    try make Makefiles
    
    cd source

    cp Makefile 1
    cat 1 | sed -e 's/install.man:: gv.man/install.man::/' \
		-e 's/all:: gv./\#all:: gv./' \
		-e '/gv.man/ c \#removed by sed for ebuilding' > Makefile
    rm 1
    if [ ! "`grep gv.man Makefile`" = "" ];
    then
	echo "sed didn't completely remove gv.man references from the Makefile.
We'll just run make and pray."
	sleep 2s
    fi
    

    cd ${S}
    try emake
    
}

src_install () {
    
    cd ${S}
    try make DESTDIR=${D} install
    # try make DESTDIR=${D} install.man # don't use this!!!
    try make DESTDIR=${D} install.doc
    
    cd ${S}/doc
    cp gv.man gv.man.1
    doman gv.man.1
    
}

