# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/slib/slib-2.4.1.ebuild,v 1.1 2001/05/06 16:43:00 achim Exp $

P=slib2d1
A=${P}.zip
S=${WORKDIR}/slib
DESCRIPTION=""
SRC_URI="http://swissnet.ai.mit.edu/ftpdir/scm/${A}"
HOMEPAGE="http://swissnet.ai.mit.edu/~jaffer/SLIB.html"

DEPEND=">=app-arch/unzip-5.21
	>=dev-util/guile-1.4
	>=dev-libs/g-wrap-0.9.5"

src_install () {

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

