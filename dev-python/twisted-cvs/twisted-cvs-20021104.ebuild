# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-cvs/twisted-cvs-20021104.ebuild,v 1.5 2003/06/22 12:16:00 liquidx Exp $

ECVS_USER="anon"
ECVS_SERVER="twistedmatrix.com:/cvs"
ECVS_MODULE="Twisted"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Twisted is a framework, written in Python, for writing networked applications."
SRC_URI=""
HOMEPAGE="http://www.twistedmatrix.com/"
LICENSE="LGPL-2.1"
SLOT="0"
RDEPEND="virtual/python"
DEPEND="$DEPEND
        >=dev-python/epydoc-1.1
        >=dev-python/pycrypto-1.9_alpha4"
KEYWORDS="~x86 ~alpha"
IUSE=""

inherit distutils

src_compile() {
    distutils_src_compile
    ## .ps & pdf generation (book) sandbox violation ..
    ##${S}/admin/process-docs
    # from admin/release-twisted
#    cd ${S}
#    epydoc -o doc/api twisted/* &&
#    cp doc/api/index.html doc/api/index.html.bak &&
#    cp doc/api/epydoc-index.html doc/api/index.html
#    tree doc/api
}

src_install() {
    distutils_src_install
    
    # next few lines will install docs: 9.4 megs!
    dodir /usr/share/doc/${PF}
    # of course it's documentation!
    doman doc/man/*.[0-9n]
    rm -rf doc/man	# don't dupe the man pages
    cd doc
    cp -r . ${D}/usr/share/doc/${PF}
    cd ../
    
}

pkg_postinst() {
    echo
    einfo "This is for testing only! Do not submit bugs regarding this to"
    einfo "Bugzilla. Instead mail me at lordvan@gentoo.org"
    echo
}
