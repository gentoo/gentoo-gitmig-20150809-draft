# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/apache-manual/apache-manual-2.0.49.ebuild,v 1.1 2004/04/28 13:45:45 zul Exp $

DESCRIPTION="The full apache manual."
HOMEPAGE="http://www.apache.org"
SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz"
KEYWORDS="~x86 ~ppc ~hppa ~mips ~sparc ~amd64 ~ia64"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="=net-www/apache-2*"

IUSE=""

S="${WORKDIR}/httpd-${PV}"

src_compile() {
	einfo "Nothing to do."
}

src_install() {
	dodir /usr/share/doc/html/${PF}
	cp -rp ${S}/docs/manual ${D}/usr/share/doc/html/${PF}

	if [ -d /usr/share/doc/html/${PF} ];
	then
		rm -f /usr/share/doc/html/${PF}
		dosym /usr/share/doc/html/${PF}/manual /usr/share/doc/html/manual
	else
		dosym /usr/share/doc/html/${PF}/manual /usr/share/doc/html/manual
	fi

	insinto /etc/apache2/conf/addon-modules
	doins ${FILESDIR}/apache_manual.conf
}
