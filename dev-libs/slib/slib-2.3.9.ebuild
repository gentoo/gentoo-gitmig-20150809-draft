# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/slib/slib-2.3.9.ebuild,v 1.1 2000/11/26 20:54:17 achim Exp $

P=slib2c9
A=${P}.zip
S=${WORKDIR}/slib
DESCRIPTION=""
SRC_URI="http://swissnet.ai.mit.edu/ftpdir/scm/${A}"
HOMEPAGE="http://swissnet.ai.mit.edu/~jaffer/SLIB.html"

DEPEND=">=app-arch/unzip-5.21
	>=dev-util/guile-1.4"

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
        echo "Installing..."
       guile -c "(use-modules (ice-9 slib)) (require 'new-catalog)" "/" 
    fi
}

