# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/gentoo-guide-xml-dtd/gentoo-guide-xml-dtd-2.1.ebuild,v 1.4 2002/08/02 17:42:49 phoenix Exp $

S=${WORKDIR}
DESCRIPTION="DTD for Gentoo-Guide Style XML Files"
HOMEPAGE="http://www.gentoo.org"
LICENSE=""
KEYWORDS="x86"
SLOT="0"
DEPEND=">=app-text/sgml-common-0.6.1"

src_install () {

    cd ${FILESDIR}

    insinto /usr/share/sgml/guide
    doins catalog
    insinto /usr/share/sgml/guide/ent
    doins ent/*.ent
    insinto /usr/share/sgml/guide/xml-dtd-2.1
    newins guide/guide-2.1.dtd guide.dtd

}

pkg_postinst() {
    install-catalog --add /etc/sgml/gentoo-guide.cat /usr/share/sgml/guide/catalog
}

pkg_prerm() {
    install-catalog --remove /etc/sgml/gentoo-guide.cat /usr/share/sgml/guide/catalog
}
