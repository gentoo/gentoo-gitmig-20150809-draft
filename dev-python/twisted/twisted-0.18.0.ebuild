# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/Twisted-${PV}
DESCRIPTION="Twisted is a collection of servers and clients, which can be used either by developers of new applications or directly. Documentation included." 
SRC_URI="http://www.twistedmatrix.com/downloads/Twisted-${PV}.tar.bz2"
HOMEPAGE="http://www.twistedmatrix.com/"
LICENSE="LGPL-2.1"
SLOT="0"
DEPEND="virtual/python"
RDEPEND="$DEPEND"
KEYWORDS="x86 sparc sparc64"

src_compile() {
        python setup.py build || die
}

src_install() {
        python setup.py install --root=${D} --prefix=/usr || die
        # next few lines will install docs: 9.4 megs! 
        dodir /usr/share/doc/${PF}
        # of course it's documentation!
        cd doc
        cp -r . ${D}/usr/share/doc/${PF}
        cd ../
        rm -rf doc/man  # don't dupe the man pages
        doman doc/man/*
        dodoc README TODO CREDITS
}
