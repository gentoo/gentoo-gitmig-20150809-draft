# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/apache-manual/apache-manual-2.0.49-r3.ebuild,v 1.2 2004/06/04 12:48:15 zul Exp $

MY_VERSION="${PV}-r3"

DESCRIPTION="Configures the apache manual for local viewing"
HOMEPAGE="http://www.apache.org/"
SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz"

KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64 s390"
SLOT="0"
LICENSE="Apache-2.0"
IUSE=""

DEPEND="=net-www/apache-2*
	>=sys-apps/sed-4"
RDEPEND=""

src_compile() {
	einfo "Nothing to do."
}

src_install() {
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/00_apache_manual.conf
	sed -i -e "s:2.0.49:${MY_VERSION}:" ${D}/etc/apache2/conf/modules.d/00_apache_manual.conf
}
