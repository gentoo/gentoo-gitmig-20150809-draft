# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/gentoo-guide-xml-dtd/gentoo-guide-xml-dtd-1.0.ebuild,v 1.1 2001/03/25 22:11:06 achim Exp $

S=${WORKDIR}
DESCRIPTION="DTD for Gentoo-Guide Style XML Files"

DEPEND=">=app-text/sgml-common-0.6.1"

src_install () {

    cd ${FILESDIR}

    insinto /usr/share/sgml/gentoo
    doins catalog
    insinto /usr/share/sgml/gentoo/ent
    doins ent/*.ent
    insinto /usr/share/sgml/gentoo/guide
    doins guide/*.dtd


}

pkg_postinst() {
    install-catalog --add /etc/sgml/gentoo-guide.cat /usr/share/sgml/gentoo//catalog
}

pkg_prerm() {
    install-catalog --remove /etc/sgml/gentoo-guide.cat /usr/share/sgml/gentoo//catalog
}
