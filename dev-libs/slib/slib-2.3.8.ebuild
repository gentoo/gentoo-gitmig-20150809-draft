# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/slib/slib-2.3.8.ebuild,v 1.1 2000/09/18 21:44:42 achim Exp $

P=slib2c8
A=${P}.zip
S=${WORKDIR}/slib
DESCRIPTION=""
SRC_URI="http://swissnet.ai.mit.edu/ftpdir/scm/${A}"
HOMEPAGE="http://swissnet.ai.mit.edu/~jaffer/SLIB.html"


src_install () {

    cd ${S}
    insinto /usr/share/guile/site/slib
    doins *.scm
    dodoc ANNOUNCE ChangeLog FAQ README 
    doinfo slib.info
}

pkg_postinst () {

    if [ "${ROOT}" == "/" ]
    then
       guile -c "(use-modules (ice-9 slib)) (require 'new-catalog)" "/" 
    fi
}
